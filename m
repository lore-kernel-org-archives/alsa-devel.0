From: Chris Winter <elwintro@gmail.com>
Subject: Re: [PATCH 1/3] ucm: header - ALSA Use Case Manager
Date: Tue, 24 Aug 2010 14:09:45 -0500
Message-ID: <AANLkTimRsGPX6ZL8_iMe+TieozVr_fNx7aDYckBXHbZW@mail.gmail.com>
References: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
	<1282580239-10549-2-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 764B224466
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 21:10:19 +0200 (CEST)
Received: by ywg8 with SMTP id 8so2689490ywg.38
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2010 12:10:15 -0700 (PDT)
In-Reply-To: <1282580239-10549-2-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stefan Schmidt <stefan@slimlogic.co.uk>, Justin Xu <justinx@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Liam,

On Mon, Aug 23, 2010 at 11:17 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> This patch adds the API header for alsa-lib Use Case Management support.
>
> This file defines the public interface exported by UCM to client
> applications.
>
> UCM development has been kindly sponsored by Texas Instruments Inc,
> Wolfson Microelectronics PLC and Slimlogic Ltd.
>
> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> Signed-off-by: Justin Xu <justinx@slimlogic.co.uk>
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
> =A0include/use-case.h | =A0427 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 427 insertions(+), 0 deletions(-)
> =A0create mode 100644 include/use-case.h

[...]

> +/**
> + * \brief Get ALSA volume/mute control names depending on use case devic=
e.
> + * \param uc_mgr Use case manager
> + * \param type The control type we are looking for
> + * \param device The device we are interested in.
> + * \return name if success, otherwise NULL
> + *
> + * Get the control name for common volume and mute controls that are ali=
ased
> + * in the current use case verb.
> + */
> +const char *snd_use_case_get_device_ctl_elem_id(snd_use_case_mgr_t *uc_m=
gr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum snd_use_case_control_alias type, const=
 char *device);
> +
> +/**
> + * \brief Get ALSA volume/mute control names depending on use case modif=
ier.
> + * \param uc_mgr Use case manager
> + * \param type The control type we are looking for
> + * \param modifier The modifier we are interested in.
> + * \return name if success, otherwise NULL
> + *
> + * Get the control name for common volume and mute controls that are ali=
ased
> + * in the current use case modifier.
> + */
> +const char *snd_use_case_get_modifier_ctl_elem_id(snd_use_case_mgr_t *uc=
_mgr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum snd_use_case_control_alias type, const=
 char *modifier);


It would appear that the implementations of the above two functions
are named differently in src/use-case.c:

const char *snd_use_case_get_device_ctl_elem_name(...)
const char *snd_use_case_get_modifier_ctl_elem_name(...)

Regards,

Chris
