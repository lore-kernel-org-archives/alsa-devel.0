From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/10] Kirkwood ASoC drivers fixes and
	improvements
Date: Wed, 21 Nov 2012 10:05:53 +0000
Message-ID: <20121121100553.GY3290@n2100.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
 <20121121014043.GG4673@opensource.wolfsonmicro.com>
 <20121121094141.GW3290@n2100.arm.linux.org.uk>
 <20121121094719.GR4673@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 7F80D265CCC
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 11:05:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121121094719.GR4673@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Rabeeh Khoury <rabeeh@solid-run.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 21, 2012 at 06:47:21PM +0900, Mark Brown wrote:
> On Wed, Nov 21, 2012 at 09:41:42AM +0000, Russell King - ARM Linux wrote:
> 
> > I've been discussing this with Sebastian Hesselbarth and he's agreed
> > to have his sign-off on a bunch of these patches... I guess not now.
> 
> It's on a separate branch which I've not produced a signed tag for so I
> can rebase and add if you/he send me something.

That's a good idea; I did say that the patches should be tested on
Kirkwood first.  Also, Sebastian has been doing his own independent
testing of them last night... unsuccessfully from what I read on IRC,
but that may not be due to the patches themselves but the amount of
churn going on with the Dove architecture having broken something else
in the clk stuff.

So you might get some tested-by's at some point, or you might be asked
to hold off on them.

Also remember that Arnaud hasn't seen these patches (unless they got
through the alsa mailing list moderation and he's looked them up in
the archives.)
