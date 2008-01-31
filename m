From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Hg update problems
Date: Thu, 31 Jan 2008 08:34:10 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801310833150.11819@tm8103.perex-int.cz>
References: <mailman.479441.1201678517.26582.alsa-cvslog@lists.sourceforge.net>
	<200801302110.17979.linux@audioscience.com>
	<s5hir1bloa4.wl%tiwai@suse.de>
	<200801311133.27010.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E12DA1037F6
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 08:34:10 +0100 (CET)
In-Reply-To: <200801311133.27010.linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 31 Jan 2008, Eliot Blennerhassett wrote:

> Hi Takashi,
> 
> Wierd, I can see your checkin in a browser at 
> http://hg.alsa-project.org/alsa-driver/  
> 
> 14 hours ago:  	asihpi version 3.09.09
> changeset 3506: 	e600ecb8fbd7
> tag:	tip
> author: 	tiwai
> 
> Also I see it in a clean clone of the repo.
> 
> but hg pull on my original repo still gets nothing same as before, head is out 
> of date - details:
> eliot@zaphod:~/src/alsahg/alsa-driver$ hg -v --debug heads
> changeset:   3507:86adcd0d6d849d5f8d41448d3cd4d1a8660d6214
> tag:         tip
> description:
> Added tag v1.0.16rc2 for changeset 1dc44ca35555
> 
> 
> Tracing (strace) further I see that Hg queries the repository like this
> http://hg.alsa-project.org/alsa-driver/?cmd=heads
> and gets back
> 86adcd0d6d849d5f8d41448d3cd4d1a8660d6214
> So the remote repo is telling me that my local is up to date, even though the 
> web interface shows more recent tip.

I get e600ecb8fbd75433610a8c5cdc6335c939940302 here.
Do you have a HTTP cache or proxy server between our server and your side?

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
