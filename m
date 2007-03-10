From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [Alsa-devel] Adding a alsa mixer
	interface	to	ibm-acpi
Date: Sat, 10 Mar 2007 00:50:55 -0300
Message-ID: <20070310035055.GB7606@khazad-dum.debian.net>
References: <s5hr6scswnp.wl%tiwai@suse.de>
	<20070226174145.GF2909@khazad-dum.debian.net>
	<20070227015024.GF8154@thunk.org>
	<20070227021402.GC6828@khazad-dum.debian.net>
	<s5hd53kaf5r.wl%tiwai@suse.de>
	<41840b750703071512o1d171dfy9d2a615382e5e635@mail.gmail.com>
	<20070307234240.GA12070@khazad-dum.debian.net>
	<1173311709.4531.30.camel@razman.gruemaster.com>
	<20070308003806.GC12070@khazad-dum.debian.net>
	<s5htzwugz22.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5htzwugz22.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Tobin Davis <tdavis-TKBhMlbpEWrk1uMJSBkQmQ@public.gmane.org>, alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Theodore Tso <tytso-3s7WtUTddSA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 09 Mar 2007, Takashi Iwai wrote:
> > On Wed, 07 Mar 2007, Tobin Davis wrote:
> > > Another question comes to mind.  Why would the volume need to be
> > > controlled if there is no sound driver to generate sound?  I'm trying
> > > to understand the usage model here for that aspect.
> > 
> > Because the firmware will happly beep away, and you may want to control the
> > volume of those beeps.  And it also controls the volume of the PC buzzer
> > (the BIOS makes sure whatever sound hardware is in the machine lets that one
> > through by default).
> 
> OTOH, from the usability POV, it's really annoying to have two
> individual "devices" for the very same output.  That's why I'm in
> favor of either built-in-sound-driver or add-on style.

Well, I have five choices:

1. No Linux support to change the thinkpad mixer at all unless the soundcard
drivers are loaded;

2. ThinkPad mixer support always available as a separate, mixer-only card;

3. ThinkPad mixer support available as a separate mixer-only card AND in the
real soundcard driver;

4. ThinkPad mixer support available as a separate mixer-only card while the
real soundcard driver is not loaded, and *only* in the real soundcard driver
after it is loaded;

5. ThinkPad mixer support available in the real soundcard driver, and as a
bunch of non-generic attributes on sysfs.

> And, if you'll ALSA API for controlling volumes, it assumes that any
> sound system is running.   So, it appears logical to me that the

It seems to work just fine with the soundsystem running with a card that
only has a single monoaural volume control, and nothing else.

> beep-control driver also belongs to a sound driver.

Does ALSA have an interface that is sane for a hardware/firmware synthesizer
with a fixed set of tones?  The MIDI sequencer doesn't count, it is unusable
for scripts.  Otherwise, I will keep the non-generic ibm-acpi interface (a
sysfs attribute where you write the ID of the pattern you want it to beep).

> Anyway, if you'd like a stand-alone implementation, we can introduce a
> Kconfig, too.  But, note that one merit to use the add-on style
> (referring to the exported symbol of snd-intel8x0 driver) is that this
> dependency will resolve the module loading order, too.

We still need to handle hotplug anyway, as modules can be removed and
readded.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
