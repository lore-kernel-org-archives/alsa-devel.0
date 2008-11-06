From: Edward Terry <eterry@openboxbuilder.com>
Subject: Re: supported sound cards
Date: Thu, 06 Nov 2008 11:28:42 -0800
Message-ID: <4913456A.5040506@openboxbuilder.com>
References: <mailman.11.1225989357.1965.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173007pub.verizon.net (vms173007pub.verizon.net
	[206.46.173.7]) by alsa0.perex.cz (Postfix) with ESMTP id 6944624385
	for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2008 21:19:46 +0100 (CET)
Received: from [192.168.1.47] ([71.111.37.5]) by vms173007.mailsrvcs.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTPA id <0K9X00I14FEBGJ00@vms173007.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Thu, 06 Nov 2008 13:27:47 -0600 (CST)
In-reply-to: <mailman.11.1225989357.1965.alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> The only chip where hardware mixing is supported is Creative's Emu10k1
> (snd-emu10k1 driver), used on the SB Live!, most Audigy and certain
> low-end X-Fi cards.  (Cards with the 'real' X-Fi chip do _not_ work
> well in Linux.)
>
> Other supported chips are ICE1724 (M-Audio Delta 1010(LT), DiO 2496,
> 66, 44, 410, Audiophile 24/96; Digigram VX442; TerraTec EWX 24/96,
> EWS 88MT/D, DMX 6Fire, Phase 88; Hoontech SoundTrack DSP 24/Value/
> Media7.1; Event EZ8; Lionstracs Mediastation, Terrasoniq TS 88) and
> VT1720/24 (AMP AUDIO2000; M-Audio Revolution 5.1, 7.1, Audiophile 192;
> TerraTec Aureon 5.1 Sky, 7.1 Space/Universe, Phase 22/28;
> Onkyo SE-90PCI, SE-200PCI; AudioTrak Prodigy 192, 7.1 (HIFI/LT/XT),
> HD2; Hercules Fortissimo IV; ESI Juli@; Pontis MS300; EGO-SYS
> WaveTerminal 192M).

Thanks.  I'll look over these cards.

> The most high-end supported cards are probably the Asus Xonar cards.
> The D2/D2X have even slightly better audio quality than the best X-Fi,
> and, as the obviously most important feature, colorfully illuminated
> jacks.  The various Dolby features are done in software in the Windows
> driver and are not supported in Linux.  If you need a PCI-E card, the
> Xonar DX or D2X are your only choice.

What about the Asus Xonar HDAV1.3?

John Rigg wrote:
>> The most high-end supported cards are probably the Asus Xonar cards.
>
> `High end' means different things in different situations of course.
> RME HDSP series are probably the `highest end' cards supported, but
> they need external converters, so they're probably unsuitable here.

The Xonar cards do look interesting, but I'd also like to carry one
higher-end card.  I'm looking for a single-slot PCI Express solution
that works as a standalone sound card, i.e. without any mandatory
external devices (though optional ones are fine).

Thanks for the information.

Edward
