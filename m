From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: RME Hammerfall HDSP 9652
Date: Mon, 1 Sep 2003 13:04:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33162.80.11.138.132.1062414263.squirrel@www.undata.org>
References: <20030827160852.D21247@nautronix.com.au>
        <34419.80.13.13.11.1061984366.squirrel@www.undata.org>
        <20030828182641.A28493@nautronix.com.au>
        <32941.193.253.35.6.1062074441.squirrel@www.undata.org>
        <20030901175928.B22322@nautronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030901175928.B22322@nautronix.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: nick.arnold@nautronix.com.au
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Hello again,
>
> We seem to have got the card working both for capture and playback(!).
>
> Thanks to everyone for their replies.  We were not expecting so much
> positive response.  If any of the respondants are in Fremantle Perth
> sometime send us an email and we'll take you to lunch!
>

Who knows, thanks !

> The three things we did:
>
> 1) applied the patch to the hdsp driver.  This solved (rather than
> "ameliorated" as I incorrectly wrote earlier) the unexplained signal on
> the output channels.
>
> 2) found the right "amixer" settings for our setup:
>
>         #!/bin/bash
>
>         amixer -c 0 cset numid=11 0
>         amixer -c 0 cset numid=13 0
>
>         for i in $(seq 1 26);do
>             amixer -c 0 cset name=Chn,index=$i 32768
>         done
>
>    - ie. the sync reference was an external word clock, so the card
> should
>      not use any internal clock source; and output channels should be
> turned on.
>
>    (I neglected to mention earlier that we have an external work clock
> source and hence the card must run as a slave and not use any of the
> "Internal XXX kHz" sample source clock settings.  It took me awhile
> to realise the importance of this piece of information.)
>
> 3) changed to a working AD/DA converter box. :)  Almost at the point of
> giving-up we swapped to a different AD/DA converter box and found the
> card worked!
>
> I've attached the output of "amixer contents" and the interesting bit of
> the output of "lspci -vv" for the curious.  You'll notice the card is
> presenting as having 26 channels.  This has meant we have needed no
> changes to our software from the "old" Hammerfall.
>
> Our software was originally written to work with the "old" Hammerfall --
> I believe now called the DIGI 9652.  To the best of our understanding
> that card had no knowledge of ADAT "double speed" and hence we opened
> the card requesting 48kHz sampling and 26 channels.  We did the
> (de-)interleaving of channels ourselves.  This was done because we were
> under the impression it would support no other setttings.
>
> Now this software is running without change with the new card -- ie. 26
> channels; 48kHz; and we're doing the (de-)interleaving.  This is a great
> result.
>
> If this card is capable of performing the channel (de-)interleaving for
> us under our setup (a slave device auto-syncing to the word clock) we'll
> probably start looking into getting this working sometime soon, but its
> a lower priority.
>

If you try to do this, you'll have to manually switch to Internal 96 kHZ,
make sure you feed the card with a valid 96 kHz sync source, then switch
the card back to AutoSync. This is because there is no way an external
sync source can cause the card to switch mode, and the driver won't let
you switch to AutoSync if there isn't a valid sync source in the range of
the current speed mode (32 - 48 kHz for single speed, 64 - 96 kHz for
double speed).

Thomas





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
