From: stef <stef@hardco.de>
Subject: Re: audio via ethernet (was: dolby digital output)
Date: Mon, 18 Feb 2002 18:00:44 +0100
Message-ID: <3C71333C.1C775561@hardco.de>
References: <NGBBLNODKDFPBFMBBFAFOECBCBAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I think sending realtime audio data via eternet will be
extremely difficult. It should be impossible to synchronize
sample clock via ethernet. So each device has to have its
own sample clock. This requires:

- resampling units (=no lossles connections possible)
or
- large buffers to slowly adapt sample rates
  (huge variing latency, clock jitter, ...)

With S/PDIF or any other common digital audio interface
it is at least possible to synchronize the receiver
to the transmitter's clock.
So you have to resample only if you're mixing
two or more digital inputs into one output.

If you're using pro equipment, it is even possible
to remotely clock digital audio sources (wordclock line).
In this case, you never have to resample and digital
audio processing can be lossless.

But with ethernet connections it is even impossible
to use separate digital-input amplifiers for
your right and left speaker. (unless you add
extra wordclock cabling...)

I don't know how the 'Wireless Multimedia Alliance'
(www.wimedia.org, JVC, Sony,...) is going to handle these
problems. Seems as if they extend the wireless lan standard
by some sort of real-time transfers. Like USB. They call
it IEEE 802.15.3.

Any comments? Am i wrong? What about Yamaha's MLAN (ieee1394)?

Stef(an).




James Courtier-Dutton wrote:
> 
> So all I need now, is an Digital Amp with an Ethernet port for all 6 Channel
> PCM, AC3 and DTS output.
> I already have an ethernet card for my PC and a HUB.
> 
> magic.gibson.com must be stupid not to realise that what we really want is
> an AMP with an Ethernet port, not yet another sound card.
> 
> We could then just connect the AMP to the ethernet port on any PC, and have
> perfect digital quality output.
> Alsa would then not be needed, because once the audio is in packets, it
> would be better to keep it that way in the application.
> 
> One could even use Radio Lan technologies, and thus remove all the cabling
> as well.
> 
> Cheers
> James

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
