From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Next steps
Date: Sat, 02 Jun 2007 23:05:42 -0700
Message-ID: <1180850742.4335.62.camel@razman.gruemaster.com>
References: <Pine.LNX.4.64.0705290952230.2627@tick.idlelion.net>
	<s5htztvzilk.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0705291151190.2627@tick.idlelion.net>
	<s5hlkf7zhip.wl%tiwai@suse.de>  <466239EC.2080105@idlelion.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 559AA24433
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Jun 2007 08:05:45 +0200 (CEST)
In-Reply-To: <466239EC.2080105@idlelion.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Schumann <chris@idlelion.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Try running "./hgcompile".  It will rebuild the ./configure script and
build the drivers for you.

On Sat, 2007-06-02 at 22:47 -0500, Chris Schumann wrote:

> Takashi Iwai wrote:
> > At Tue, 29 May 2007 11:52:55 -0500 (CDT),
> > chris@idlelion.net asked about alsa development
>  > ...
> > Both alsa-driver and alsa-kernel are repos for ALSA drivers, so you
> > need both.  The latter contains the source codes to be merged to linux
> > kernel tree while the former contains the stuff for building the
> > modules.
> > 
> > It's not always necessary to use HG version of alsa-lib, utils and
> > others.  But, at least, it's safe and recommended to use the latest
> > version of alsa-lib and utils together with alsa-driver.
> > 
> > 
> > Takashi
> 
> I'm running CentOS 5 and would like to keep the machine working for its 
> owner while I try to fix the sound driver.
> 
> I cloned alsa-driver and alsa-kernel from the hg repository. In 
> alsa-driver is a file called INSTALL.
> 
> Step 1 says I need full configured source for the kernel. "yum install 
> kernel-devel" seemed to do that.
> 
> Step 2 says turn on sound support. No idea what that means.
> 
> Step 3 says run ./configure. That file doesn't exist. There is a 
> configure.in that says it should be run through autoconf. If there's an 
> automated script to do that, its location isn't obvious.
> 
> There are over 4000 lines in the cs46xx module, so any tips on what's 
> important (other than the actual suspend and resume functions that I've 
> found) and where to start a search would be helpful too.
> 
> Thanks,
> Chris
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
