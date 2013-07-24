From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Questions about virtual ALSA driver (dummy),
	PortAudio and full-duplex drops
Date: Wed, 24 Jul 2013 14:03:28 +0100
Message-ID: <201307241403.28873.gineera@aspect135.co.uk>
References: <51EF41C8.2040701@imi.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip07ir2.opaltelecom.net (out1.ip07ir2.opaltelecom.net
 [62.24.128.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 118F4265317
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 15:01:59 +0200 (CEST)
In-Reply-To: <51EF41C8.2040701@imi.aau.dk>
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
To: alsa-devel@alsa-project.org
Cc: portaudio@music.columbia.edu, audacity-devel@lists.sourceforge.net, Smilen Dimitrov <sd@imi.aau.dk>
List-Id: alsa-devel@alsa-project.org

Hi Smilen,

Some comments below, since I am (probably the only person) on Alsa, Portaudio 
and Audacity lists (but no expert).  Evidently you have gone to some lengths 
on this.

On Wednesday 24 July 2013 03:54, Smilen Dimitrov wrote:
> Apologies in advance for the longish exposition - however, I have bumped
> into a problem with ALSA driver development, which raised some questions
> that I cannot really understand at the moment. I find it especially
> frustrating that I cannot formulate a simple question, but instead I have
> to resort to test code, captures and plots, to discuss my (mis)conceptions
> through those - so I hope at least someone will bear with this wall of text
> (some 23KB plaintext), and I'll be able to get some help with this.
>
> I originally started working on a 16-bit, 44.1 kHz stereo ALSA driver for a
> device; and came to a point where I could achieve (what I thought was)
> full-duplex by running `arecord` and `aplay`, in separate shells, without
> any problems. However, if I tried to do the same from `audacity` - that is,
> have "record" running, while another track plays on the same card, with
> "Audacity Preferences/Recording/Overdub: Play other tracks while recording
> new one" enabled - then I'd experience some strange drops in the capture,
> which were not reported by any debug messages, even after I rebuilt and
> used PortAudio with debug messages on (my eventual goal is to have this
> experiment running in Audacity without drops).

I think there are too many areas embroiled in this, and they need to be 
separated out.  If you have issues writing an Alsa driver, don't rely on 
Portaudio for testing, but use a range of audio players, or other means, and 
enlist help just from Alsa-devel, describing the hardware and ideally 
presenting your driver code.  Have you read Takashi Iwai's notes:

	http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/index.html ?

I suspect the 'dummy device' may not be a good model and you are not correctly 
reporting the number of samples transferred to the hardware?

It is probably reasonable to consider Audacity not a focus of concern, since 
it simply uses Portaudio.  If you think there is a problem with Portaudio, 
run tests with standard sound hardware such as on-board, PCI or USB units 
known to work with Alsa, and take the focus off your own driver (since others 
will not be able to reproduce your custom results anyway).  There are few 
within Portaudio who are familiar with the Alsa code but we will try to 
assist if needed (I think that list has a 20K size limit IIRC).  Note that 
Audacity does not utilise the latest Portaudio code available, so consider 
getting a more recent version.

Hope this can help to move your problem forward.

Regards

Alan
