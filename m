From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: commit bd5389278c96f585afcac4058420e4f3ac201d2a
 introduce big problem
Date: Tue, 8 Nov 2011 17:16:33 +0800
Message-ID: <CAHG8p1DmEcTs7Mzmy8F0Aon3SGog9q+CpOX7SS+vFFkmeVWGcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E07724157
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 10:16:33 +0100 (CET)
Received: by vcbfy13 with SMTP id fy13so187234vcb.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2011 01:16:33 -0800 (PST)
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

Hi Takash,

commit bd5389278c96f585afcac4058420e4f3ac201d2a
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Aug 21 01:18:00 2009 +0200

    pcm: workaround for avoiding automatic start in mmap mode

    In the normal mmap mode, the stream isn't started automatically even after
    the data >= start_threshold has been written.   However, in the
    mmap-emulation mode, the stream is started because it uses
    snd_pcm_write_areas() internally.

    As a workaround for this inconsistency, start_threshold value is changed
    dynamically in sw_parmams and mmap_commit callbacks in mmap-emul plugin.
    Meanwhile, start_threshold for slave PCM is set to boundary so that only
    this plugin (or the one over it) can control the start of the stream.

    This will fix problems in some apps using pulse plugin in the mmap mode.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>

src/pcm/pcm_mmap_emul.c

This commit caused codec using mmap-emul plugin can't work.
My config file list below:

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

Alsa will not send SNDRV_PCM_IOCTL_START to driver.
But if I revert this patch only, the sound will be bad. I guess there
must be something else to do.

Regards,
Scott
