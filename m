From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Assert in pcm_params.c
Date: Mon, 20 Apr 2015 12:17:36 +0100
Message-ID: <201504201217.36477.gineera@aspect135.co.uk>
References: <201504180908.47022.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net
 [62.24.128.238])
 by alsa0.perex.cz (Postfix) with ESMTP id D0D342657B0
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 13:17:32 +0200 (CEST)
In-Reply-To: <201504180908.47022.gineera@aspect135.co.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Saturday 18 April 2015 09:08, I wrote:
> The following assert is being hit in pcm_params.c:
>
> "pcm_params.c:2249: snd1_pcm_hw_params_slave: Assertion `err >= 0' failed."
>
> This is from a developer using Portaudio in his own application; I have yet
> to ascertain full details, but it is trying successive sample rates to see
> which are valid.

Further info: this occurs with an Intel motherboard/soundcard, attempting to 
open and config the stream at 44100 using front, surround or hdmi pcm, having 
previously opened and tried at a lower, not-supported samplerate, and closed.
AFAIK other pcms work OK.

The assert is hit with all current Debian and Ubuntu distros, for example
     Debian 8 (jessie) 32 bit:  kernel 3.16.0-4-686-pae (Alsa 1.0.28)
but is not seen with Fedora 20 or OpenSuse 12.1 (do they have asserts off?).

> Does this point to a flaw in the configuration or possibly a bug in
> Alsa-lib or can it occur just as a result of misuse of the Alsa API?

I will try to conceive some more tests.  How can we debug this further?

Regards

Alan
