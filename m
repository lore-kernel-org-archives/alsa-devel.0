From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ascenario: Add scenario support to	alsa-lib
Date: Thu, 1 Oct 2009 14:02:16 +0100
Message-ID: <20091001130216.GE14417@sirena.org.uk>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
	<1254401304.5847.187.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 32FD5103960
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 15:02:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254401304.5847.187.camel@odin>
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
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, Ian Molton <ian@mnementh.co.uk>, Stefan Schmidt <stefan@slimlogic.co.uk>, alsa-devel@alsa-project.org, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 01:48:24PM +0100, Liam Girdwood wrote:

> However, what we have atm is enough for most folks to get some working
> audio kcontrol scenarios configured for their devices.

Indeed, like I said I think most of what I suggested only makes sense
with a transparent remapping of control names for application usability
reasons if nothing else.  PCM specification is the only thing I can see
being useful right now but that's definitely something that could just
be bolted on the side of the existing stuff, it shouldn't impact it
directly.

What would be nice now would be to tweak the configuration file format
to support at least the control remapping, though (so it'd only support
a fixed list of target controls but it'd use the standard names, for
example).  That would mean that when someone does implement more
advanced functionality there's more chance that the configuration file
format would be static.  Configuration file format changes are a pain to
manage over upgrades, especially for distros, so if they can be headed
off in advance that'd be a win.
