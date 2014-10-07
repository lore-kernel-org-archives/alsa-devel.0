From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Exposing the ThinkPad HW mute switch to ALSA?
Date: Tue, 7 Oct 2014 10:19:51 -0300
Message-ID: <20141007131951.GB25214@khazad-dum.debian.net>
References: <CALCETrULBrany=JLyZsfq6oiGDDUZOZyA+=7=GqLW8h+ZoHJVA@mail.gmail.com>
 <s5hoatpxsav.wl-tiwai@suse.de>
 <20141006190942.GA8238@khazad-dum.debian.net>
 <CALCETrUKJTXVQ1qDtix=zxibb9KujuE96Xq9C2=qYYJX2j3U_w@mail.gmail.com>
 <s5hsij0lacx.wl-tiwai@suse.de>
 <CACckToV0LiiZywtPT4OmvwuK6qVX41wbwuUiR-JdjG87javH_g@mail.gmail.com>
 <s5hfvf0w679.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id AA5B7260484
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 15:20:08 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by gateway2.nyi.internal (Postfix) with ESMTP id 5564420829
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 09:20:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <s5hfvf0w679.wl-tiwai@suse.de>
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
Cc: Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Andy Lutomirski <luto@amacapital.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 07 Oct 2014, Takashi Iwai wrote:
> At Tue, 7 Oct 2014 17:25:13 +1100,
> Grant Diffey wrote:
> > so I have a really dumb question.
> > 
> > Why can't the controls be mapped as HCI rather than a soundcard? given
> > there's no audio production capability here only a control capability.
> > 
> > Also this seems to be how they end up functioning on a modern system they
> > get bound to pulse which remaps them to whatever's 'active'
> > 
> > Why does everyone say that this is a soundcard when it's really a keyboard
> > (from my pov)
> 
> thinkpad_acpi actually mutes the sound on some models, at least the
> old ones, independently from the sound chip mute state.  That's why it
> was implemented as the sound card object initially.

That's how the hardware works, really.  One AC97 audio channel is routed to
a digital volume chip, and from there to the console headphone jack, and to
the built-in speakers.  line-out is not routed through this chip, and AFAIK
MIC/line-in is not routed through either this chip _or_ a separate mute
gate, either.

The EC controls this digital volume chip directly, it is independent from
the AC97 mixer.  The default behaviour cannot be changed in earlier
thinkpads, and trying to change it in later thinkpads (they're supposed to
have a legacy mode that is the same as the older models) doesn't work very
well.

Line-out and MIC are controlled only by the AC97 mixer in the older models
with digital volume control.

In newer-but-not-newest thinkpads, there are two mute gates, one for MIC,
and another for the speakers/headphones.  The EC controls those.  All volume
control is in the HDA mixer.

In the newest thinkpads, I think there's only a MIC mute gate controlled by
the EC, and everything else is in the HDA mixer.

And depeding on the EC operating mode and thinkpad model, the volume hotkeys
might interact with the mute state (unmuting on first press when it is
mute).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
