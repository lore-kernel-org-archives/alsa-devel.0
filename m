From: Nick Arnold <nick.arnold@nautronix.com.au>
Subject: RME Hammerfall HDSP 9652
Date: Wed, 27 Aug 2003 16:08:52 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030827160852.D21247@nautronix.com.au>
Reply-To: alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

We here are attempting to get the RME Hammerfall HDSP 9652 card working with
ALSA 0.9.6 on a SMP redhat 9 box.  We're trying to use 12 input channels and
three output channels, running at 96KHz 24bit samples.  The output of 
"uname -a" on the box says:

    Linux wombat 2.4.20-19.9smp #1 SMP Tue Jul 15 16:45:28 EDT 2003 i686
    athlon i386 GNU/Linux

We had been successfully using the "old" RME Hammerfall 9652 with ALSA 0.9.0
beta12 on an older machine with the same channels/sample rate/sample size.

With a signal connected to one input channel and nothing written to the card
we're seeing output on several channels.  I think this could be related to
settings of the hardware mixer?  I'm looking into the "amixer" utility but
have so-far been unable to find any options that help.
 
We have a known signal (IRIG-B) connected to one input channel and our
software is now having trouble decoding the signal when it didn't before.
We're not sure why this could be occuring.

1) first of all, we're assuming it is possible to get the card working on
   this setup?  

2) I'm trying to determine if this card actually supports 96KHz (ie as a
   parameter to snd_pcm_hw_params_set_rate_near() for example) -- the "old"
   card was always set to 48KHz and we "simulated" 96KHz with two 48KHz
   channels per 96KHz channel.  Is this still the way to do it?

3) It seems we need to find the right "amixer" incantations to get the driver
   into a workable state.  The one thing that seems to have helped so far is
   to set the "Sample Clock Source" interface of the mixer to "Internal 96.0
   kHz" with the command:

        amixer -c 0 cset -numid=11 6

   But we're not sure this is really what we want.  Are there other commands
   we need?  I don't believe we have a problem with output channel levels
   since we've played with these.

any help much appreciated,

nick.

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
