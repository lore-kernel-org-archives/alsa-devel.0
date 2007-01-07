From: Paul Abrahams <abrahams@acm.org>
Subject: Re: PROBLEM: Probable kernel bug in VT8233 drivers
Date: Sat, 6 Jan 2007 22:24:27 -0500
Message-ID: <200701062224.27608.abrahams@acm.org>
References: <200701041332.46215.abrahams@acm.org>
	<200701041823.48794.abrahams@acm.org>
	<1167956020.11404.31.camel@mindpipe>
Reply-To: abrahams@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from alnrmhc14.comcast.net (alnrmhc14.comcast.net [206.18.177.54])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 51A341A9
	for <alsa-devel@alsa-project.org>; Sun,  7 Jan 2007 04:24:34 +0100 (MET)
In-Reply-To: <1167956020.11404.31.camel@mindpipe>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org, Peter Zubaj <pzubaj@gaya.sk>
List-Id: alsa-devel@alsa-project.org

On Thursday 04 January 2007 7:13 pm, Lee Revell wrote:
> On Thu, 2007-01-04 at 18:23 -0500, Paul Abrahams wrote:
> > On Thursday 04 January 2007 4:06 pm, Peter Zubaj wrote:
> > > If card is in /proc/asound/cards then driver is loaded and working.
> > > Probably Yast will fail to load driver again, because it is already
> > > loaded.
> > >
> > > You have probably problem with dev files. Check if there are dev files
> > > in /dev/snd subdir (I think this is default).
> > >
> > > Something like this:
> > > crw-------  1 peter root 116, 13 Jan  4 17:03 controlC0
> > > crw-------  1 peter root 116, 20 Jan  4 17:03 controlC1
> >
> > This is getting interesting.  I do not have a /dev/snd directory.  I
> > tried reinstalling the devs rpm package, and that recreated /dev/snd, but
> > after a reboot /dev/snd was gone again.
>
> This is a bug in your distro.  udev is supposed to create those files.

I just updated ALSA from version 1.0.10 to version 1.0.13 and -- miracle of 
miracles -- my sound is back!

Paul

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
