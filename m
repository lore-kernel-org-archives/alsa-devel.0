From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC_iii/iv 1/2] ASoC: Rename dai_link as dev_map
Date: Mon, 1 Nov 2010 13:46:34 -0400
Message-ID: <20101101174633.GD24814@opensource.wolfsonmicro.com>
References: <1288353780-22041-1-git-send-email-jhnikula@gmail.com>
	<20101029212249.GJ3921@opensource.wolfsonmicro.com>
	<20101031201215.9591a614.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D0F68103858
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 18:46:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101031201215.9591a614.jhnikula@gmail.com>
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

On Sun, Oct 31, 2010 at 08:12:15PM +0200, Jarkko Nikula wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > My main thought with this now that I see the change is that it'd be
> > easier and probably clearer to add an explicit list of devices rather
> > than to repurpose the DAI links.  This will probably be simpler since we
> > can avoid things like having to work out if we've seen and initialised a
> > device before when it has multiple DAIs involved.

> My concern was mostly that we end up having somewhat similar struct
> than snd_soc_dai_link and adding pointer to such table in snd_soc_card.

We probably want to be pulling stuff out of the DAI link if anything
(for example, the CODEC is generally going to be implied by the CODEC
DAI).

> But that's not necessary reduncandy at all if it makes cleanier move to
> other cases like codec-codec etc. I'll experiment that in next version.

Please do - I'd rather have a series of small, clear descriptive lists
than a single big list since I think that this will be much clearer and
easier to work with.
