From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoC: Fix dapm_is_shared_kcontrol so
 everything isn't shared
Date: Thu, 26 May 2011 08:38:32 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A486A0@HQMAIL01.nvidia.com>
References: <1306278721-32742-1-git-send-email-swarren@nvidia.com>
	<20110525100155.04c8b5e1.jhnikula@gmail.com>
	<20110525175202.01ebfed2.jhnikula@gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A48449@HQMAIL01.nvidia.com>
	<20110526095752.a450fe6d.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id C4007103AA7
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 17:38:46 +0200 (CEST)
In-Reply-To: <20110526095752.a450fe6d.jhnikula@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Jarkko Nikula wrote at Thursday, May 26, 2011 12:58 AM:
> On Wed, 25 May 2011 08:24:59 -0700 Stephen Warren <swarren@nvidia.com> wrote:
> > > Then we must skip test for widgets that are in different dapm context,
> > > i.e. we don't want to share mux controls if they are in different device
> > > instance. Does it work for you if you add the dapm test below to your
> > > patch?
> >
> > I suppose that's technically correct, and I'm fine adding this to the
> > patch. However, I'm surprised that change is needed; do we actually have
> > a situation where two widgets in different DAPM contexts point at the
> > same control definition? It seems like that'd be a bug; why would there
> > be two controls pointing at the same register field, yet in different
> > DAPM contexts?
>
> Yes, I noticed this can happen when you have multiple same codecs in a
> system. Let's assume we have multiple wm8903 codecs and we have these
> in the driver:

Yes, of course, that makes perfect sense. I'll rev the patch as you suggested.

> static const struct snd_kcontrol_new adcinput_mux =
> 	SOC_DAPM_ENUM("ADC Input", adcinput_enum);
> 
> static const struct snd_soc_dapm_widget wm8903_dapm_widgets[] = {
>   SND_SOC_DAPM_MUX("Left ADC Input", SND_SOC_NOPM, 0, 0, &adcinput_mux),
> };
> 
> Even the core duplicates widgets for each codec instance in this
> example, they still point to same adcinput_mux and thus
> dapm_is_shared_kcontrol() miss detects them as shared if we don't skip
> different dapm context.

-- 
nvpublic
