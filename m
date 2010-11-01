From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC_i/iv 1/3] ASoC: Decouple DAPM from CODECs.
 Part core (will be squashed)
Date: Mon, 1 Nov 2010 09:13:23 -0400
Message-ID: <20101101131322.GC22639@opensource.wolfsonmicro.com>
References: <1288353618-21753-1-git-send-email-jhnikula@gmail.com>
	<1288353618-21753-2-git-send-email-jhnikula@gmail.com>
	<20101029200428.GD3921@opensource.wolfsonmicro.com>
	<1288461714.3286.143.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 25106103806
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 14:13:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288461714.3286.143.camel@odin>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 30, 2010 at 07:01:54PM +0100, Liam Girdwood wrote:
> On Fri, 2010-10-29 at 13:04 -0700, Mark Brown wrote:

> > >  		run_delayed_work(&card->rtd[i].delayed_work);
> > > -		card->rtd[i].codec->suspend_bias_level = card->rtd[i].codec->bias_level;
> > > +		card->rtd[i].codec->dapm->suspend_bias_level = card->rtd[i].codec->dapm->bias_level;

> Btw, not sure what you mean by this 1 line change being run multiple
> times being different to the old line.

It's not different, a lot of the stuff here is things that we need to do
in the series that are thrown up by the series as a result of it
touching all relevant places.  I tried to mention this in the places I
noted it, but some of them I will have forgotten.

> > I'd be more inclined to just embed the struct in the objects that need
> > it rather than individually allocating them - it saves error checking
> > and deallocation, and I can't see any cases where we'd want to
> > optionally have a DAPM object.

> Yeah, the reason for this is because it was unclear at the time whether
> we will need to share a context between DAI backend and frontends. So
> this can be embedded now.

Jarkko, with this change I think this first patch is good to go - I
think we should try to get the early bits in while we're iterating on
the rest.
