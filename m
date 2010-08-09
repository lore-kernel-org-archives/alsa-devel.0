From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 0/3] ASoC: multi-comp: OMAP platform fixes
Date: Mon, 9 Aug 2010 19:09:57 +0200
Message-ID: <201008091909.59930.jkrzyszt@tis.icnet.pl>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100806105628.2971f8a1.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E36F42465F
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 19:10:31 +0200 (CEST)
In-Reply-To: <20100806105628.2971f8a1.jhnikula@gmail.com>
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
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Friday 06 August 2010 09:56:28 Jarkko Nikula wrote:
> Hi, notes for Arun and Janusz below.
>
> On Fri,  6 Aug 2010 10:39:12 +0300
>
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > Hello,
> >
> > The following series introduces some cleanups for OMAP platforms in
> > multi-component branch.
> >
> > - Enable audio for OMAP1 class
>
> There's a on-going development going on to update ASoC framework. This
> multi-compont work requires major changes and our problem is that we
> don't have any OMAP1 boards to test these changes.
>
> We'd glad if you could test these changes with Peter's patches on OMAP1
> board.
>
> The ASoC multi-component development happens in
> origin/topic/multi-component branch of this tree:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git

Hi,
If your request for testing Peter's patches is still valid, what exact tree 
and branch would you like me to test the patches against? I've tried to 
locate a tree with the patches already applied by Liam, but failed.

Meanwhile, I've verified that the patches, or their OMAP1 related bits, are 
harmless when applied against (almost) current l-o master. However, I'm not 
sure if testing the new platform devices not actually used by any 
corresponding platform drivers is what you expected.

Thanks,
Janusz
