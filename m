From: Paul Davis <pbd@op.net>
Subject: Re: Easy question: ppq and tempo
Date: Fri, 24 May 2002 10:03:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205241400.QAA32509@alsa.alsa-project.org>
References: <Pine.LNX.4.21.0205241242240.761-100000@summer.quitte>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA32509
	for <alsa-devel@alsa-project.org>; Fri, 24 May 2002 16:00:55 +0200
In-Reply-To: Your message of "Fri, 24 May 2002 12:48:15 +0200."
             <Pine.LNX.4.21.0205241242240.761-100000@summer.quitte>
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

>>I'm just starting to write my first alsa-lib midi applications. I'm 
>>wondering what the acronym ppq stands for and what it means (especially 
>>in relation to tempo). Unfortunately, I didn't find any docu on the 
>>topic of tempo.

>  int ppq;      /* time resolution, ticks/quarter */

  [ ... ]

>the value is usually synonymous to the 'division' of a standard midi
>file. 

"ppq" stands for "parts per quarter". as the header file suggests
without much explanation, its length of a quarter note expressed in
clock ticks. if the meter is 4/4 and the tempo is 120bpm, then a
quarter note lasts 0.5 seconds. if the clock used for timing ticks 100
times per second, there are 50 clock ticks per quarter note, so
ppq=50.

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
