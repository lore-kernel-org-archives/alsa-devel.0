From: Travis Place <wishie@wishie.net>
Subject: Re: alsa-info.sh debugging script
Date: Sun, 10 Feb 2008 02:49:34 +1000
Message-ID: <200802100249.34574.wishie@wishie.net>
References: <200802022334.42705.wishie@wishie.net>
	<200802092323.32103.wishie@wishie.net>
	<1202572134.20900.30.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-101-003.auto.usertools.net [202.137.101.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DFB524522
	for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2008 17:52:55 +0100 (CET)
Received: from [192.168.0.2] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id D26404052
	for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2008 17:14:54 +1000 (EST)
In-Reply-To: <1202572134.20900.30.camel@razman.gruemaster.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 10 Feb 2008 1:48:54 am Tobin Davis wrote:
> On Sat, 2008-02-09 at 23:23 +1000, Travis Place wrote:
> > I am still adding features to the alsa-info.sh script from time to
> > time, with
> > support for encrypting posts, and tidying up the scripts output etc..
> >
> > How can i get these up to the HG repo ?
>
> First thing to do is install mercurial.  It should be available for your
> distribution.  If not, get it here:
> http://www.selenic.com/mercurial/wiki/
>
> Once that is installed, set up a development directory, cd into it, and
> type "hg clone http://hg.alsa-project.org/alsa" (this is where your
> script has been added - other hg repos have alsa-driver, alsa-kernel,
> alsa-lib, etc).
>
> Now that you have a working copy of the repository, you can edit your
> file in here.  Periodically, and especially before you upload a patch,
> type "hg pull" from within the repository you are working with to sync
> with the main branch, then either run "hg diff -r tip <file>" to
> generate a patch for mailing, or I think you can push back to the main
> pool with "hg push" (someone else will need to jump in here as I email
> all my patches for peer review).

Thanks so far Tobin.. ive got the copy locally now, and made the changes.. 
having trouble submitting though.

Have to wait and see if anyone else can help.

Travis.

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
