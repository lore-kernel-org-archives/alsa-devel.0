From: Jeremy Soller <jeremy@system76.com>
Subject: Re: [PATCH] Headset microphone support for System76
	darp5
Date: Wed, 30 Jan 2019 16:07:53 -0700
Message-ID: <1548889673.495532.1647367944.2066425D@webmail.messagingengine.com>
References: <1548791521.3450804.1646371736.7EA213CA@webmail.messagingengine.com>
 <s5h1s4ucaml.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by alsa0.perex.cz (Postfix) with ESMTP id BE25026743A
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 00:14:24 +0100 (CET)
In-Reply-To: <s5h1s4ucaml.wl-tiwai@suse.de>
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

That is good to know. I will resend the patch soon.

-- 
  Jeremy Soller
  System76, Inc.
  Engineering Manager
  jeremy@system76.com

On Wed, Jan 30, 2019, at 10:34 AM, Takashi Iwai wrote:
> On Tue, 29 Jan 2019 20:52:01 +0100,
> Jeremy Soller wrote:
> > 
> > Headset microphone support for System76 darp5
> 
> The changes look mostly OK, but could you give a bit more details?
> 
> > @@ -6606,6 +6616,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >         SND_PCI_QUIRK(0x103c, 0x18e6, "HP", ALC269_FIXUP_HP_GPIO_LED),
> >         SND_PCI_QUIRK(0x103c, 0x218b, "HP", ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED),
> >         SND_PCI_QUIRK(0x103c, 0x225f, "HP", ALC280_FIXUP_HP_GPIO2_MIC_HOTKEY),
> > +       SND_PCI_QUIRK(0x1558, 0x1325, "System76", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
> >         /* ALC282 */
> >         SND_PCI_QUIRK(0x103c, 0x21f9, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
> >         SND_PCI_QUIRK(0x103c, 0x2210, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
> 
> We keep the list in the ID number order, so please put at the
> appropriate place.
> 
> 
> thanks,
> 
> Takashi
