From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: powermac 0.9beta12 on tibook not working
Date: Fri, 22 Mar 2002 21:01:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3C9B8DB5.1156389C@folkwang-hochschule.de>
References: <1016570181.953.20.camel@bennyhill.belmont>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: matt yee-king <yeeking@no-future.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

matt yee-king wrote:
> 
> Hello
> 
> sorry for posting on devel cos i'm not a developer, but no one on
> alsa-user seemed to be able to help me....
> 
> Could somebody tell me the state of the alsa 0.9beta12 powermac driver?
> 
> i tried to build it on a benh 2.4.19 kernel as well as a yellowdog
> 2.4.10 one. it won't build - there seems to be a problem with the
> suspend/ sleep features.

there are some header files that alsa does not seem to know about
(something like feature.h).
could you post the error mesg ?

> i managed to build 0.9beta10 but this doesn't seem to work properly -
> sound does come out with some oss apps but the alsamixer doesn't seem to
> control the volumes. when trying this version , i found that alsa-lib
> 9beta10 wouldn't build so i used alsa-lib-9beta12...  ...
> 
> so is the driver just not up and running yet? shoould i try 0.5? 

hardly worth it. 0.5 is dead, and i doubt it even has mac support.

> has
> anyone got the driver working on a revA tibook?

at least i got it to run on a g3 powerbook, but that won't help you
much, i'm afraid.

here is an old posting from takashi that did the trick for me.
perhaps your problem is similar ?

> At Mon, 08 Oct 2001 19:33:02 +0200,
> Jörn Nettingsmeier wrote:
> > 
> > "Jeffrey W. Baker" wrote:
> > > 
> > > The pmac driver doesn't compile from the latest release nor from CVS.  It
> > > uses feature_test, feature_set, and feature_clear symbols, but these are
> > > provided by arch/ppc/kernel/feature.c which doesn't seem to get built (at
> > > least in my configuration.).  Also, nothing in the kernel depends on
> > > feature.c and no part of the kernel uses the three above-mentioned
> > > functions.
> > > 
> > > It seems like feature.c might have been replaced with pmac_feature.c,
> > > although I'm not seeing any particular mapping between the functions in
> > > those two files.
> > 
> > same here with alsa-cvs from last wednesday and the then current
> > benh kernel on a g3 pismo powerbook.
> > takashi, are you still maintaining it or should we be nagging ian
> > sandoe instead ?
> 
> Sorry, I'd like to work on it but had no time for 0.9.0.
> 
> Anyway, now I fixed the relevant part and committed to cvs.
> There is a definition of "PMAC_NEW_FEATURE" in pmac.c.
> If your kernel supports pmac_feature.h, please define this (as default
> it's undefined).  Unfortunately, there is no way to determine whether
> the new or old feature is used during compile.
> In future, this check will be done in configure script or Ben will add
> a condition/flag for this purpose.
> 
> 
> Takashi
> 


-- 
Computer Science is no more about computers than
astronomy is about telescopes.
	- Edsger W. Dijkstra
Sigh.
	- me

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
