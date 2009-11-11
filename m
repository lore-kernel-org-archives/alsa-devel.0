From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] add support to reorder CPU and Codec DAI
	suspend/resume
Date: Wed, 11 Nov 2009 11:24:31 +0000
Message-ID: <20091111112431.GA18005@opensource.wolfsonmicro.com>
References: <1257923457-31470-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5DCD243DD
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 12:24:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257923457-31470-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 11, 2009 at 03:10:57PM +0800, Barry Song wrote:
> Due to some hardware dependence issues, some devices maybe require
> different suspend/resume execution order for CPU and Codec DAI to
> make sure the hardware can work normally after executing sleep and
> wakeup.

Are there any actual systems that this solves problems for - if so, what
are the problems?  I don't think this solution is general enough to be
scalable, it'll work for one particular use case but if we get further
reorderings needed it'll become difficult to manage.

If we're going to be doing anything with this I think it would be much
better to use the pm_link infrastructure which will be appearing in
2.6.34.  This should allow us to provide arbatrary ordering of device
level suspend and resume.
