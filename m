From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL]: Second soundwire updates
Date: Thu, 2 May 2019 19:09:56 +0200
Message-ID: <20190502170956.GA18654@kroah.com>
References: <20190502165636.GU3845@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53DFBF89693
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 19:10:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190502165636.GU3845@vkoul-mobl.Dlink>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 02, 2019 at 10:26:36PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> As discussed here is the second soundwire PULL request for v5.2-rc1.
> 
> The following changes since commit 4abbd783d126cabfc20d1b8d50b1d5026b5cba09:
> 
>   soundwire: intel: fix implicit header use of module.h/export.h (2019-04-14 15:52:50 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.2-rc1_2

I just did a pull, and a diff, and got nothing:
	$ git diff work-testing..HEAD
	$

So what I currently have in my char-misc work-testing branch is
identical to your branch.  So if you were to rebase, you would have a
"clean" tree.

So I'll just keep what I have already, as this way, everything has my
signed-off-by on them, as I did take the time to review them all :)

thanks,

greg k-h
