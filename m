From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Dual Interface Codecs
Date: Thu, 04 Jan 2007 17:50:37 +0000
Message-ID: <1167933037.13864.16.camel@localhost.localdomain>
References: <1167853658.26687.84.camel@localhost.localdomain>
	<459C0D80.9050807@superbug.co.uk>
	<1167856284.26687.98.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1167856284.26687.98.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Seth Forshee <seth.forshee@gmail.com>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-01-03 at 20:31 +0000, Liam Girdwood wrote:
> On Wed, 2007-01-03 at 20:09 +0000, James Courtier-Dutton wrote:
> > Liam Girdwood wrote:
> > > I'd like to gather some opinion on the best way to expose dual interface
> > > codecs to alsa-lib and userspace in general.
> > > 
> > > Consider a codec with 2 digital audio interfaces :-
> > > 
> > >  1. I2S interface to host CPU
> > >  2. PCM interface to BT codec or GSM modem.
> > > 
> > > Interface 1 is used for traditional playback and record. Interface 2 is
> > > used to send and receive PCM audio to a BT codec (for Tx/Rx) from/to an
> > > onboard Mic/Speaker.  e.g.
> > > 
> > >                ____________       DAI 2        ______
> > > Mic --------> |   Codec    | <==============> |  BT  | --<
> > > Spk <---------|____________|                  |______|
> > >                     /\
> > >                     ||  DAI 1
> > >                     ||
> > >                 ____\/____
> > >                |   CPU    |
> > >                |__________|
> > > 
> > > 
> > > This allows BT/GSM audio to work without the CPU DMAing any pcm data as
> > > audio is now sent directly via the audio codec (the CPU can then sleep).
> > > 
> > > Currently, we have both interfaces exposed to userspace as PCM's. This
> > > allows for hw params to be configured for interface 2 (as they would for
> > > any other device). The only difference is that we never start the PCM
> > > and always keep it in the prepared state.
> > > 
> > > There is the obvious problem that applications may try and start this
> > > pcm, so I'm wondering if we need a new class of pcm device that doesn't
> > > support a host buffer (e.g. bufferless) and cant be started ? or
> > > alternatively some other approach may be better.
> > > 
> > > Cheers
> > > 
> > > Liam 
> > > 
> > 
> > A PCM interface is purely for sending PCM audio from the CPU to an 
> > external device. I.e. For DAI 1
> > If you don't have any PCM audio to send, do not implement a PCM 
> > interface for it. Just implement a control interface for them, so that 
> > an application can control the sample rate etc. of interface 2 with a 
> > mixer application. You can also arrange for the mixer to not appear in 
> > alsamixer that uses the simple mixer interface, but can still be 
> > controlled by specific application or via amixer.
> > 
> > James
> 
> I went with the PCM idea as I thought it would better that we keep the
> alsa API consistent for setting rate, channels, formats, etc. without
> introducing another way of doing this for certain sound devices. This
> should also keep it more portable (for applications) between devices.
> 

Had a couple thoughts on this whilst on the way to work this morning.
I'm considering making the following additions to alsa-lib &
alsa-kernel :-

 1. Add two new PCM classes. e.g. SNDRV_PCM_CLASS_BT_CODEC and
SNDRV_PCM_CLASS_GSM_MODEM. This will give userspace more info about the
PCM type and should only require minimal changes to alsa-kernel and
alsa-lib (as it's informational only).

 2. Add two new PCM stream types. e.g. SNDRV_PCM_STREAM_BYPASS_IN, and
SNDRV_PCM_STREAM_BYPASS_OUT. Opening a PCM with this option would signal
alsa-lib and sound/core not to buffer any audio data (as it will be
bypassing the CPU). Userspace could treat this PCM as any other, except
it would never need to read or write pcm data to it.

Liam




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
