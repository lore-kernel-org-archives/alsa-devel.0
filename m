From: Mark Knecht <markknecht@comcast.net>
Subject: Re: RME Hammerfall HDSP 9652
Date: Thu, 28 Aug 2003 05:16:11 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062072971.1634.9.camel@Wizard.knechthome.com>
References: <20030827160852.D21247@nautronix.com.au>
	 <34419.80.13.13.11.1061984366.squirrel@www.undata.org>
	 <20030828182641.A28493@nautronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030828182641.A28493@nautronix.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nick Arnold <nick.arnold@nautronix.com.au>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-08-28 at 03:26, Nick Arnold wrote:

> > Mark Knecht is currently using this code with success, but the card
> > behaved strangely with rev. 104 (0x68) firmware. He had to downgrade it to
> > rev. 101 (0x65) for the card to work properly. 
> >
> > [and Mark concured he had to downgrade the firmware]
> 
> We have not made any changes to the firmware thus far.  Unsure if its
> required or not.  
> 
> 1) do we need to do this?  Are there some characteristic symtoms to look for?

In 44.1K operation with rev. 104 and using hdspmixer it's just  lot of
bad signals on all the channels in my case. I do not know what the
symptoms would look like in 96K.


> Okay, we've set the "Sample Clock Source" on the mixer to 96kHz.  This has
> changed the output of "amixer -contents" to show 14 output channels instead
> of 26.  We can open the card in this mode and can use "aplay" and "arecord"
> (see more discussion below).
> 
> However, I'd appreciate some clarification on this point.  This setting seems
> to imply that the new card can run at 96kHz and is aware that 2 48kHz ADAT
> channels are to be combined into one logical 96kHz channel.  Also that the
> card itself will look after the interleaving and de-interleaving of these
> channels.  
> 
> 2) is my understanding of the 96kHz mode correct?

It is my understanding also. The RME manual concurs.

<SNIP>
> 
> 4) why is the number of channels now 14?  It would seem to make sense for it
>    to be 13 -- half the total 46kHz channels available.  

spdif continues to run at 48K stereo instead of 96K mono I believe.


> The file test_tone_1khz.raw is a pure 1kHz tone generated in matlab.  The
> recording shows the sign wave smooth in most places, but occasionally the
> signal departs from the wave and saw-tooths or jumps for some tens of
> samples.  It appears as though some samples are being lost.

If the HDSP 9652 is the master clock source, is the receiving device set
to use ADAT clock, so that it remains synced? I need to do this at 44.1K
also. Actually, I have not looked at the signal received to make sure
there are no sync problems. I'm just using my ears.


> PS. Mark also mentioned some problems related to the spdif still remain in
> the driver.  We are not using the spdif interface so I'm assuming we can
> safely ignore those issues.

At 44.1K, yes, I'm ignoring it and not having any other problems so far.
(That I've noticed, but you have me curious)

- Mark



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
