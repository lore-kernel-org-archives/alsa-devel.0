From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: The users view of an audio card
Date: Fri, 20 Jul 2007 11:44:23 +0200
Message-ID: <1184924663.9013.1201147827@webmail.messagingengine.com>
References: <200707191812.55106.david.webb@noc.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id BE2C610382B
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jul 2007 11:44:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200707191812.55106.david.webb@noc.soton.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Webb <david.webb@noc.soton.ac.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

David Webb wrote
> 1.  A large number of users seem to be reporting problems with Nvidia and Via 
> soundcards.  As far as I can tell Nvidia and Via do not produce soundcards 
> but they do produce chipsets with southbridges which can connect to a 
> motherboard audio chip.  The when alsamixer (or Kmix) runs it reports 
> something like:
>   Card:  NVidia CK804
>   Chip:  Realtek AL650 rev 0
> Presumably because the southbridge is the primary PCI device.
> 
> So:
> 
> 1.1  Is the above always correct (so I can add it to the wiki)?

Yes.  An AC'97 or HDA system contains two parts: the controller, which
reads audio data from memory over the PCI bus, and the codec, which
converts the data from digital to analog and does analog mixing.
The southbridges from nVidia and VIA (and others) contain such a
controller.

> 2.  On different motherboards a Realtek 650 may be connected using a NVidia 
> CK804 with the intel8x0 alsa driver or using a VIA VT8233 with the vt82xx driver.
> 
> 2.1  Given that the audio chip registers are the same in both cases why are 
> two different drivers needed?

The driver has to interface with the controller (and with the codec
through the controller).

The code to handle various codecs is not part of the controller driver
but is contained in a separate module (snd-ac97-codec) that gets loaded
automatically.

> 3.  The Realtek 650 datasheet implies that independently of the mixing in the 
> main input -> line-out pathway, the input to the ADC (i.e. on capture) may 
> include more than one source (i.e. both audio and microphone).  However 
> alsamixer (and kmix) only allows me one input stream.  So:
> 
> 3.1  Is the manual misleading or have I misread it?

Register 1A allows to select one of the various input sources.  One of
them is the stereo mixer output, i.e., the same data that is output to
the speakers and that can contain the data of several inputs.

> 3.3  Is the driver assuming a old layout which fits most of the new audio chip 
> layout but not all?  (This is really a question about what sort of 
> warnings/advice should my write up include).

The AC'97 code assumes that codecs conform to the AC'97 specification.

However, mixer controls can be added, removed, or renamed by codec-
specific code in snd-ac97-codec or by mainboard-specific code in the
driver.  This code is continually changed and updated because every
mainboard out there seems to be wired differently.


Regards,
Clemens
