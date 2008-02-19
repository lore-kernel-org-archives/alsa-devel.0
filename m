From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Notebook Toshiba satellite x200-21g with
	realtek	snd-hda-intel audio device still not supported (codec
	ALC268)
Date: Tue, 19 Feb 2008 10:16:20 -0800
Message-ID: <1203444980.1677.20.camel@razman.gruemaster.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>
	<476A2BCC.4060109@gmail.com>	<s5h1w9h4g5d.wl%tiwai@suse.de>
	<47727C6C.6080401@gmail.com>
	<1198815321.3732.229.camel@razman.gruemaster.com>
	<47B06DEF.4070609@gmail.com>	<s5htzkfv5jp.wl%tiwai@suse.de>
	<47B0D319.2000702@gmail.com>	<s5hd4r2v5g1.wl%tiwai@suse.de>
	<47B23AB8.6000301@gmail.com>	<47B5D230.4050402@gmail.com>
	<47B9C909.9010100@gmail.com>	<s5h3arpujri.wl%tiwai@suse.de>
	<47BAE549.2080009@gmail.com>	<s5hzltxt3oy.wl%tiwai@suse.de>
	<47BAEFB6.8040209@gmail.com>	<s5hprutt22f.wl%tiwai@suse.de>
	<47BAFBD6.8050903@gmail.com> <s5hir0kudkz.wl%tiwai@suse.de>
	<47BB1204.5010801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 026F92460D
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 19:16:23 +0100 (CET)
In-Reply-To: <47BB1204.5010801@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The only way to support Midi on that system is via software midi.  There
is no hardware midi support directly to the system (no place to plug in
midi devices), except through USB or possibly integrated in a docking
system.  To get Midi support for Linux, use Timidity
(http://timidity.sourceforge.net).   This will convert midi sequences to
pcm audio tracks.

I personally can't translate the specs listed, but from what I can tell,
the system should have a Line-in, Mic-In, and HP-out jacks, along with 4
internal speakers (nothing indicating surround sound).  It does have
SPDIF out, and I would assume that will allow surround sound if hooked
up to a digital receiver, as SPDIF is essentially a digital
pass-through.  The codec itself only has two DACs, which could be
configured between the headphones and speakers to do a quasi-surround4.0
setup, but based on the chip diagram would take some additional
programming effort.

And I'm sorry I dropped the ball in helping here.  I wish I could spend
more time on Alsa, but economics forces me to have a full time job doing
non-alsa work at this time.  Bad excuse, I know.

I'll try to get my test board working again this week, and I'll even
download the Windows drivers for your system to use as a baseline for
comparison.  No guarantees, though.

Tobin



        



On Tue, 2008-02-19 at 18:29 +0100, Daniele (Mastro) wrote:

> Takashi Iwai ha scritto:
> >> - Digital = 68
> > 
> > Keep this 50%.  It's a digital attenuation/gain control and changing
> > this makes no sense unless you have a digital mic without the hardware
> > volume control.
> 
> if i put 50% there the mic it's a bit "low" with volume and i have to 
> spoke really near to it
> (however sound is cleaner, lower but cleaner)
> 
> >> - Input Source = Front mic
> >> - Input Source 1 = Front mic (playback - see below)
> > 
> > Is "Front mic" the external mic jack?  And the internal mic works as
> > well?
> 
> "front mic" works as the jack in the front of my laptop
> no internal mic doesn't work at all.. and i don't know if there's one to 
> be honest cause i never booted windows here
> 
> > The second capture could work independently, assigned to PCM#2.
> 
> sorry i think i didn't understand what do you mean..
> so the behavior is "normal"? or it isn't? or it is "fixable" in some way?
> with my previous laptop i used to have only 1 capture device and to 
> select if i want to use it only as playback, only as capture or both..
> 
> here i've to do this separately with 2 device.. it's not a big deal.. 
> it's only strange
> 
> > No, you are fooled by marketing people.  It has no MIDI hardware.
> > It's a pure software thingy.
> > 
> 
> actually it say under "audio specification" for my notebook
> 
> Standard sonori supportati : MIDI support
> 
> which means:
> Supported sound standard: MIDI support
> 
> you can read it here:
> http://it.computers.toshiba-europe.com/cgi-bin/ToshibaCSG/jsp/SUPPORTSECTION/discontinuedProductPage.do?service=IT&toshibaShop=false&com.broadvision.session.new=Yes&PRODUCT_ID=137947
> (i don't know if this page will still visible in future)
> 
> >> - no "mux","mix", or "aux" record source to directly record from desktop
> > 
> > The codec has no function to record from the mixer amp (some other
> > Realtek codecs have, though).  It's again a software issue.
> 
> ok.. so i've no way to "record what I'm listening" right? (no way other 
> that using a microphone off course)
> 
> > No, you don't.  aplay just shows the available "configuration" but it
> > the device doesn't support surrounds.
> 
> oh ok :)
> do you know how can i test subwoofer?
> it seems active but if there's a way to actually "test" it would be nice
> 
> sorry for me bothering you :)
> i hope one day I'll be able to pay back your kindness
> --
> Daniele
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis 


A gourmet who thinks of calories is like a tart that looks at her watch.
		-- James Beard
