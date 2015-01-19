From: Tim Cussins <timcussins@eml.cc>
Subject: Re: [PATCH v2 1/1] alsa-lib: Add snd_pcm_start_at.
Date: Mon, 19 Jan 2015 11:16:05 +0000
Message-ID: <54BCE775.3020701@eml.cc>
References: <1418837267-10896-1-git-send-email-timcussins@eml.cc>	<CAN8cciZE+rHGuCHWjXbFi43ofR2k5w=P-hBvy4P69+Xeo5PVxA@mail.gmail.com>	<5492A7F9.8090602@eml.cc>	<54ABF459.8000504@linux.intel.com>	<54ABFB98.3050506@eml.cc>
 <CAN8ccibWaAmc8hMG5Eb2bLcKP4i-nWLrAETgFg2c-tGvd8QDwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2A5D1262632
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:16:20 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id A7A3320522
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 06:16:19 -0500 (EST)
In-Reply-To: <CAN8ccibWaAmc8hMG5Eb2bLcKP4i-nWLrAETgFg2c-tGvd8QDwQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: nstoughton@aether.com, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 09/01/15 12:03, Raymond Yau wrote:
>
>  >>
>  >>
>  >>>> Do your implementation need to set specific start threshold to prevent
>  >>>> the driver automatically start when you fill the buffer ?
>  >>>
>  >>>
>  >>>
>  >>>> Do the driver allow to start when there is no data ?
>  >>>>
>  >>>
>  >>> It's the responsibility of the client to set the start threshold to a
>  >>> safe and responsible value.
>  >>>
>  >>> It might suit some applications to allow both threshold start _and_
>  >>> start_at: My implementation doesn't preclude this.
>  >>
>  >>
>  >> Now I am confused... My understanding was that this feature is similar
>  >> to SSYNC in HDAudio, where everything is ready, buffers filled, DMAs
>  >> armed, FIFOs filled and the start condition only opens the last gate at
>  >> a specific time - possibly with multiple streams starting at the same
>  >> time. If you add a condition on the start_threshold you really don't
>  >> need any hardware-driven start, do you?
>  >
>  >
>  > What you've described is exactly what I had in mind, so we're still
> on the same page.
>  >
>  > I wanted to make it clear that my implementation of start_at doesn't
> *prevent* client code starting on a threshold *and* using start_at, even
> if it seems to us like a strange idea.
>
> http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html
>
> Handshake between application and library
>
> Do alsa lib assume all read/write must only call after calling
> snd_pcm_sw_params() ?
>
> It seem that proposed start_at() can only be call in
> SND_PCM_STATE_PREPARED and should fail when stream is already running

This sounds ok to me - I followed Nick Stoughton's lead on this.

> Are there any mean to cancel the scheduled snd_pcm_start_at  ?

There is no explicit mechanism in the proposed patch: The pending timer 
is cancelled if client code attempts to change the stream state. Would 
you like to see an explicit cancellation API?

> Seem there is no check when the application call snd_pcm_start_at()
> multiple times

The code only allows _one_ start_at timer to be pending. When 
snd_pcm_start_at() is called, the pending timer (if any) is cancelled 
(atomically) before being replaced by the new timer.

>  >
>  > Preventing the use of both requires us to show why it's never a
> useful idea, decide on policy (what do happens when client code tries to
> use both), and implement that policy. I'd rather just leave it as
> 'possible' :at()
>
