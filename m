From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Pops at start of song
Date: Wed, 19 Nov 2003 15:18:02 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGCEKEDNAB.mknecht@controlnet.com>
References: <3FBBEB78.3030706@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FBBEB78.3030706@pianodisc.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: derosier@pianodisc.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Steve,
   You're the first person I can remember to report something very similar
to what I'm dealing with every day. I get a huge loud cracking noise at the
start of any audio operation that is not vanilla Alsa - i.e. - anything
accessing OSS I think. In my case I think it's hardware based, but I'm not
sure. This happens only on my HDSP 9652 system. I have two other systems,
one using an onboard NForce audio device, and the other using an RME
Hammerfall Light, that act correctly.

   With the RME products we have the hdspconf application which shows the
sync frequency of the card. I normally run at 44.1K, but if I open hdspconf
and watch the card's frequency, it tells me that the card becomes unlocked
and changes sample rates when the noise happens. This happens when starting
any app that uses OSS (I think) like gxine, or xmms, or most games, or
browsing web pages. It does not happen when starting a native Alsa
application like alsaplayer.

   Does this sound at all like what you're experiencing?

- Mark

> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Steve
> deRosier
> Sent: Wednesday, November 19, 2003 2:15 PM
> To: alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] Pops at start of song
>
>
> All,
>
> We're having a problem with some of our audio applications.  When a song
> starts playing we will often hear a loud pop out of the speakers before
> it plays audio.  It seems dependent upon where we stoped and the specfic
> content of the last song, if we hit our "stop control" and abort in the
> middle of the song it may pop uppon restarting or starting a new song.
>
> One of our engrs found if he fills the entire buffer with zeros before
> quitting the program, on the next start it won't pop (though that moves
> the pop to the end of the previous due to a disconnect/jump in the
> created waveform).  Unless this is a hardware issue, this doesn't seem
> to be the right solution to me.  So:
>
> * What are things that we can do in our program using the alsa pcm
> functions to eliminate this?  Maybe a specific function we need to call
> or a particular sequence?
> * Or, is this something inherent in hardware and other than filling with
> zeros before we quit there's nothing we can do?
>
> I figure some of you have encountered this before, so maybe there's some
> ideas out there?
>
> If you're wondering what we do when a "stop" command comes in: pretty
> much nothing.  Basically my "ALSASender" routine ends and calls:
> void CDSP::ClosePCM( void )
> {
>    // some other bookkeeping goes here <snip>
>
>    snd_pcm_close( hPCM );
>
>    if( mPCMStatus )
>    {
>       snd_pcm_status_free( mPCMStatus );
>       mPCMStatus = NULL;
>    }
>
>    // Non-alsa related cleanup goes here <snip>
> }
>
> Also, note that we do get the same pops with using aplay.
>
> Thanks,
> - Steve
>
> PS Takashi -> I haven't given up on my serial driver patch, I was
> working on it when I got interupted with something else, it should be on
> its way soon; thanks for your help.
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
