From: Paul Davis <pbd@op.net>
Subject: Re: Easy question: ppq and tempo
Date: Fri, 24 May 2002 10:37:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205241435.QAA00530@alsa.alsa-project.org>
References: <Pine.LNX.4.21.0205241612070.761-100000@summer.quitte>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA00530
	for <alsa-devel@alsa-project.org>; Fri, 24 May 2002 16:35:29 +0200
In-Reply-To: Your message of "Fri, 24 May 2002 16:18:16 +0200."
             <Pine.LNX.4.21.0205241612070.761-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: Gerald Grabner <gerry@mechanik.tu-graz.ac.at>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>"ppq" stands for "parts per quarter". as the header file suggests
>>without much explanation, its length of a quarter note expressed in
>>clock ticks. if the meter is 4/4 and the tempo is 120bpm, then a
>>quarter note lasts 0.5 seconds. if the clock used for timing ticks 100
>>times per second, there are 50 clock ticks per quarter note, so
>>ppq=50.
>
>though usually it will be a number divisible by 3 and 4 to make
>triplets and even beats alike coincide with integer ticks. cubase
>on the atari used to set this to 192, though some do prefer 480 or
>even more to allow for minute timing ('groove') adjustments.

where "it" is the clock ticks per second. 

thanks tim, i had always wondered why 192 or 480 etc. was used, and
never knew until now :)

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
