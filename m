From: Black X <x.thug.85@gmail.com>
Subject: Re: Problem with Conexant
Date: Mon, 23 Apr 2007 10:10:47 +0307
Message-ID: <1177311827.24069.2.camel@dv2000.site>
References: <1177273495.5730.5.camel@dv2000.site>
	<1177295244.9698.40.camel@razman.gruemaster.com>
	<1177304689.23557.7.camel@dv2000.site>
	<1177306700.9698.51.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 38ED724821
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2007 09:11:19 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so1055859ugf
	for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2007 00:11:19 -0700 (PDT)
In-Reply-To: <1177306700.9698.51.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ok, I try that before and try it now, still no change, and still have
the same problem.
When I highest the sound volume of headphone this makes sound starting
noisy (and that's the same with PCM).
About speaker it's work fine, but IF I moving any window or rotate the
desktop cube this makes the sound very slow with noise

On Sun, 2007-04-22 at 22:38 -0700, Tobin Davis wrote:
> Did you try adjusting the PCM volume levels?  They may be set too low.
> That particular sound chip required a lot of manipulating to get
> functional, and is still very problematic.  Unfortunately, I have no
> way of testing it, so users (like yourself) have to be my ears.  The
> last time I worked with that particular configuration, the user that
> was testing said that it took a bit of tweaking with the PCM and other
> volume levels to get good sound.
> 
> Tobin
> 
> On Mon, 2007-04-23 at 08:11 +0307, Black X wrote: 
> > after I install the last alsa-driver from the link you give me it
> > ( alsa-driver-hg20070421.tar.bz2 ) I still have the same problem.  now
> > what I most to do to inform you about this issue?
> > 
> > 
> > Thank you.
> > 
> > On Sun, 2007-04-22 at 19:27 -0700, Tobin Davis wrote:
> > > Could you try the latest alsa-driver snapshot from
> > > ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver?
> > > 
> > > I can't tell what revision of Conexant code you are using based on
> > > your email.   Anything after 20070413 should work better, and it will
> > > also be the most current.  I haven't made any changes to the code
> > > since ~April 6.  If you are still having audio issues, let me know.
> > > 
> > > Tobin 
> > > 
> > > 
> > > On Sun, 2007-04-22 at 23:31 +0307, Black X wrote: 
> > > > Hello
> > > > 
> > > > First at all I wanna thanks Tobin Davis for his support to get Conexant
> > > > audio devices working under Linux, and I was testing his last patchs,
> > > > but I had a little problems with my sound card, the first one is about
> > > > headphone, it is works but with noise, and when I'm maximize the volume
> > > > of headphone the sound quality starting so weak.
> > > > 
> > > > The Second problem I had it is when I run the 3D Desktop Effects (XGL
> > > > with Compiz), that when I play any sound clip and moving any window or
> > > > rotate desktop cube that's making a noise with the sound, and the
> > > > quality of the sound clip it is so weak with slow playing in the sound.
> > > > 
> > > > I make a little screen cast about this problem and you can see it at
> > > > this link:
> > > > http://www.zshare.net/download/conexantproblem-ogg-tar-gz.html
> > > > 
> > > > any way this is my alsa information:  http://pastebin.ca/452453
> > > > finaly my device information :
> > > > http://h10025.www1.hp.com/ewfrf/wc/document?docname=c00715998&dlc=en&lc=en&cc=us
> > > > 
> > > > I 'm sorry, but the English it's not my mother language.
> > > > 
> > > > Thank you.
> > > > 
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@alsa-project.org
> > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > -- 
> > > Tobin Davis <tdavis@dsl-only.net>
> > 
> -- 
> Tobin Davis <tdavis@dsl-only.net>
