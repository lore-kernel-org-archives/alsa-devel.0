From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ascenario: Add scenario support to	alsa-lib
Date: Thu, 1 Oct 2009 15:18:09 +0100
Message-ID: <20091001141809.GB29526@sirena.org.uk>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
	<1254401304.5847.187.camel@odin>
	<20091001130216.GE14417@sirena.org.uk>
	<1254405992.5847.241.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 12AA110398F
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 16:18:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254405992.5847.241.camel@odin>
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
Cc: Ian Molton <ian@mnementh.co.uk>, Stefan Schmidt <stefan@slimlogic.co.uk>, alsa-devel@alsa-project.org, Stefan Schmidt <stefan@datenfreihafen.org>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 03:06:32PM +0100, Liam Girdwood wrote:

> I'm hoping this file format and remapping will be deprecated by the
> audio graphing interface (as discussed at LPC). We can still keep the
> same front end API to the apps though.

Hrm, I'll have to have a think about that.  I'd always thought of the
two as being complimentary - the graph saying what the connections are
and where all the controls are while the scenario says what settings to
use and which controls are for applications.  I think I can see where
you're coming from, though.  We should discuss this tonight in person.
