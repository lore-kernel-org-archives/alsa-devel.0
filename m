From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: firewire-lib: permit to flush queued
 packets only in process context for better PCM period granularity
Date: Mon, 16 May 2016 18:55:40 +0900
Message-ID: <5739991C.9020607@sakamocchi.jp>
References: <1462987059-10020-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5ha8jwa19g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D1372619BE
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 11:55:44 +0200 (CEST)
In-Reply-To: <s5ha8jwa19g.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for applying this. And this is my last patches for Linux 4.7.

In this development period, for ALSA firewire stack, I did:
  * Apply delayed registration of sound card instance for all of drivers.
   * When registering it during bus-reset state of IEEE 1394 bus and
     userspace applications immediately start PCM substreams,
     corresponding packet streams are easily stopped. Additionally, some
     of audio and music units on IEEE 1394 bus are easily hung-up. This
     change is to avoid this situation, by postpone sound card
     registration 2 seconds after recorded bus-reset time.
  * Add tracepoints to dump a part of isochronous packet data.
   * This is to detect quirks of incoming packets from peer units, or
     for future development.
  * Cancel reuse of incoming packet parameter for outgoing packet
    parameter.
   * In some behaviours of peer units, we can see that the units don't
     expect drivers to perform as audio function block in IEC 61883-6.
     The reuse is over-engineering, and should be dropped for better
     usage of system resources.
  * Add support for M-Audio profire series.
  * Fix minor issues.

Past 8 months, since a development period for Linux 4.4, 152 patches
have been merged, and I got tired. In next development cycle for 4.8,
I'd like to have a rest from ALSA firewire stack.

I plan to do for 4.8:
  * Add APIs of control element set for ALSA userspace library.
  * Handle EPIPE error in ALSA Rawmidi core to stop substream in driver
    side.
  * Add tracepoints for refine processing of hardware parameter in ALSA
    PCM core, and obsolete DEBUG macro.

Pending issues (not yet scheduled):
  * Driver module to communicate between two Linux systems via
    PCM/Rawmidi interfaces.
  * Mmap implementation for hwdep character devices of firewire-tascam
    to share status and control messages transferred from units.
  * Driver module for a part of units in RME FireFace series.
  * Driver module for a part of units in Mark of the unicorn firewire
    series.
  * Propose in systemd project about udev rules for supported units.
  * Implement unique timestamping for Dice quirks.
  * Dynamic interval for software IRQ of IR/IT context.
  * Support 'No period wakeup', and work to enable 'timer scheduling' of
    PulseAudio.


Regards

Takashi Sakamoto

On May 12 2016 03:38, Takashi Iwai wrote:
> On Wed, 11 May 2016 19:17:39 +0200,
> Takashi Sakamoto wrote:
>>
>> These three commits were merged to improve PCM pointer granularity.
>> commit 76fb87894828 ("ALSA: firewire-lib: taskletize the snd_pcm_period_elapsed() call")
>> commit e9148dddc3c7 ("ALSA: firewire-lib: flush completed packets when reading PCM position")
>> commit 92b862c7d685 ("ALSA: firewire-lib: optimize packet flushing")
>>
>> The point of them is to handle queued packets not only in software IRQ
>> context of IR/IT contexts, but also in process context. As a result of
>> handling packets, period tasklet is scheduled when acrossing PCM period
>> boundary. This is to prevent recursive call of
>> 'struct snd_pcm_ops.pointer()' in the same context.
>>
>> When the pointer callback is executed in the process context, it's
>> better to avoid the second callback in the software IRQ context. The
>> software IRQ context runs immediately after scheduled in the process
>> context because few packets are queued yet.
>>
>> For the aim, 'pointer_flush' is used, however it causes a race condition
>> between the process context and software IRQ context of IR/IT contexts.
>>
>> Practically, this race is not so critical because it influences process
>> context to skip flushing queued packet and to get worse granularity of
>> PCM pointer. The race condition is quite rare but it should be improved
>> for stable service.
>>
>> The similar effect can be achieved by using 'in_interrupt()' macro. This
>> commit obsoletes 'pointer_flush' with it.
>>
>> Acked-by: Clemens Ladisch <clemens@ladisch.de>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>
> Applied, thanks.
>
>
> Takashi
