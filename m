From: Paul Abrahams <abrahams@acm.org>
Subject: Re: PROBLEM: Probable kernel bug in VT8233 drivers
Date: Thu, 4 Jan 2007 15:51:09 -0500
Message-ID: <200701041551.10094.abrahams@acm.org>
References: <200701041332.46215.abrahams@acm.org>
	<200701041421.35153.abrahams@acm.org>
	<1167941780.4321.7.camel@localhost.localdomain>
Reply-To: abrahams@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from alnrmhc11.comcast.net (alnrmhc11.comcast.net [206.18.177.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ECE24230
	for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2007 21:51:23 +0100 (MET)
In-Reply-To: <1167941780.4321.7.camel@localhost.localdomain>
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
To: Peter Zubaj <pzubaj@gaya.sk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 04 January 2007 3:16 pm, Peter Zubaj wrote:
> Hi,
>
> Looks like alsa driver is loaded and it should work.
> Is your sound card working. Did you try play something ?

The card is not working.  The Yast installer says that the kernel module for 
sound support could not be loaded, and I cannot get any sound at all.  Even 
the alsaconf program, which normally plays when nothing else does, produces 
no sound.   Its output includes this:

Starting sound driver:  via82xx                                       done
/usr/sbin/alsactl: load_state:1236: No soundcards found...

Paul Abrahams

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
