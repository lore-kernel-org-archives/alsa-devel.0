From: Nick Arnold <nick.arnold@nautronix.com.au>
Subject: Re: RME Hammerfall HDSP 9652
Date: Thu, 28 Aug 2003 18:26:41 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030828182641.A28493@nautronix.com.au>
References: <20030827160852.D21247@nautronix.com.au> <34419.80.13.13.11.1061984366.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <34419.80.13.13.11.1061984366.squirrel@www.undata.org>; from thomas@undata.org on Wed, Aug 27, 2003 at 01:39:26PM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks Thomas and Mark for your replies.  We've made some progress but are
not all the way there yet ...  

I'm replying in the most part to Thomas' response:

> > are attempting to get the RME Hammerfall HDSP 9652 card working ...
>
> With this driver version the matrix mixer code is still broken and the
> metering code is not implemented. Please apply the attach patch to correct
> this. 

We've applied the patch to hdsp.{h,c}.  The newly built driver has
ameliorated the problem of unexplained signal appearing on our output
channels.  Thats a win.

> Mark Knecht is currently using this code with success, but the card
> behaved strangely with rev. 104 (0x68) firmware. He had to downgrade it to
> rev. 101 (0x65) for the card to work properly. 
>
> [and Mark concured he had to downgrade the firmware]

We have not made any changes to the firmware thus far.  Unsure if its
required or not.  

1) do we need to do this?  Are there some characteristic symtoms to look for?

> > I'm trying to determine if this card actually supports 96KHz (ie as a
> > parameter to snd_pcm_hw_params_set_rate_near() for example) -- the "old"
> > card was always set to 48KHz and we "simulated" 96KHz with two 48KHz
> > channels per 96KHz channel.  Is this still the way to do it?
> 
> The card needs to be set to 96 kHz, then the ADAT channel coupling will
> work as you described.

Okay, we've set the "Sample Clock Source" on the mixer to 96kHz.  This has
changed the output of "amixer -contents" to show 14 output channels instead
of 26.  We can open the card in this mode and can use "aplay" and "arecord"
(see more discussion below).

However, I'd appreciate some clarification on this point.  This setting seems
to imply that the new card can run at 96kHz and is aware that 2 48kHz ADAT
channels are to be combined into one logical 96kHz channel.  Also that the
card itself will look after the interleaving and de-interleaving of these
channels.  

2) is my understanding of the 96kHz mode correct?

3) is it possible to use the "Internal 48.0 kHz" setting and keep things
   "like they used to be"?  Whereby we retain responsiblity for the
   interleaving and de-interleaving of channels; we operate on the full 26
   channels; and we can make little (if any) code changes?

4) why is the number of channels now 14?  It would seem to make sense for it
   to be 13 -- half the total 46kHz channels available.  

We've conducted a test using "aplay" and "arecord":

 - connected a physical loopback from the first output channel to first input
   channel 
 - executed: "aplay -r 96000 -f s32_le test_tone_1khz.raw"
 - executed at the same time: "arecord -r 96000 -f s32_le -I"

The file test_tone_1khz.raw is a pure 1kHz tone generated in matlab.  The
recording shows the sign wave smooth in most places, but occasionally the
signal departs from the wave and saw-tooths or jumps for some tens of
samples.  It appears as though some samples are being lost.

We've also attached an IRIG-B device to the 10th input channel during this
test.  The recording of that channel appears to show the signal has been
recorded without glitches.  

We're currently unsure how to interpret these results -- I can make snippets
of the files available if that would be useful.

Again, thanks for any advice,

nick.

PS. Mark also mentioned some problems related to the spdif still remain in
the driver.  We are not using the spdif interface so I'm assuming we can
safely ignore those issues.

--
This email is confidential and intended solely for the use of the individual to whom it is addressed.  Any views or opinions presented are solely those of the author and do not necessarily represent those of Nautronix Ltd.

If you are not the intended recipient, you have received this email in error and use, dissemination, forwarding, printing, or copying of this email is strictly prohibited.  If you have received this email in error please contact the sender.

Although our computer systems use active virus protection software, and we take various measures to reduce the risk of viruses being transmitted in e-mail messages and attachments sent from this company, we cannot guarantee that such
e-mail messages and attachments are free from viruses on receipt.  It is a condition of our using e-mail to correspond with you, that any and all liability on our part arising directly or indirectly out of any virus is excluded.
Please ensure that you run virus checking software on all e-mail messages and attachments before reading them.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
