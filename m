From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Nodes, Widgets,
	ELD and Digital Surround 5.1 (HDMI) Output?
Date: Fri, 5 Dec 2014 10:33:20 +0800
Message-ID: <CAN8cciZ5VmEPqC54NSjL-Txg+i-+9Ftvt0iEN-GVt6cAEEDWAg@mail.gmail.com>
References: <499A51023C98481A9A8BE9EBEFDDFD70@Lyra>
 <547EBCFF.5030204@canonical.com> <547EC2BF.3080601@gmail.com>
 <46543BFB759444F4B56F5153F4727DEE@Lyra>
 <548054D1.1000302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
 [209.85.192.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 283F1264F2D
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 03:33:21 +0100 (CET)
Received: by mail-qg0-f45.google.com with SMTP id f51so13620903qge.18
 for <alsa-devel@alsa-project.org>; Thu, 04 Dec 2014 18:33:20 -0800 (PST)
In-Reply-To: <548054D1.1000302@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: bencoxdev@gmail.com, ALSA Mailing list <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>> Hi Guys,
>>     Thank you for your input it's much appreciated.
>>     I have now produced the pulse audio log as suggested and it appears
that
>> when an attempt to open the Digital Surround 5.1 device, it fails with a
>> "No such file or directory" error. Here is a snippet of the log showing
the
>> error.
>> (   0.456|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:iec958-ac3-surround-51
>> (   0.456|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback
on Digital Surround 5.1 (IEC958/AC3) (iec958-ac3-surround-51)
>> (   0.456|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:1 with
SND_PCM_NO_AUTO_FORMAT ...
>> (   0.456|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:1
>> (   0.456|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device a52:1: No such file or directory
>> So I guess the next question is what is responsible for producing the
>> required device?
>
>
> This is not the correct device. This is a software encoder that is not
installed on your computer. It will degrade audio quality by compression,
eat CPU time, kill PulseAudio for exhausting the real-time budget, and is
generally not needed on HDMI, because HDMI can transport PCM 5.1 streams
just fine.

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_proc.c?id=c4920606757224d0c480f25839f1cef6901a2167

Multi channel lpcm seem need AC_WCAP_CHAN_CNT_EXT

+ if (wid_caps & AC_WCAP_STEREO) {
+ unsigned int chans;
+ chans = (wid_caps & AC_WCAP_CHAN_CNT_EXT) >> 13;
+ chans = ((chans << 1) | 1) + 1;
+ if (chans == 2)
+ snd_iprintf(buffer, " Stereo");
+ else
+ snd_iprintf(buffer, " %d-Channels", chans);
+ } else
