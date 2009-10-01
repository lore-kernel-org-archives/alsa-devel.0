From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ascenario: Add scenario support to	alsa-lib
Date: Thu, 01 Oct 2009 13:48:24 +0100
Message-ID: <1254401304.5847.187.camel@odin>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f218.google.com (mail-ew0-f218.google.com
	[209.85.219.218])
	by alsa0.perex.cz (Postfix) with ESMTP id E727E10395C
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:48:30 +0200 (CEST)
Received: by ewy18 with SMTP id 18so158813ewy.43
	for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2009 05:48:30 -0700 (PDT)
In-Reply-To: <20091001122835.GC14417@sirena.org.uk>
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
Cc: Ian Molton <ian@mnementh.co.uk>, Stefan Schmidt <stefan@slimlogic.co.uk>, alsa-devel@alsa-project.org, Stefan Schmidt <stefan@datenfreihafen.org>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-10-01 at 13:28 +0100, Mark Brown wrote:

> Thinking out loud here but I'm wondering if it might make sense to
> replace the fixed list of controls that is there currently with
> something string based which can remap the control names if required.
> This would allow for (probably in the future) having the scenario pass
> back a list of controls without the API having to cater for each
> explicitly, which would allow for other things like hardware EQ controls
> to be passed on to the scenario users if desired - this is useful when
> you get things like systems with multiple EQs.
> 
> This would complicate the API, though, and so I think it would be better
> left as-is until we get to the point of having something like a plugin
> for rewriting the controls for applications so they don't need explicit
> knowledge of scenarios.  At that point it would only impact the scenario
> manager implementation which should deal with the complexity, at least
> externally.
> 
> I'm also thinking that it could be good to add functions to identify
> which PCMs on a card to use in the scenario, perhaps differentiated by
> quality or something.  The CPU may have PCMs to multiple devices or with
> differing capabilities and may want to switch between them depending on
> scenario (and possibly stream).

Agreed, these all sound like good features for the future and will
probably require some sponsorship to complete.

However, what we have atm is enough for most folks to get some working
audio kcontrol scenarios configured for their devices.

Liam  
