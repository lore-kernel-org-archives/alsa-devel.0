From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: S6000 ASoC drivers with multi-component
Date: Sun, 28 Nov 2010 12:07:02 +0000
Message-ID: <20101128120702.GA12683@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 001BF2444E
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2010 13:06:53 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Cc: Chris Zankel <chris@zankel.net>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

I'm a little concerned that there have been no updates to the s6000
audio drivers since the merge of multi-component ASoC (which is now in
mainline and should be released as part of 2.6.37).  This was a very
big and invasive update, and experience with other architectures has
been that there's usually at least some typos that need fixing.  It'd be
good to get some confirmation that the audio drivers have at least been
tested with current mainline - if everything worked fine that's
obviously excellent but it'd be good if someone could confirm that this
is the case.
