From: Peter Zubaj <pzubaj@gaya.sk>
Subject: Re: PROBLEM: Probable kernel bug in VT8233 drivers
Date: Thu, 04 Jan 2007 22:06:31 +0100
Message-ID: <1167944791.4321.12.camel@localhost.localdomain>
References: <200701041332.46215.abrahams@acm.org>
	<200701041421.35153.abrahams@acm.org>
	<1167941780.4321.7.camel@localhost.localdomain>
	<200701041551.10094.abrahams@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from arkady.gaya.sk (arkady.gaya.sk [62.168.75.2])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C8D3124A
	for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2007 22:04:18 +0100 (MET)
In-Reply-To: <200701041551.10094.abrahams@acm.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: abrahams@acm.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

If card is in /proc/asound/cards then driver is loaded and working.
Probably Yast will fail to load driver again, because it is already
loaded.

You have probably problem with dev files. Check if there are dev files
in /dev/snd subdir (I think this is default).

Something like this:
crw-------  1 peter root 116, 13 Jan  4 17:03 controlC0
crw-------  1 peter root 116, 20 Jan  4 17:03 controlC1
crw-------  1 peter root 116,  4 Jan  4 17:03 hwC0D0
crw-------  1 peter root 116, 14 Jan  4 17:03 hwC0D2
crw-------  1 peter root 116,  6 Jan  4 17:03 midiC0D0
crw-------  1 peter root 116,  5 Jan  4 17:03 midiC0D1
crw-------  1 peter root 116, 15 Jan  4 17:03 midiC0D2
crw-------  1 peter root 116, 16 Jan  4 17:03 midiC0D3
crw-------  1 peter root 116, 12 Jan  4 17:03 pcmC0D0c
crw-------  1 peter root 116, 11 Jan  4 17:03 pcmC0D0p
crw-------  1 peter root 116, 10 Jan  4 17:03 pcmC0D1c
crw-------  1 peter root 116,  9 Jan  4 17:03 pcmC0D2c
crw-------  1 peter root 116,  8 Jan  4 17:03 pcmC0D2p
crw-------  1 peter root 116,  7 Jan  4 17:03 pcmC0D3p
crw-------  1 peter root 116, 19 Jan  4 17:03 pcmC1D0c
crw-------  1 peter root 116, 18 Jan  4 17:03 pcmC1D0p
crw-------  1 peter root 116, 17 Jan  4 17:03 pcmC1D1p
crw-------  1 peter root 116,  3 Jan  4 17:03 seq
crw-------  1 peter root 116,  2 Jan  4 17:03 timer

Peter Zubaj

On Thu, 2007-01-04 at 15:51 -0500, Paul Abrahams wrote:
> On Thursday 04 January 2007 3:16 pm, Peter Zubaj wrote:
> > Hi,
> >
> > Looks like alsa driver is loaded and it should work.
> > Is your sound card working. Did you try play something ?
> 
> The card is not working.  The Yast installer says that the kernel module for 
> sound support could not be loaded, and I cannot get any sound at all.  Even 
> the alsaconf program, which normally plays when nothing else does, produces 
> no sound.   Its output includes this:
> 
> Starting sound driver:  via82xx                                       done
> /usr/sbin/alsactl: load_state:1236: No soundcards found...
> 
> Paul Abrahams
> 



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
