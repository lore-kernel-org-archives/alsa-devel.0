From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ad193x: fix wrong register setting in
 ad193x_set_dai_fmt
Date: Fri, 23 Apr 2010 16:14:27 +0100
Message-ID: <20100423151427.GD27232@rakim.wolfsonmicro.main>
References: <1271842609-18276-1-git-send-email-21cnbao@gmail.com>
	<1271842609-18276-2-git-send-email-21cnbao@gmail.com>
	<1271842609-18276-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E4E5624642
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 17:14:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1271842609-18276-3-git-send-email-21cnbao@gmail.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 21, 2010 at 05:36:48PM +0800, Barry Song wrote:
> Signed-off-by: Barry Song <21cnbao@gmail.com>

Please provide more detailed changelogs.  What is wrong with the
register settings?  I've applied the patch for 2.6.35 since it doesn't
apply on 2.6.34 but it'd have been very much more helpful if you'd said
what the problem you were trying to fix is.
