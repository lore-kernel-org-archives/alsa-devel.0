From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: Re: [PATCH v2] Introduce config for intel dg45id board
Date: Tue, 08 Dec 2009 21:12:27 +0100
Message-ID: <1260303147.3483.89.camel@mini>
References: <1260094453-3496-1-git-send-email-bug-track@fisher-privat.net>
	<1260095353-3262-1-git-send-email-bug-track@fisher-privat.net>
	<s5hskblsp56.wl%tiwai@suse.de> <1260277363.10891.69.camel@zwerg>
	<s5haaxtsj2i.wl%tiwai@suse.de> <1260289818.5210.59.camel@mini>
	<s5hbpi9qv1z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 974AD103846
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 21:17:13 +0100 (CET)
In-Reply-To: <s5hbpi9qv1z.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Dienstag, den 08.12.2009, 17:39 +0100 schrieb Takashi Iwai: 
> At Tue, 08 Dec 2009 17:30:18 +0100,
> Alexey Fisher wrote:
> > 
> > Am Dienstag, den 08.12.2009, 14:15 +0100 schrieb Takashi Iwai:
> > > At Tue, 08 Dec 2009 14:02:43 +0100,
> > > Alexey Fisher wrote:
> > > > 
> > > > Am Dienstag, den 08.12.2009, 12:04 +0100 schrieb Takashi Iwai:
> > > > > At Sun,  6 Dec 2009 11:29:13 +0100,
> > > > > Alexey Fisher wrote:
> > > > > > 
> > > > > > This patch introduce pin config and some workarounds for dg45id board.
> > > > > > Currently tested Mic + Surround 7.1 on rear panel, and Mic + HP on front panel.
> > > > > > SPDIF front and SPDIF rear are untested.
> > > > > > Both Mics provide VREF_80 (4,05 V) in mic mode and no VREF in line-in mode.
> > > > > > 
> > > > > > Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
> > > > > 
> > > > > Thanks for the patch.
> > > > > 
> > > > > But, I still don't see the reason for so many init verbs, especially
> > > > > doing static routings.  Can't be they connected properly by the
> > > > > parser?  If so, it's the parser to be fixed, not a quirky init table.
> > > > 
> > > > Ok. I prefer to have the part with mixer. The driver currently can't
> > > > handle this.
> > > 
> > > What do you mean exactly with "mixer"?
> > > 
> > > > It seems to make some problem with front HP. By default All
> > > > mixer inputs use 0x0a (Front HP out), in this situation i get hi freq
> > > > noise on 0x0a. So or driver should learn to work with mixer or...?
> > > 
> > > Not sure what you are talking about here...
> > 
> > I talking about widget like this:
> > 
> > Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> >   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
> >   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
> > 0x80]
> >   Connection: 5
> >      0x18 0x19 0x1a 0x1b 0x1d
> > 
> > this is an example from my laptop. Normally this widget connected to the
> > audio selector like this:
> > 
> > Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
> >   Connection: 7
> >      0x18 0x19 0x1a 0x1b 0x1d 0x12* 0x0b
> > 
> > ALSA will list only attached to "Audio Selector" "Mic" or "Line in"
> > pins, not "Audio mixer". ALSA do not give control for audio mixer too.
> 
> Just because STAC/IDT codecs have no mixer widget.  It's a hardware
> issue.

i talking about "IDT 92HD73E1X5" wich _has_ mixer widget. I use it on
windows and i can use it on linux (directly, by controlling it with
hda-verb). So this is not hardware issue. Here is the part of codecdump
from IDT 92HD73E1X5:

Node 0x1d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97
0x97]
  Connection: 5
     0x28 0x29 0x2a 0x2b 0x12



> > > > > And, your machine has really no headphone detection?  I mean, not
> > > > > about your taste but it's not physically doable?
> > > > 
> > > > HP detection working on rear green (0x0d), not on front green (0x0a).
> > > > May be there is something wrong with connector. Anyway, it working fine
> > > > under M$. May be we should provide UI control for this (to make user
> > > > completely confused:)? 
> > > 
> > > If Windows driver can detect the front HP jack, it means the
> > > connection is alive.  You can try hda-verb to check whether the
> > > pin-detection works, independently from the driver setup.
> > 
> > Pin detection working only on rear panel, on front panel it do not
> > working and on windows and on linux. Probably broken front panel jack...
> > I assume windwos use different logic.
> 
> OK, then it's likely a typical problem of the cabling and the case model.
> In many cases, an AC97-style case is connected to a HD-audio board.
> 
> > linux logic: if no hp, play sound to speaker and mute hp. if hp detected
> > - unmute hp and mute speaker.
> > winodws logic: if no hp detected play to hp and to speaker, if hp
> > detected - mute speaker and continue play to hp.
> > 
> > I think, if ALSA will behave in same way it will need less hp quirks.
> 
> Yes, that's how no_jd model works.
> 
> But, keeping the headphone output even with unplugged state means you
> are wasting unneeded power.  The driver powers down the circuit
> appropriately if a pin isn't being used.  That's why the headphone
> detection is implemented as default.
> 
> And, whether the HP detection works or not doesn't depend on the
> mobo.  It's rather the connection.  So, giving the fixed "no-jd"
> option for a certain PCI SSID is basically wrong.  Someone else might
> have a same mobo but with a right case with the front-panel jack
> detection.
> 
> That is, it's fine to create a new quirk model, but assigning
> statically to that workaround isn't always acceptable.

Ok, i get the point. But no-jd should be provided as "Jack Detect Switch". 
I know... i tolking about work :)... probably i'll try to do this. But i think it make sense. 

> thanks,
> 
> Takashi
