From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: alsa lib bug in 1.0.24
Date: Wed, 26 Oct 2011 14:32:27 +0800
Message-ID: <CAHG8p1AE4msAVsAQ3+EmvU4Nry7=Hhvp6Vbsqq3C_QcsUYTn1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AAB6103836
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Oct 2011 08:32:29 +0200 (CEST)
Received: by vws20 with SMTP id 20so1289442vws.38
	for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2011 23:32:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi and Mark,

When I use ad1836 and ad1938 with alsa lib 1.0.24, there is an error:

root:/> arecord -t wav -c 2 -d 3 -r 48000 -f S32_LE 1.wav
Recording WAVE '1.wav' : Signed 32 bit Little Endian, Rate 48000 Hz, Stereo
arecord: pcm_read:1773: read error: Input/output error

If I use S16_LE and S24_LE there is no error.
The drivers for ad1836 and ad1938 only support S32_LE.
My card config file lists below:

bfin-ad1836.pcm.default {
        @args [ CARD ]
        @args.CARD {
                type string
        }
        type plug
        slave.pcm {
                type mmap_emul
                slave.pcm {
                        type hw
                        card $CARD
                        format S32_LE
                        rate 48000
                }
        }
}

If I used alsa lib 1.0.18, S16_LE, S24_LE and S32_LE are all ok.
Is my config file wrong in new version lib?
It seems if the format is the same as driver supports it will get an error.

Regards,
Scott
