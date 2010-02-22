From: Reimundo Heluani <rheluani@gmail.com>
Subject: Re: Macbook Air 2,1 - no mic nor main speakers
Date: Mon, 22 Feb 2010 00:02:13 -0800
Message-ID: <1266825733.3074.19.camel@vino>
References: <1265480879.2466.21.camel@vino> <1266820258.3074.16.camel@vino>
	<s5h7hq54sd8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B493B103825
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 09:02:17 +0100 (CET)
Received: by vws13 with SMTP id 13so339196vws.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 00:02:16 -0800 (PST)
In-Reply-To: <s5h7hq54sd8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-02-22 at 08:55 +0100, Takashi Iwai wrote:
> At Sun, 21 Feb 2010 22:30:58 -0800,
> Reimundo Heluani wrote:
> > 
> > On Sat, 2010-02-06 at 10:27 -0800, Reimundo Heluani wrote:
> > > Hello list, this came up a year ago and Takashi's answer was "a broken
> > > bios". I was hoping someone here could point me to documentation to read
> > > in order to diagnose the problem if indeed is a broken bios. I don't
> > > want to start randombly reading the driver's code.
> > > 
> > > Macbook Air 2,1
> > > 2.6.32-gentoo-r3 SMP x86_64
> > > Alsa Driver 1.0.21 libs 1.0.22
> > > nVidia Corporation MCP79 High Definition Audio (rev b1)
> > > HDA NVidia at 0x93380000 irq 19
> > > 00:08.0 0403: 10de:0ac0 (rev b1)  Subsystem: 10de:cb79
> > > Codec: Realtek ALC889A
> > > 
> > > Booting with snd_hda_intel.model=mbp3 get sound on headphones, but not on mainspeakers. The mic never worked.
> > > 
> > 
> > Hello again, I found out that puting the pin in 0x18 as a PIN_OUT I get
> > sound in the internal speaker. Currently I can change patch_realtek.c to
> > load the driver using an "mba21" model and I get sound on the main
> > speaker. One of the (many) problems I have is that I need to use
> > something like
> > 
> > {0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, (PIN_OUT | AC_PINCTL_VREF_50) } 
> > 
> > otherwise it goes into HiZ and I get no audio. Looking at that
> > patch_realtek.c I don't see anything similar. Anyway, I don't have a
> > clue about ALSA, I just started reading the HDA specification and looked
> > over patch_realtek.c and came up with the small change below to have a
> > working main speaker. I'd appreciate if you had any suggestion for the
> > mic or to point me towards the right documentation.
> 
> The change looks almost good -- except for one place.
> 
> >   
> > + /* Macbook Air don't know how this works */
> > + static void alc885_mba21_setup (struct hda_codec *codec)
> > + {
> > + 	struct alc_spec *spec = codec->spec;
> > + 
> > + 	spec->autocfg.speaker_pins[0] = 0x18;
> 
> Does this device have no dedicated headphone output pin?
> Usually it's either 0x14 or 0x15.

The headphones are in 0x14 but I couldn't get them to shut the main
speakers off yet when the hp jack is connected. As soon as I understand
how the other examples in patch_realtek.c work and get this working I'll
send you a working patch.

R.
> 
> Also, please make a patch in a unified diff format.
> 
> If the patch is ready for merge, please post it (and add me to Cc)
> with a proper changelog and your sign-off.
> 
> 
> thanks,
> 
> Takashi
