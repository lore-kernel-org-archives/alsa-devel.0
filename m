From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: RME Hammerfall HDSP 9652
Date: Wed, 27 Aug 2003 07:29:57 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGIEPKDAAB.mknecht@controlnet.com>
References: <20030827160852.D21247@nautronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030827160852.D21247@nautronix.com.au>
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

Nick,
   Hi. I see you got a couple of responses from Thomas. Indeed, there is a
new working driver for the HDSP 9652. I am unclear whether you are using
this in your setup? If you are not you must upgrade to that new source code
before you will get good results. As Thomas said, I had to downgrade the
firmware to the older revision or things do not work at all.

   I want to point out that while I *can* run 96KHz between two boxes, I
have not tested it AT ALL! All I have done in this area is to set the card
at 96KHz and see hdspmixer show that the number of channels is cut in half.
I have no personal need for 96KHz yet, so none of this has been on my to-do
list.

   Using the new (and I think unreleased) driver I have tested all 26
physical inputs, all 26 physical outputs and all 26 playback outputs. The
only two things that I have found that are not working this morning are:

1) spdif receive of audio
2) spdif clocking (lock/sync) indications

spdif transmit is fine at 44.1KHz.

   I look forward to hearing how you progress once you get set up to use
this card at 96KHz.

Cheers,
Mark

> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Nick Arnold
> Sent: Wednesday, August 27, 2003 1:09 AM
> To: alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] RME Hammerfall HDSP 9652
>
>
> Hello,
>
> We here are attempting to get the RME Hammerfall HDSP 9652 card
> working with
> ALSA 0.9.6 on a SMP redhat 9 box.  We're trying to use 12 input
> channels and
> three output channels, running at 96KHz 24bit samples.  The output of
> "uname -a" on the box says:
>
>     Linux wombat 2.4.20-19.9smp #1 SMP Tue Jul 15 16:45:28 EDT 2003 i686
>     athlon i386 GNU/Linux
>
> We had been successfully using the "old" RME Hammerfall 9652 with
> ALSA 0.9.0
> beta12 on an older machine with the same channels/sample rate/sample size.
>
> With a signal connected to one input channel and nothing written
> to the card
> we're seeing output on several channels.  I think this could be related to
> settings of the hardware mixer?  I'm looking into the "amixer" utility but
> have so-far been unable to find any options that help.
>
> We have a known signal (IRIG-B) connected to one input channel and our
> software is now having trouble decoding the signal when it didn't before.
> We're not sure why this could be occuring.
>
> 1) first of all, we're assuming it is possible to get the card working on
>    this setup?
>
> 2) I'm trying to determine if this card actually supports 96KHz (ie as a
>    parameter to snd_pcm_hw_params_set_rate_near() for example) --
> the "old"
>    card was always set to 48KHz and we "simulated" 96KHz with two 48KHz
>    channels per 96KHz channel.  Is this still the way to do it?
>
> 3) It seems we need to find the right "amixer" incantations to
> get the driver
>    into a workable state.  The one thing that seems to have
> helped so far is
>    to set the "Sample Clock Source" interface of the mixer to
> "Internal 96.0
>    kHz" with the command:
>
>         amixer -c 0 cset -numid=11 6
>
>    But we're not sure this is really what we want.  Are there
> other commands
>    we need?  I don't believe we have a problem with output channel levels
>    since we've played with these.
>
> any help much appreciated,
>
> nick.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
