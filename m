From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: alsa-info.sh debugging script
Date: Sat, 09 Feb 2008 07:48:54 -0800
Message-ID: <1202572134.20900.30.camel@razman.gruemaster.com>
References: <200802022334.42705.wishie@wishie.net>
	<Pine.LNX.4.61.0802041257040.8166@tm8103.perex-int.cz>
	<200802050023.19822.wishie@wishie.net>
	<200802092323.32103.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CE7210388D
	for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2008 16:48:56 +0100 (CET)
In-Reply-To: <200802092323.32103.wishie@wishie.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Travis Place <wishie@wishie.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Sat, 2008-02-09 at 23:23 +1000, Travis Place wrote:

> I am still adding features to the alsa-info.sh script from time to
> time, with 
> support for encrypting posts, and tidying up the scripts output etc..
> 
> How can i get these up to the HG repo ?

First thing to do is install mercurial.  It should be available for your
distribution.  If not, get it here:
http://www.selenic.com/mercurial/wiki/

Once that is installed, set up a development directory, cd into it, and
type "hg clone http://hg.alsa-project.org/alsa" (this is where your
script has been added - other hg repos have alsa-driver, alsa-kernel,
alsa-lib, etc).

Now that you have a working copy of the repository, you can edit your
file in here.  Periodically, and especially before you upload a patch,
type "hg pull" from within the repository you are working with to sync
with the main branch, then either run "hg diff -r tip <file>" to
generate a patch for mailing, or I think you can push back to the main
pool with "hg push" (someone else will need to jump in here as I email
all my patches for peer review).

-- 
Tobin Davis 


Cold, adj.:
	When the politicians walk around with their hands in their own pockets.
