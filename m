From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: audio via ethernet (was: dolby digital output)
Date: Mon, 18 Feb 2002 17:43:51 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFIECJCBAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
In-Reply-To: <3C71333C.1C775561@hardco.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: stef <stef@hardco.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

When you switch from circuit based technologies to packet based ones, the
problems you have to solve are totally different.
1) Circuit requires clock sync across the entire network just like the old
TDM based telephone networks need. Packet does not.
2) Circuit introduces no delay for PCM data. Packet introduces a small
delay(normally less than 1 ms). (due to the size of the packet).
3) Circuit SPDIF cannot handle 8 channel 32bit audio. (The next DVD
standard). Packet technologies can.
4) All the problems of sending audio over packets have already been solved
by the Voice over IP people.
5) The only real problem left with packet is QOS (quality of service across
an entire network). But most people will just have point to point links in
an audio setup. E.g. From PC to AMP.

Cheers
James


> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of stef
> Sent: 18 February 2002 17:01
> To: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] audio via ethernet (was: dolby digital output)
>
>
> I think sending realtime audio data via eternet will be
> extremely difficult. It should be impossible to synchronize
> sample clock via ethernet. So each device has to have its
> own sample clock. This requires:
>
> - resampling units (=no lossles connections possible)
> or
> - large buffers to slowly adapt sample rates
>   (huge variing latency, clock jitter, ...)
>
> With S/PDIF or any other common digital audio interface
> it is at least possible to synchronize the receiver
> to the transmitter's clock.
> So you have to resample only if you're mixing
> two or more digital inputs into one output.
>
> If you're using pro equipment, it is even possible
> to remotely clock digital audio sources (wordclock line).
> In this case, you never have to resample and digital
> audio processing can be lossless.
>
> But with ethernet connections it is even impossible
> to use separate digital-input amplifiers for
> your right and left speaker. (unless you add
> extra wordclock cabling...)
>
> I don't know how the 'Wireless Multimedia Alliance'
> (www.wimedia.org, JVC, Sony,...) is going to handle these
> problems. Seems as if they extend the wireless lan standard
> by some sort of real-time transfers. Like USB. They call
> it IEEE 802.15.3.
>
> Any comments? Am i wrong? What about Yamaha's MLAN (ieee1394)?
>
> Stef(an).
>
>
>
>
> James Courtier-Dutton wrote:
> >
> > So all I need now, is an Digital Amp with an Ethernet port for
> all 6 Channel
> > PCM, AC3 and DTS output.
> > I already have an ethernet card for my PC and a HUB.
> >
> > magic.gibson.com must be stupid not to realise that what we
> really want is
> > an AMP with an Ethernet port, not yet another sound card.
> >
> > We could then just connect the AMP to the ethernet port on any
> PC, and have
> > perfect digital quality output.
> > Alsa would then not be needed, because once the audio is in packets, it
> > would be better to keep it that way in the application.
> >
> > One could even use Radio Lan technologies, and thus remove all
> the cabling
> > as well.
> >
> > Cheers
> > James
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
