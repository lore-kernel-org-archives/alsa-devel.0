From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Thu, 19 Aug 2010 14:54:14 +0100
Message-ID: <20100819135413.GA19582@opensource.wolfsonmicro.com>
References: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
	<20100816100705.GA3276@rakim.wolfsonmicro.main>
	<20100816135328.077b5ea3.jhnikula@gmail.com>
	<20100816110902.GA10354@sirena.org.uk>
	<20100819144451.1d827367.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E4C8243D3
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 15:53:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100819144451.1d827367.jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 02:44:51PM +0300, Jarkko Nikula wrote:

> kcontrol or name prefix still comes from dai_link->kcontrol_prefix
> (where it should be per codec as pointer by Mark). And no drivers are
> patched for snd_soc_add_controls, snd_soc_dapm_new_control,
> snd_soc_dapm_new_controls and snd_soc_dapm_add_routes API changes.

It seems inelegant to have to bounce the prefix information through the
CODEC driver - we're already supplying the CODEC when we register the
controls so it seems like the core ought to be able to work out which
controls need to be renamed from the machine description without needing
this.

It seems best to have the data come from machine-specific config so that
we can allow them to provide something that makes things clearer to
users on the particular board.

> Codec:
> - kcontrol prefix
> - no widget name prefix (as they are per codec)
> - no audio map prefix (as they are per codec)

Are you sure these are per CODEC?
