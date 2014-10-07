From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Exposing the ThinkPad HW mute switch to ALSA?
Date: Tue, 7 Oct 2014 10:12:09 -0300
Message-ID: <20141007131209.GA25214@khazad-dum.debian.net>
References: <CALCETrULBrany=JLyZsfq6oiGDDUZOZyA+=7=GqLW8h+ZoHJVA@mail.gmail.com>
 <s5hoatpxsav.wl-tiwai@suse.de>
 <20141006190942.GA8238@khazad-dum.debian.net>
 <CALCETrUKJTXVQ1qDtix=zxibb9KujuE96Xq9C2=qYYJX2j3U_w@mail.gmail.com>
 <s5hsij0lacx.wl-tiwai@suse.de>
 <CACckToV0LiiZywtPT4OmvwuK6qVX41wbwuUiR-JdjG87javH_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2150C260484
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 15:12:23 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by gateway2.nyi.internal (Postfix) with ESMTP id 9298620782
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 09:12:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CACckToV0LiiZywtPT4OmvwuK6qVX41wbwuUiR-JdjG87javH_g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Andy Lutomirski <luto@amacapital.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 07 Oct 2014, Grant Diffey wrote:
> so I have a really dumb question.
> 
> Why can't the controls be mapped as HCI rather than a soundcard? given
> there's no audio production capability here only a control capability.
> 
> Also this seems to be how they end up functioning on a modern system they
> get bound to pulse which remaps them to whatever's 'active'

FYI, on the old thinkpads it is the console audio volume control.  It *only*
affects the built-in speakers and the built-in headphone output.  It does
_not_ affect line-out.  It does _not_ affect add-in soundcards.  And it
operates entirely inside the EC, with zero need of any OS assistance.

Those thinkpads don't have a separate MIC-mute button, though.  I never
tested them for mic-mute functionality come to think of it... the AC97 mixer
in the soundcard can mute the mic, and I don't think there's an external MIC
mute, because the chip they used for digital console volume control doesn't
have mic channels.

> Should this control control volume of my BT headset when it's active (It
> currently does which I find convenient but I can see an argument that it's
> surprising and should be bound to the phys hardware on the laptop)

Both alternatives are acceptable, as long as it doesn't lie.  And on old
thinkpads, you must take special action and not feed it back into the
internal AC97 mixer, because it will _always_ control the console digital
volume, it cannot be overriden in the older models, and the override doesn't
work well because whomever wrote the EC code for the other operating modes
did not test it properly.

BTW: old thinkpads don't use an ACPI interface to interact with the EC
mixer, it is done by direct EC register access, and we whitelist the models
where it works (the list is complete AFAIK).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
