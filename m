From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Thu, 1 Dec 2016 14:50:30 +0100 (CET)
Message-ID: <alpine.LNX.2.20.1612011450060.7660@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1611230916070.5938@localhost.localdomain>
 <s5hr35s0xh2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wj0-f195.google.com (mail-wj0-f195.google.com
 [209.85.210.195])
 by alsa0.perex.cz (Postfix) with ESMTP id A491626766C
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2016 14:50:33 +0100 (CET)
Received: by mail-wj0-f195.google.com with SMTP id jb2so26443178wjb.3
 for <alsa-devel@alsa-project.org>; Thu, 01 Dec 2016 05:50:33 -0800 (PST)
In-Reply-To: <s5hr35s0xh2.wl-tiwai@suse.de>
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
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
List-Id: alsa-devel@alsa-project.org

On Thu, 1 Dec 2016, Takashi Iwai wrote:

> Date: Thu, 1 Dec 2016 11:12:25
> From: Takashi Iwai <tiwai@suse.de>
> To: Enrico Mioso <mrkiko.rs@gmail.com>
> Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
> Subject: Re: [alsa-devel] Intel HDA audio on EEE PC 1101HGo
> 
> On Wed, 23 Nov 2016 09:19:07 +0100,
> Enrico Mioso wrote:
>>
>> Hello guys.
>> With the these last settings the system seems able to survive. However, I think I am a little bit drastic with these settings.
>>
>> here my hardware infos: I remember of being asked to send them as an attachment, so I'll do so.
>> No upload has been made: when the script aked me, I choosen "Save locally". But there is an "upload=true" or something like that at the beginning.
>
> The single_cmd is really the last resort, and it already means that
> something wrong in the codec/controller communication.
>
> What does actually crash and how is the exact symptom?  You seem to
> always cut the citation, so I cannot remember the exact issue.
> Please keep the normal ML style, no top-posting.
>
>
> thanks,
>
> Takashi
>

Sorry for the inconvenience. I usually did that because, when reading e-mails 
with a screen reader (e.g.: from my phone), having all the text preceeded by 
things like ">>" is a little bit unconfortable. But I understand this can be a 
problem, and ML worked this way since a long time I guess.

So I recap: my computyer identifies itself as:
ASUSTeK Computer INC. 1101HAG/1101HAG, BIOS 0102    08/17/2009
(it's an EEE PC and this message has been extracted from the dmesg, DMI data).

Once back, the HDA audio controller exhibited some strange behaviours, and in 
particular, audio wasn't routed the normal way when I plugged my headphones or 
unplugged them (so, if I din't wait for the controller to go in low-power 
mode, I could hear audio both form headphones and laptop speakers). Waiting 
instead, resulted in the controller working properly.
You suggested me a method to report back some useful infos, but I didn't do 
that, sorry. (I posted a mail with those infos some day ago if I am not wrong.)

Then time passed,and I upgraded my kernel to the git version I reported in my 
previous mail, and now btw I am following current -git kernel with this system.
I haven't noticed strange behaviours regarding audio routing, but it may well 
be due to lack of testing in this. But another strange thing started happening: 
in particular, kernel panics when an application tries to open the audio device 
(in my case it was Music Player Daemon, but also mplayer triggered it once).

So I tried setting power_save_controller and power_save both to 0 (yes, I know 
power_save_controller is a boolean)... I tried this without much reasoning if 
reasoning at all.
No matter, I could still observe a panic (a single one I think).
So I tried with single mode: and I did so because I think the driver reverted 
to single cmd mode at some point on this device, in the past.
Now the system doesn't panic anymore, still in my dmesg there are lots of messages like:
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hdac_bus_update_rirb: 2 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hdac_bus_update_rirb: 1 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hdac_bus_update_rirb: 1 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hdac_bus_update_rirb: 1 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hdac_bus_update_rirb: 1 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hdac_bus_update_rirb: 2 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hdac_bus_update_rirb: 3 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hdac_bus_update_rirb: 3 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hdac_bus_update_rirb: 2 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hdac_bus_update_rirb: 1 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hdac_bus_update_rirb: 1 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x80000000:0x0, last cmd=0x15f0900
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x15707c0
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x1470700
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23903a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33903a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33903a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33903a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239039
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339039
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339039
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239038
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239038
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339038
IPv6: ADDRCONF(NETDEV_UP): wlp1s0: link is not ready
snd_hdac_bus_update_rirb: 18 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239033
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a033
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339033
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339033
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239032
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a032
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339032
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339032
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
IPv6: ADDRCONF(NETDEV_UP): wlp1s0: link is not ready
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
IPv6: ADDRCONF(NETDEV_UP): wlp1s0: link is not ready
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239031
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339031
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339031
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339031
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239030
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339030
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339030
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339030
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902f
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902f
snd_hdac_bus_update_rirb: 42 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239026
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339026
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339026
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339026
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a027
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239027
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a027
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339027
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a028
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239028
snd_hdac_bus_update_rirb: 14 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902a
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a029
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239029
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a029
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339029
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239028
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a028
snd_hdac_bus_update_rirb: 42 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23901f
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33901f
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33901f
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33901f
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239020
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339020
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x339020
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a021
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a021
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239021
snd_hdac_bus_update_rirb: 50 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x15f0900
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x15707c0
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x1470740
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a02e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902e
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a02f
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23902f
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33a02f
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x33902f
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x23a030
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x239030
snd_hdac_bus_update_rirb: 82 callbacks suppressed
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a10
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00
systemd: 25 output lines suppressed due to ratelimiting





I see them being generated any time I cause a "beep" on the terminal, pressing for example backspace when there is nothing to delete left in the bash shell.
For the rest, anything seems to work properly in this mode, even knowing something isn't working as it should.

Regarding the generated panics, it wasn't possible for me to read them at least 
by myself, since userspace was gone too soon and the daemon process handling my 
braille display gone with it.
thank you for your help and patience. Sorry for inconveniences,
Enrico
