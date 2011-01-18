From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: dapm: Fix race condition in widgets
	power list creation
Date: Tue, 18 Jan 2011 14:34:13 +0200
Message-ID: <201101181434.13937.peter.ujfalusi@nokia.com>
References: <1295318127-17968-1-git-send-email-misael.lopez@ti.com>
	<20110118113956.GE26498@opensource.wolfsonmicro.com>
	<4D3582D3.40105@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (mgw-da01.ext.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E26F110383B
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 13:34:18 +0100 (CET)
In-Reply-To: <4D3582D3.40105@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 18 January 2011 14:08:51 ext Peter Ujfalusi wrote:
> Resend, since alsa-devel address was mistyped ;)
> =

> On 01/18/11 13:39, ext Mark Brown wrote:
> > > I *suspect* that we're in a similar case and either the locking has
> > > been broken by the multi-component stuff or there's other cases that
> > > need protection, probably the jack detection code.
> =

> The snd_soc_dapm_sync is just a wrapper for dapm_power_widgets, right?
> It (snd_soc_dapm_sync) is used in soc-core:soc_post_component_init.
> But there is no need for it, since the snd_soc_dapm_new_widgets will
> call dapm_power_widgets at the end. so we can remove the
> snd_soc_dapm_sync from there.
> For the rest:
> I would replace the snd_soc_dapm_sync calls in soc-dapm.c with
> dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP); calls.
> Modify the snd_soc_dapm_sync to use the codec->mutex around the
> dapm_power_widgets call.
> In that way I think all race conditions going to be covered without
> adding new mutex.
> =

> What do you think?
> I can make a patch...

Or not.. soc-jack.c:snd_soc_jack_report also calls snd_soc_dapm_sync, while =

keeping the codec->mutex locked...
Should machine drivers also take the mutex when they call snd_soc_dapm_sync?

-- =

P=E9ter
