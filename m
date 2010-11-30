From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC don't apply] ASoC: Add support for
	optional	auxiliary dailess codecs
Date: Tue, 30 Nov 2010 14:43:55 +0000
Message-ID: <20101130144355.GE32368@sirena.org.uk>
References: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
	<20101128115004.GB28950@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 783BF1039AA
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 15:43:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101128115004.GB28950@opensource.wolfsonmicro.com>
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

On Sun, Nov 28, 2010 at 11:50:04AM +0000, Mark Brown wrote:

> That said, this shouldn't affect the external interfaces here - it
> should only have any material impact on the core - so probably shouldn't
> be a blocker for adding this feature.  Liam, does this analysis all
> sound sane to you?

Just discussed offline with Liam and he's happy with this approach so
I've now applied the patch - thanks!  I'll look into faffing about with
sysfs myself.
