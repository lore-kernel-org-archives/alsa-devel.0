From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: Support for DSD streams
Date: Sat, 23 Mar 2013 21:53:59 +0200
Message-ID: <514E0857.8010201@sonarnerd.net>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
 <514CB2E2.9050003@sonarnerd.net> <514D927B.3080000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 270522652B9
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 20:54:01 +0100 (CET)
In-Reply-To: <514D927B.3080000@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On 03/23/2013 01:31 PM, Daniel Mack wrote:
> Ok, but how do you know about which interfaces are capable of handling
> that? Are you maintaining a white list?

It's all up to user configuration, just an option in GUI for it. There 
are still some devices where the support depends on firmware version 
(support was introduced as firmware upgrade) so white listing is not so 
feasible always. But the situation is getting better. However I don't 
want to maintain a white list of vendor/device id's inside my 
application. Also the same format works over S/PDIF or AES/EBU just fine 
(with dual-wire up to DSD128). So automatic detection is not always 
possible anyway.

However I'm hoping to get the relevant information through the audio API 
in future for all possible interfaces (IOW not S/PDIF or AES/EBU, but 
things like USB, Firewire, PCI(e) and ASoC). Since there many DAC chips 
that have support for DSD it makes sense.

> And does that mean these devices are also wrongly believed to have
> additional PCM interfaces? IOW: do they only work as DSD, breaking all
> applications that believe that they can use all devices that expose a
> PCM interface?

So far all devices have been supporting also PCM, but support for DSD128 
is already a problem. Since with DoP it would require 352.8k PCM sample 
rate support, but some devices can do PCM only up to 192 while being 
able to support DSD128. Currently there's no way to figure out such 
limitations through ALSA (unlike ASIO where sampling rate enumeration is 
completely separate for PCM and DSD). So application would assume that 
also 352.8 PCM is available.

> Can you show the contents of /proc/asound/cardX/stream0 for such a card
> maybe?
> Can you provide the output of "lsusb -v" for any of these?

There's nothing related to DSD there, because DoP is implemented in an 
FPGA behind the audio interface. Most common is the XMOS UAC2 
implementation. Just normal asynchronous UAC2.

For the rest it's device class "vendor specific".

> I'm afraid that adding a DSD format and teaching the driver quirks for
> interfaces that are known to support DSD would break applications that
> already expect to see a usual PCM interface.

Currently most interfaces support usual PCM, but in addition they 
support also DSD. So they have two native sample formats, but only one 
USB format. Except again the vendor specific ones where there tend to be 
two wire formats, like 3-byte 24-bit and byte stream for DSD.

> To be precise: which SND_PCM_FORMAT_* does your application accept, and
> what happens if it sees  SND_PCM_FORMAT_SPECIAL?

For PCM:
         SND_PCM_FORMAT_S16_LE
         SND_PCM_FORMAT_S16_BE
         SND_PCM_FORMAT_S24_LE
         SND_PCM_FORMAT_S24_BE
         SND_PCM_FORMAT_S32_LE
         SND_PCM_FORMAT_S32_BE
         SND_PCM_FORMAT_S18_3LE
         SND_PCM_FORMAT_S20_3LE
         SND_PCM_FORMAT_S24_3LE
         SND_PCM_FORMAT_S18_3BE
         SND_PCM_FORMAT_S20_3BE
         SND_PCM_FORMAT_S24_3BE
         SND_PCM_FORMAT_FLOAT_LE
         SND_PCM_FORMAT_FLOAT_BE
         SND_PCM_FORMAT_FLOAT64_LE
         SND_PCM_FORMAT_FLOAT64_BE

For DSD:
         SND_PCM_FORMAT_S8
         SND_PCM_FORMAT_U8
         SND_PCM_FORMAT_S24_LE
         SND_PCM_FORMAT_U24_LE
         SND_PCM_FORMAT_S24_BE
         SND_PCM_FORMAT_U24_BE
         SND_PCM_FORMAT_S32_LE
         SND_PCM_FORMAT_U32_LE
         SND_PCM_FORMAT_S32_BE
         SND_PCM_FORMAT_U32_BE
         SND_PCM_FORMAT_S24_3LE
         SND_PCM_FORMAT_U24_3LE
         SND_PCM_FORMAT_S24_3BE
         SND_PCM_FORMAT_U24_3BE

I'm currently using SND_PCM_FORMAT_U8 at 352800 for my raw DSD custom 
hacks, because it won't overlap with any real world PCM hardware... For 
DoP devices there are at least SND_PCM_FORMAT_S32_LE and 
SND_PCM_FORMAT_S24_3LE in use. XMOS uses the former one, IIRC Mytek with 
the TCAT Dice FW chipset uses the latter one (and the USB2 is vendor 
specific class).

I don't support SND_PCM_FORMAT_SPECIAL.

> As for the driver, I would not go any further than marking the streams
> as DSD, without touching the payload. The marker bytes as described in
> the DoP document could be handled by some sort of libasound convenience
> function maybe though.

OK, then I would most likely keep the payload packing as it is already...


	- Jussi
