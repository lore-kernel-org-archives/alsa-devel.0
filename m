From: Paul Abrahams <abrahams@acm.org>
Subject: Re: PROBLEM: Probable kernel bug in VT8233 drivers
Date: Thu, 4 Jan 2007 19:42:48 -0500
Message-ID: <200701041942.48947.abrahams@acm.org>
References: <200701041332.46215.abrahams@acm.org>
	<200701041823.48794.abrahams@acm.org>
	<1167956020.11404.31.camel@mindpipe>
Reply-To: abrahams@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from alnrmhc14.comcast.net (alnrmhc14.comcast.net [206.18.177.54])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3DC6024A
	for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2007 01:42:57 +0100 (MET)
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
> >
> > This is getting interesting.  I do not have a /dev/snd directory.  I
> > tried reinstalling the devs rpm package, and that recreated /dev/snd, but
> > after a reboot /dev/snd was gone again.
>
> This is a bug in your distro.  udev is supposed to create those files.

Maybe not -- although if you're right, it's an Opensuse fault, not an error of 
my making.  But is it possible that the /dev/snd files are created only after 
the sound system has been initialized successfully?

Paul

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
