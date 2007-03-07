From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [ibm-acpi-devel] Adding a alsa mixer interface
	to	ibm-acpi
Date: Wed, 07 Mar 2007 15:55:09 -0800
Message-ID: <1173311709.4531.30.camel@razman.gruemaster.com>
References: <20070225012017.GA19039@khazad-dum.debian.net>
	<s5h649pue8z.wl%tiwai@suse.de>
	<20070226162819.GE2909@khazad-dum.debian.net>
	<s5hr6scswnp.wl%tiwai@suse.de>
	<20070226174145.GF2909@khazad-dum.debian.net>
	<20070227015024.GF8154@thunk.org>
	<20070227021402.GC6828@khazad-dum.debian.net>
	<s5hd53kaf5r.wl%tiwai@suse.de>
	<41840b750703071512o1d171dfy9d2a615382e5e635@mail.gmail.com>
	<20070307234240.GA12070@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070307234240.GA12070@khazad-dum.debian.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Takashi Iwai <tiwai@suse.de>, ibm-acpi-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, Theodore Tso <tytso@mit.edu>, Shem Multinymous <multinymous@gmail.com>
List-Id: alsa-devel@alsa-project.org



On Wed, 2007-03-07 at 20:42 -0300, Henrique de Moraes Holschuh wrote:
> On Wed, 07 Mar 2007, Shem Multinymous wrote:
> > On 3/7/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > > If they got a mixer applet worth something, it will list two cards, or allow
> > > > them to have two instances, one for each card.
> > >
> > > I guess it's rather confusing.  Both controls the very same device for
> > > the very same role in the end, so it'd be better to be merged in some
> > > level, IMO.
> > 
> > The ibm-acpi mixer also affects the BIOS-generated sounds (e.g.,
> > low-battery warnings) and PC speaker. So it useful even when the sound
> > card is unused or unsupported.
> 
> True.  Here's the (probable) audio routing on a ThinkPad:
> 
> [embedded sound card/codec] -> [thinkpad hardware mixer] -> output
> [thinkpad firmware beep generator]   ----^
> 
> The thinkpad firmware can generate a bunch of beeps that appear to not be
> really related to the std. PC buzzer :-)  and these beeps are used to signal
> firmware events.  I don't think they are routed through the AC97 or HDA
> codec.
> 
> Note that it is possible that the normal PC buzzer IS routed through the
> codec.
> 
> One of the things I don't know is exactly what is generating the firmware
> beeps on modern thinkpads: BIOS, or EC.  The volume control is done by the
> EC on a modern thinkpad, though.
> 
> So I'd have to provide a stand-alone "placeholder" card to hook the mixer to
> if no real sound-card driver is loaded?  urk.  It is doable, of course,
> but... ick.  The question is now, what should I do when doing a mixer
> piggy-back?  De-register the mixer-only audio card, or keep it around (and
> this give the user two cards)?
Another question comes to mind.  Why would the volume need to be
controlled if there is no sound driver to generate sound?  I'm trying
to understand the usage model here for that aspect.

As to the firmware controlling the sound mixer when drivers are loaded,
what about creating an unsolicited event situation that is specifically
masked to each control?  That would be an easy addition to the hda codec
drivers (not sure about AC'97).


-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
