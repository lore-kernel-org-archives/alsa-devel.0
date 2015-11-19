From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/8] ALSA: dice: constrain PCM
 substreams to current sampling transfer frequency
Date: Thu, 19 Nov 2015 12:34:56 +0900
Message-ID: <564D4360.8050503@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5ha8qbe6pm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 640D9261480
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 04:34:59 +0100 (CET)
In-Reply-To: <s5ha8qbe6pm.wl-tiwai@suse.de>
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

On Nov 18 2015 23:13, Takashi Iwai wrote:
> On Sun, 15 Nov 2015 10:25:28 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> This patchset adds a constrain to ALSA dice driver to start PCM
>> substreams and AMDTP packet transferring just at current sampling
>> transfer frequency.
>>
>> Dice hardware doesn't allow drivers to get supported combinations
>> between sampling rate and PCM channels. ALSA dice driver should follow
>> to the hardware design, though current ALSA driver has some
>> over-specifications. As a result, the driver has several issue and
>> brings inconvenience to users.
>>
>> This patchset consists of two parts:
>>   * 01-05: to add constrain to current sampling transfer frequency and related
>> 	  code cleanup
>>   * 06-08: to ensure and stabilize AMDTP packet transmission
>>
>> As a result, userspace applications can request PCM substreams at current
>> sampling transfer frequency. Therefore, when users want to start PCM
>> substreams at different rate, they should set the rate in advance by the
>> other ways (i.e. ffado-dbus-server/ffado-mixer).
>
> This sounds rather like a step backward.  Why can't the driver set the
> rate if it's the only first and exclusive user?

I think you misunderstanding about the main reason of this patch.

Users are allowed to set their favorite sampling rate to Dice device. 
But it should be achieved by ways except for PCM functionality in ALSA 
dice driver, due to some reasons.

Which part of this patchset should I explain? I described all of the 
reasons in each patch. Due to Dice framewotk, due to the design of unit 
drivers in Linux FireWire subsystem, due to basic principle for driver 
developers, and so on.


Thanks

Takashi Sakamoto
