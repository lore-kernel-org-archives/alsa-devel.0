From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: Easy question: ppq and tempo
Date: Fri, 24 May 2002 19:35:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020524173546.GA23700@idefix.fvdpol.home.nl>
References: <Pine.LNX.4.21.0205241612070.761-100000@summer.quitte> <200205241435.QAA00530@alsa.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail1.home.nl (mail1.home.nl [213.51.129.225])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA03057
	for <alsa-devel@alsa-project.org>; Fri, 24 May 2002 19:35:42 +0200
Content-Disposition: inline
In-Reply-To: <200205241435.QAA00530@alsa.alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Tim Goetze <tim@quitte.de>, Gerald Grabner <gerry@mechanik.tu-graz.ac.at>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I don't want to spoil the party, but PPQ is indeed parts per quarter note
and is used to specify the desired resoluting for the sequencer timing grid.

Let me explain:

If the sequencer is set to eg. 4 PPQ this means that a quarter note 
devided in 4 parts, actually being 16th notes in 4/4 meter. 

Actually, I've a Roland DR-550mkII drum machine on my desk which works in 4
PPQ. On it's display there is a grid with 16 columns, at 4 PPQ every grid
unit corresponds with one tick (as specified in the song position field for
an event).

Since a 4 PPQ is rather course for most sequences (you get instantanious
quantisation!) most sequencer applications use a higher resolution, eg. 384
PPQ (Steinberg Cubase) or 480 (Emagic Logic).

If the tempo would be set to 120 bpm, which is 120 quarter notes per minute
or 2 quarter notes per second, then in case of a 4 PPQ sequence there would
be 8 parts per second. Changing the tempo (quite a common operation) would
leave the sequencer events at the same grid position while changing the time
(in seconds) at which they would be dispatched

So the "it" Paul mentioned has nothing (directly) to do with number of
seconds (Paul, I presume you were refering to the clock frequency the
sequencer engine is running at).

Frank. 



see also an ancient document on the ALSA sequencer:
http://www.alsa-project.org/~frank/alsa-sequencer/node5.html


On Fri, May 24, 2002 at 10:37:49AM -0400, Paul Davis wrote:
> >>"ppq" stands for "parts per quarter". as the header file suggests
> >>without much explanation, its length of a quarter note expressed in
> >>clock ticks. if the meter is 4/4 and the tempo is 120bpm, then a
> >>quarter note lasts 0.5 seconds. if the clock used for timing ticks 100
> >>times per second, there are 50 clock ticks per quarter note, so
> >>ppq=50.
> >
> >though usually it will be a number divisible by 3 and 4 to make
> >triplets and even beats alike coincide with integer ticks. cubase
> >on the atari used to set this to 192, though some do prefer 480 or
> >even more to allow for minute timing ('groove') adjustments.
> 
> where "it" is the clock ticks per second. 
> 
> thanks tim, i had always wondered why 192 or 480 etc. was used, and
> never knew until now :)
> 
> --p
> 
> _______________________________________________________________
> 
> Don't miss the 2002 Sprint PCS Application Developer's Conference
> August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
