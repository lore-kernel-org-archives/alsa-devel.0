From: Stephen Hassard <steve@hassard.net>
Subject: Re: Questions regarding cs46xx support
Date: Fri, 03 May 2002 18:18:08 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.1.2.2.20020503181518.00b75af0@www.angiotech.com>
References: <HAEOIKGLLLDPLCHFOMMOMEBPCAAA.jordan.breeding@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from pd2mo2so.prod.shaw.ca (h24-71-223-10.cg.shawcable.net [24.71.223.10])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA10734
	for <alsa-devel@alsa-project.org>; Sat, 4 May 2002 03:18:39 +0200
Received: from pd2mr2so.prod.shaw.ca (pd2mr2so-ser.prod.shaw.ca [10.0.141.109])
 by l-daemon (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GVK00MB2BM3VP@l-daemon> for alsa-devel@alsa-project.org; Fri,
 03 May 2002 19:18:03 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca
 (pn2ml3so-qfe0.prod.shaw.ca [10.0.121.147]) by l-daemon
 (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GVK00EALBM3VH@l-daemon> for alsa-devel@alsa-project.org; Fri,
 03 May 2002 19:18:03 -0600 (MDT)
Received: from shwxpdual.hassard.net
 (h24-80-11-127.vc.shawcable.net [24.80.11.127])
 by l-daemon (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GVK006N1BM205@l-daemon> for alsa-devel@alsa-project.org; Fri,
 03 May 2002 19:18:03 -0600 (MDT)
In-Reply-To: <HAEOIKGLLLDPLCHFOMMOMEBPCAAA.jordan.breeding@inet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jordan Breeding <jordan.breeding@inet.com>, alsa-devel@alsa-project.org
Cc: Jordan Breeding <jordan.breeding@attbi.com>
List-Id: alsa-devel@alsa-project.org

At 12:04 PM 03/05/2002 -0500, Jordan Breeding wrote:
>Hello,
>
>   I have a SBLive! currently and love the support in for it in alsa
>including the fact that it has multi open on /dev/dsp so that if I run esd
>for an app that needs it I can still run xmms in regular oss mode or with
>alsa drivers and not worry about the fact that esd is also using /dev/dsp.
>I do not like however the actual sound that my SBLive! produces (I never
>have) and am thinking of going back to using a Turtle Beach Santa Cruz
>(based on the cs46xx).  At one point I got to use one of these cards and was
>very impressed with the sound quality in Windows and Linux, but at the time
>alsa wasn't available as an in kernel driver (2.5.x) and the oss drivers in
>the kernel didn't support multi open on /dev/dsp for the cs46xx, so my
>question is do the newest alsa drivers for this card (Santa Cruz - cs46xx)
>support multi open through both alsa and oss emulation on /dev/dsp?  Thanks
>for any information.  Please Cc: me as I am not on the list.
>
>Jordan Breeding

last time I checked alsa with a santa cruz I had difficulty getting much in 
the way of output. This was only a few versions back (say 2 months). It may 
have just been me tho. I must admit that I have had good luck with my SB 
Audigy under Alsa. the drivers seem quite mature (as they are strongly 
based on the SBLive!) and it works great with soundfonts and midi. digital 
output might still be a bit sketchy (I haven't tried it) but everything 
analog works great. It's definitely an audible inprovement over the SBLive! 
without sacrificing the great drivers ..

later,
Steve


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
