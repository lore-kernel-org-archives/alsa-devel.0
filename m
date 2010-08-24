From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ucm: header - ALSA Use Case Manager
Date: Tue, 24 Aug 2010 21:34:09 +0100
Message-ID: <1282682049.3408.245.camel@odin>
References: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
	<1282580239-10549-2-git-send-email-lrg@slimlogic.co.uk>
	<AANLkTimRsGPX6ZL8_iMe+TieozVr_fNx7aDYckBXHbZW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B49C6244C7
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 22:34:15 +0200 (CEST)
Received: by wwb17 with SMTP id 17so2090386wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2010 13:34:15 -0700 (PDT)
In-Reply-To: <AANLkTimRsGPX6ZL8_iMe+TieozVr_fNx7aDYckBXHbZW@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Winter <elwintro@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stefan Schmidt <stefan@slimlogic.co.uk>, Justin Xu <justinx@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-08-24 at 14:09 -0500, Chris Winter wrote:
> Hi Liam,
> 
> On Mon, Aug 23, 2010 at 11:17 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > This patch adds the API header for alsa-lib Use Case Management support.
> >
> > This file defines the public interface exported by UCM to client
> > applications.
> >
> > UCM development has been kindly sponsored by Texas Instruments Inc,
> > Wolfson Microelectronics PLC and Slimlogic Ltd.
> >
> > CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
> > Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> > Signed-off-by: Justin Xu <justinx@slimlogic.co.uk>
> > Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> > ---
> >  include/use-case.h |  427 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 427 insertions(+), 0 deletions(-)
> >  create mode 100644 include/use-case.h
> 
> [...]
> 
> > +/**
> > + * \brief Get ALSA volume/mute control names depending on use case device.
> > + * \param uc_mgr Use case manager
> > + * \param type The control type we are looking for
> > + * \param device The device we are interested in.
> > + * \return name if success, otherwise NULL
> > + *
> > + * Get the control name for common volume and mute controls that are aliased
> > + * in the current use case verb.
> > + */
> > +const char *snd_use_case_get_device_ctl_elem_id(snd_use_case_mgr_t *uc_mgr,
> > +               enum snd_use_case_control_alias type, const char *device);
> > +
> > +/**
> > + * \brief Get ALSA volume/mute control names depending on use case modifier.
> > + * \param uc_mgr Use case manager
> > + * \param type The control type we are looking for
> > + * \param modifier The modifier we are interested in.
> > + * \return name if success, otherwise NULL
> > + *
> > + * Get the control name for common volume and mute controls that are aliased
> > + * in the current use case modifier.
> > + */
> > +const char *snd_use_case_get_modifier_ctl_elem_id(snd_use_case_mgr_t *uc_mgr,
> > +               enum snd_use_case_control_alias type, const char *modifier);
> 
> 
> It would appear that the implementations of the above two functions
> are named differently in src/use-case.c:
> 
> const char *snd_use_case_get_device_ctl_elem_name(...)
> const char *snd_use_case_get_modifier_ctl_elem_name(...)
> 

Ah, they are indeed. I'll fix up. 

Thanks !

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
