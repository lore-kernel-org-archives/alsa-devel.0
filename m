From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: commit bd5389278c96f585afcac4058420e4f3ac201d2a
 introduce big problem
Date: Tue, 8 Nov 2011 18:06:14 +0800
Message-ID: <CAHG8p1BZ5gV3xAb5QRgc1eEMQ9gB44y+8aoMPcP3R-Th5PESJw@mail.gmail.com>
References: <CAHG8p1DmEcTs7Mzmy8F0Aon3SGog9q+CpOX7SS+vFFkmeVWGcw@mail.gmail.com>
	<s5hbosngd04.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6640324353
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 11:06:15 +0100 (CET)
Received: by vcbfy13 with SMTP id fy13so215874vcb.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2011 02:06:14 -0800 (PST)
In-Reply-To: <s5hbosngd04.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

2011/11/8 Takashi Iwai <tiwai@suse.de>:
> At Tue, 8 Nov 2011 17:16:33 +0800,
> Scott Jiang wrote:
>>
>> Hi Takash,
>>
>> commit bd5389278c96f585afcac4058420e4f3ac201d2a
>> Author: Takashi Iwai <tiwai@suse.de>
>> Date: =A0 Fri Aug 21 01:18:00 2009 +0200
>>
>> =A0 =A0 pcm: workaround for avoiding automatic start in mmap mode
>>
>> =A0 =A0 In the normal mmap mode, the stream isn't started automatically =
even after
>> =A0 =A0 the data >=3D start_threshold has been written. =A0 However, in =
the
>> =A0 =A0 mmap-emulation mode, the stream is started because it uses
>> =A0 =A0 snd_pcm_write_areas() internally.
>>
>> =A0 =A0 As a workaround for this inconsistency, start_threshold value is=
 changed
>> =A0 =A0 dynamically in sw_parmams and mmap_commit callbacks in mmap-emul=
 plugin.
>> =A0 =A0 Meanwhile, start_threshold for slave PCM is set to boundary so t=
hat only
>> =A0 =A0 this plugin (or the one over it) can control the start of the st=
ream.
>>
>> =A0 =A0 This will fix problems in some apps using pulse plugin in the mm=
ap mode.
>>
>> =A0 =A0 Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>
>> src/pcm/pcm_mmap_emul.c
>>
>> This commit caused codec using mmap-emul plugin can't work.
>> My config file list below:
>>
>> bfin-ad1836.pcm.default {
>> =A0 =A0 =A0 =A0 @args [ CARD ]
>> =A0 =A0 =A0 =A0 @args.CARD {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type string
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 type plug
>> =A0 =A0 =A0 =A0 slave.pcm {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type mmap_emul
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 slave.pcm {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type hw
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card $CARD
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format S32_LE
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate 48000
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 }
>> }
>>
>> Alsa will not send SNDRV_PCM_IOCTL_START to driver.
>
> And how are you testing it? =A0The whole background is missing...
>
Sorry, I sent it to you in former mail. I post it again.

When I use ad1836 and ad1938 with alsa lib 1.0.24, there is an error:

root:/> arecord -t wav -c 2 -d 3 -r 48000 -f S32_LE 1.wav
Recording WAVE '1.wav' : Signed 32 bit Little Endian, Rate 48000 Hz, Stereo
arecord: pcm_read:1773: read error: Input/output error

If format isn't S32_LE, snd_pcm_plugin_readi will be called and
everything works fine.

Regards,
Scott
