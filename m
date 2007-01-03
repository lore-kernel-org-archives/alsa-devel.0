From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Dual Interface Codecs
Date: Wed, 03 Jan 2007 20:31:24 +0000
Message-ID: <1167856284.26687.98.camel@localhost.localdomain>
References: <1167853658.26687.84.camel@localhost.localdomain>
	<459C0D80.9050807@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <459C0D80.9050807@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Seth Forshee <seth.forshee@gmail.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-01-03 at 20:09 +0000, James Courtier-Dutton wrote:
> Liam Girdwood wrote:
> > I'd like to gather some opinion on the best way to expose dual interface
> > codecs to alsa-lib and userspace in general.
> > 
> > Consider a codec with 2 digital audio interfaces :-
> > 
> >  1. I2S interface to host CPU
> >  2. PCM interface to BT codec or GSM modem.
> > 
> > Interface 1 is used for traditional playback and record. Interface 2 is
> > used to send and receive PCM audio to a BT codec (for Tx/Rx) from/to an
> > onboard Mic/Speaker.  e.g.
> > 
> >                ____________       DAI 2        ______
> > Mic --------> |   Codec    | <==============> |  BT  | --<
> > Spk <---------|____________|                  |______|
> >                     /\
> >                     ||  DAI 1
> >                     ||
> >                 ____\/____
> >                |   CPU    |
> >                |__________|
> > 
> > 
> > This allows BT/GSM audio to work without the CPU DMAing any pcm data as
> > audio is now sent directly via the audio codec (the CPU can then sleep).
> > 
> > Currently, we have both interfaces exposed to userspace as PCM's. This
> > allows for hw params to be configured for interface 2 (as they would for
> > any other device). The only difference is that we never start the PCM
> > and always keep it in the prepared state.
> > 
> > There is the obvious problem that applications may try and start this
> > pcm, so I'm wondering if we need a new class of pcm device that doesn't
> > support a host buffer (e.g. bufferless) and cant be started ? or
> > alternatively some other approach may be better.
> > 
> > Cheers
> > 
> > Liam 
> > 
> 
> A PCM interface is purely for sending PCM audio from the CPU to an 
> external device. I.e. For DAI 1
> If you don't have any PCM audio to send, do not implement a PCM 
> interface for it. Just implement a control interface for them, so that 
> an application can control the sample rate etc. of interface 2 with a 
> mixer application. You can also arrange for the mixer to not appear in 
> alsamixer that uses the simple mixer interface, but can still be 
> controlled by specific application or via amixer.
> 
> James

I went with the PCM idea as I thought it would better that we keep the
alsa API consistent for setting rate, channels, formats, etc. without
introducing another way of doing this for certain sound devices. This
should also keep it more portable (for applications) between devices.

Cheers

Liam 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
