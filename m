From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: supported sound cards
Date: Thu, 06 Nov 2008 13:15:05 +0100
Message-ID: <4912DFC9.8030704@ladisch.de>
References: <490A1B4D.4000507@openboxbuilder.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id D6EEA2451D
	for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2008 13:15:08 +0100 (CET)
In-Reply-To: <490A1B4D.4000507@openboxbuilder.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Edward Terry <eterry@openboxbuilder.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Edward Terry wrote:
> I'm starting a business selling Linux-based computers, and I'm looking
> for a high-end sound card that works well under Linux.  I don't have a
> specific use in mind; this would be for a wide range of end-users, from
> audiophiles to gamers.

The only chip where hardware mixing is supported is Creative's Emu10k1
(snd-emu10k1 driver), used on the SB Live!, most Audigy and certain low-
end X-Fi cards.  (Cards with the 'real' X-Fi chip do _not_ work well in
Linux.)

Other supported chips are ICE1724 (M-Audio Delta 1010(LT), DiO 2496, 66,
44, 410, Audiophile 24/96; Digigram VX442; TerraTec EWX 24/96,
EWS 88MT/D, DMX 6Fire, Phase 88; Hoontech SoundTrack DSP 24/Value/
Media7.1; Event EZ8; Lionstracs Mediastation, Terrasoniq TS 88) and
VT1720/24 (AMP AUDIO2000; M-Audio Revolution 5.1, 7.1, Audiophile 192;
TerraTec Aureon 5.1 Sky, 7.1 Space/Universe, Phase 22/28;
Onkyo SE-90PCI, SE-200PCI; AudioTrak Prodigy 192, 7.1 (HIFI/LT/XT), HD2;
Hercules Fortissimo IV; ESI Juli@; Pontis MS300; EGO-SYS WaveTerminal
192M).

The most high-end supported cards are probably the Asus Xonar cards.
The D2/D2X have even slightly better audio quality than the best X-Fi,
and, as the obviously most important feature, colorfully illuminated
jacks.  The various Dolby features are done in software in the Windows
driver and are not supported in Linux.  If you need a PCI-E card, the
Xonar DX or D2X are your only choice.


HTH
Clemens
