From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] pxa2xx-ac97-lib: support building for
	several CPUs
Date: Fri, 12 Sep 2008 14:40:09 +0100
Message-ID: <20080912134008.GB2471@sirena.org.uk>
References: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
	<1221008480-13377-2-git-send-email-dbaryshkov@gmail.com>
	<20080911150413.GC12311@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 26A98246A7
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Sep 2008 15:40:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080911150413.GC12311@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 11, 2008 at 04:04:13PM +0100, Mark Brown wrote:

> fixed that up locally.  However, PXA3xx support seems broken in some
> other way, it fails during init - I'll debug this and post updated
> patches.

This was a false alarm, sorry - the machine I was using for testing
required some unmerged MFP configuration for AC97 to work.

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
