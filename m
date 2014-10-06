From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Exposing the ThinkPad HW mute switch to ALSA?
Date: Mon, 6 Oct 2014 16:09:42 -0300
Message-ID: <20141006190942.GA8238@khazad-dum.debian.net>
References: <CALCETrULBrany=JLyZsfq6oiGDDUZOZyA+=7=GqLW8h+ZoHJVA@mail.gmail.com>
 <s5hoatpxsav.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D42662604D6
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 21:09:55 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by gateway2.nyi.internal (Postfix) with ESMTP id D26DC2071F
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 15:09:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <s5hoatpxsav.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Andy Lutomirski <luto@amacapital.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 06 Oct 2014, Takashi Iwai wrote:
> > ThinkPads have an extra mute switch that's controlled by the embedded
> > controller.  There are some hardware buttons associated with it.
> > 
> > We (thinkpad-acpi) can be notified about state changes in the mute
> > switch, we can see presses of the hardware buttons and program them to
> > send KEY_MUTE or not as appropriate, and we can (optionally) change
> > the HW mute state.
> > 
> > However, I have no clue how to correctly expose the mute switch
> > through ALSA so that userspace will know what it controls.  It
> > currently shows up as its own sound card, which is ridiculous.
> > 
> > Can anyone give me any hints as to how to expose this bonus audio
> > control in a sensible manner?  I know essentially nothing about ALSA.
> > 
> > (Some older ThinkPads also have a hardware volume control with similar
> > behavior.)
> 
> It's a bit difficult issue, since this needs the weak module
> dependency.  And even worse, different sound drivers might be used for
> a single thinkpad_acpi.  So, from the programming POV, the individual
> sound card instance is the easiest approach.
> 
> Though, some HD-audio codec drivers already have a weak binding of
> thinkpad_acpi stuff for Mic-mute switch.  I guess we can move the
> handling of the master mute switch to the sound driver as well.
> 
> If doing so, each relevant sound driver needs to implement it.
> IIRC, snd-intel8x0 is used on old Thinkpads.  Any others?

As far as I know, all old ones use the snd-intel8x0 AC97 hba, but several
different codecs behind that.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
