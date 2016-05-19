From: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v7 0/3] ASoC: cygnus: Add audio support for Broadcom
 Cygnus SoC
Date: Thu, 19 May 2016 13:35:46 -0700
Message-ID: <573E23A2.4020907@broadcom.com>
References: <1463514382-20930-1-git-send-email-simran.rai@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463514382-20930-1-git-send-email-simran.rai-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simran Rai <simran.rai-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arun Parameswaran <arunp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Simran <ssimran-9dxIMqZteN92k8UYLPwMnjbeG0kAcb9qIF+bQRCngqMxpvK4C0GaPQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Looks good Simran.

Mark, anything else for us to do before this driver can be accepted 
upstream?

On 16-05-17 12:46 PM, Simran Rai wrote:
> From: Simran <ssimran-9dxIMqZteN92k8UYLPwMnjbeG0kAcb9qIF+bQRCngqMxpvK4C0GaPQ@public.gmane.org>
>
> Hi,
>
> This patchset contains audio support for Broadcom's Cygnus SoC.
> It contains DT bindings and core audio driver. The audio driver supports
> both capture and playback of Audio PCM samples over I2S/TDM interface and
> provides playback support over SPDIF interface.
>
> This patchset is derived from a previously submitted patchset:
> http://lkml.iu.edu/hypermail/linux/kernel/1503.3/05434.html
>
> This patchset has been tested on Cygnus wireless audio bcm958305K board.
> It is based on v4.6-rc1 and is available from github:
>
> repo: https://github.com/Broadcom/cygnus-linux/tree/cygnus-sound-v7
>
> Changes from v6:
> - DT bindings acknowledged by Rob Herring
> Changes from v5:
> - Fix code style, e.g. change "if" statements to "switch" statements
> - Fix SPDIF output enable register field
> - Set BUFFER_PAIR_ENABLE for both mono, stereo and TDM modes
> - Reflect PCM bit formats for SPDIF, SSP and TDM as supported by
> hardware
> Changes from v4:
> - Fix power suspend function and add power resume function
> - Move clock initialization code from audio driver to clock framework
> Changes from v3:
> - Fix the subject lines to match the style for the subsystem
> Changes from v2:
> - Split patchset 2/2 from v2 into patchsets 2/3 and 3/3.
> - Remove SND_SOC_CYGNUS_DIAG. Diagnostics can be performed using
> standard kernel trace infrastructure.
> - Fix interrupt handler. Acknowledge only those interrupts that are
> handledby ISR.
> - Modify configure_vco() and the pll_macro_entry() struct to make it
> better readable. The functionality did not change.
> - Remove casts on macros
> - Remove surround sound channel grouping from the driver.
> Changes from v1:
> - Address code review comments. Fix print format of type size_t and
> pointer.
>
> Simran Rai (3):
>    ASoC: cygnus: Add DT bindings for Broadcom Cygnus audio
>    ASoC: cygnus: Add Cygnus audio DAI driver
>    ASoC: cygnus: Add Cygnus audio DMA driver
>
>   .../bindings/sound/brcm,cygnus-audio.txt           |   67 +
>   sound/soc/bcm/Kconfig                              |    9 +
>   sound/soc/bcm/Makefile                             |    5 +
>   sound/soc/bcm/cygnus-pcm.c                         |  861 +++++++++++
>   sound/soc/bcm/cygnus-ssp.c                         | 1529 ++++++++++++++++++++
>   sound/soc/bcm/cygnus-ssp.h                         |  139 ++
>   6 files changed, 2610 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
>   create mode 100644 sound/soc/bcm/cygnus-pcm.c
>   create mode 100644 sound/soc/bcm/cygnus-ssp.c
>   create mode 100644 sound/soc/bcm/cygnus-ssp.h
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
