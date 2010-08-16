From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Mon, 16 Aug 2010 13:53:28 +0300
Message-ID: <20100816135328.077b5ea3.jhnikula@gmail.com>
References: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
	<20100816100705.GA3276@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 786C0103834
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 12:53:24 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2165275ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2010 03:53:20 -0700 (PDT)
In-Reply-To: <20100816100705.GA3276@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 16 Aug 2010 11:07:05 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Aug 16, 2010 at 10:29:30AM +0300, Jarkko Nikula wrote:
> > This optional kcontrol_prefix allows to specify unique prefix for ALSA
> > control names for each DAI link. This makes possible to have a sound card
> > configuration with multiple DAIs and each of them using the same codec
> > driver without name collision.
> 
> This isn't going to work in general - consider what happens for CODECs
> with multiple DAIs, or for devices with no DAIs at all like external
> analogue amps.  We do need to do this but it probably needs to be per
> CODEC rather than per link I fear.

Yeah, true, this is not going to work if there are multiple amplifiers
that are registered for a same link.

Multi-DAI codecs are not so clear to me. I thought codecs are exporting
different controls for different DAIs? Like "foo Playback Volume" and
"bar Playback Volume".

But anyway, I'll try to look some better idea.


-- 
Jarkko
