From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Hg update problems
Date: Wed, 30 Jan 2008 15:10:38 -0800
Message-ID: <1201734638.23369.42.camel@razman.gruemaster.com>
References: <mailman.479441.1201678517.26582.alsa-cvslog@lists.sourceforge.net>
	<200801302110.17979.linux@audioscience.com>
	<s5hir1bloa4.wl%tiwai@suse.de>
	<200801311133.27010.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 22DEE2455B
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 00:10:41 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Whatever the problem is, it is affecting the rss feed as well.  My
hda-sch patch was added today:

        changeset: 5794:9c896b0ea558 
        user: tiwai 
        date: Wed Jan 30 08:13:55 2008 +0100 
        summary: HDA-Intel - Add support for Intel SCH

But has failed to show up on my RSS feed reader (updated every 30
minutes).   My hg pull uses http://hg.alsa-project.org/alsa-kernel and
the RSS feed is 
http://hg.alsa-project.org/alsa-kernel?cl=tip;style=rss


Tobin

On Thu, 2008-01-31 at 11:33 +1300, Eliot Blennerhassett wrote:

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
> 
> Very wierd...
> 
> Anyone else see this or shed any light on it?
> --
> Eliot
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis 


"Consequences, Schmonsequences, as long as I'm rich."
		-- "Ali Baba Bunny" [1957, Chuck Jones]
