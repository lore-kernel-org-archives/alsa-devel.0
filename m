From: Paul Davis <pbd@op.net>
Subject: Re: ALSA Hammerfall DSP driver
Date: Sun, 26 May 2002 08:05:41 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205261202.OAA03338@alsa.alsa-project.org>
References: <3CEFE01E.AE1D59A6@telia.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA03338
	for <alsa-devel@alsa-project.org>; Sun, 26 May 2002 14:02:56 +0200
In-Reply-To: Your message of "Sat, 25 May 2002 21:03:58 +0200."
             <3CEFE01E.AE1D59A6@telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Marcus Andersson <054185595@telia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> i know its mundane, but are you sure you have the cables hooked up
>> correctly?
>
>I booted windows to check the setup, and it works.
>
> you can set the passthru control
>> 
>>            amixer cset name=Passthru 1
>> 
>> and check that passthru is working OK.
>
>This doesn't work either.

OK, thats useful information. I wish I knew what it meant :) My best
guess right now is that its something to do with the channel mapping;
since the i/o configuration on the multiface is different, it may be
that i need to change something about how we address certain channels.

># alsactl store 1
>alsactl: get_control:359: Unknown control type: 6

have you updated your alsa-utils and alsa-lib? there was a new control
type (64 bit integer) introduced for the H-DSP.

>At some point the 'MIDI STATE out' is lit and stays lit. I don't use
>MIDI. (I think, if not aplay tries to play a wav as midi.)

Do you have any idea at what point this happens?

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
