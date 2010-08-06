From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/3] ASoC: multi-comp: OMAP platform fixes
Date: Fri, 6 Aug 2010 10:56:28 +0300
Message-ID: <20100806105628.2971f8a1.jhnikula@gmail.com>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 749712414C
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 09:55:21 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2582232ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 06 Aug 2010 00:55:21 -0700 (PDT)
In-Reply-To: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: jkrzyszt@tis.icnet.pl, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, arunks@mistralsolutions.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi, notes for Arun and Janusz below.

On Fri,  6 Aug 2010 10:39:12 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Hello,
> 
> The following series introduces some cleanups for OMAP platforms in
> multi-component branch.
> 
> - Enable audio for OMAP1 class

There's a on-going development going on to update ASoC framework. This
multi-compont work requires major changes and our problem is that we
don't have any OMAP1 boards to test these changes.

We'd glad if you could test these changes with Peter's patches on OMAP1
board.

The ASoC multi-component development happens in
origin/topic/multi-component branch of this tree:

git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git


-- 
Jarkko
