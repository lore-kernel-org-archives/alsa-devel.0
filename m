From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Blackfin ASoC drivers with multi-component
Date: Sun, 28 Nov 2010 12:35:58 +0000
Message-ID: <20101128123558.GB12683@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B92B724463
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2010 13:35:58 +0100 (CET)
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
To: Mike Frysinger <vapier@gentoo.org>, Sonic Zhang <sonic.zhang@analog.com>, Barry Song <21cnbao@gmail.com>, Cliff Cai <cliff.cai@analog.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

I'm a little concerned that there have been no updates to the Blackfin
audio drivers since the merge of multi-component ASoC (which is now in
mainline and should be released as part of 2.6.37).  This was a very
big and invasive update, and experience with other architectures has
been that there's usually at least some typos that need fixing.  It'd be
good to get some confirmation that the audio drivers have at least been
tested with current mainline - if everything worked fine that's
obviously excellent but it'd be good if someone could confirm that this
is the case.

There was some discussion with Mike at the time the drivers were merged
but it sounded more like "I need to get the audio guys to look at this"
than a report of actual testing and there's been nothing since.
