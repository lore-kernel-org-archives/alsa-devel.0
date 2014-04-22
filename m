From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 4/6] ASoC: qi_lb60: Use
	devm_snd_soc_register_card()
Date: Wed, 23 Apr 2014 00:06:05 +0200
Message-ID: <20140422220605.GA5334@linux-mips.org>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
 <1398199596-23649-4-git-send-email-lars@metafoo.de>
 <20140422205410.GI12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from git.linux-mips.org (marvin.linux-mips.org [78.24.191.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 6785A265053
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 00:06:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35671 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S6834662AbaDVWGK6j0UF (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Wed, 23 Apr 2014 00:06:10 +0200
Content-Disposition: inline
In-Reply-To: <20140422205410.GI12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 22, 2014 at 09:54:10PM +0100, Mark Brown wrote:

> On Tue, Apr 22, 2014 at 10:46:34PM +0200, Lars-Peter Clausen wrote:
> > Makes the code a bit shorter and will also allow us to remove the drivers
> > remove() callback eventually.
> 
> Applied all the patches up to here, thanks.  Will wait for Ralf's review
> for the other two, they look good to me.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Really, the MIPS bits were trivial ...

  Ralf
