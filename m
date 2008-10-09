From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [topic/asoc][DON'T PUSH][PATCH 0/3] ASoC: OMAP:
	McBSP DAI driver updates
Date: Thu, 9 Oct 2008 16:10:55 +0100
Message-ID: <20081009151054.GB16095@sirena.org.uk>
References: <1223557042-17279-1-git-send-email-jarkko.nikula@nokia.com>
	<20081009150228.GA16095@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F2D61244F9
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 17:11:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081009150228.GA16095@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 09, 2008 at 04:02:29PM +0100, Mark Brown wrote:

> These all look good.  How do you want to merge them?  They could either
> go in with the McBSP changes they depend on or via ALSA.  If via ALSA
> then if you like I'm happy to queue them up and submit them once their
> dependencies are merged (I've got some other changes in a similar
> situation myself).  Otherwise I guess you could resubmit them once the
> McBSP changes are merged.

Hrm.  Looking at the ARM list just now it seems both this and the things
my other patches are waiting for are now in rmk's tree so I'm already
tracking stuff in the same tree for submission - I guess that makes
adding these to my queue the most simple approach?
