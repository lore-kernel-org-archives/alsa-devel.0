From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] hda: enable speaker output for
	Compaq	6530s/6531s
Date: Wed, 19 Aug 2009 16:58:59 +0800
Message-ID: <20090819085859.GA13895@localhost>
References: <20090816085317.GA23959@localhost> <s5hvdkoi04w.wl%tiwai@suse.de>
	<20090816110110.GA32187@localhost>
	<s5h4os7vsy1.wl%tiwai@suse.de> <s5hd46thbqw.wl%tiwai@suse.de>
	<20090819075659.GA15149@localhost>
	<20090819080151.GA4504@localhost> <s5hocqcchlq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id EBC7924496
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 10:59:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hocqcchlq.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lin,
	Ming M" <ming.m.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 19, 2009 at 04:50:41PM +0800, Takashi Iwai wrote:
> At Wed, 19 Aug 2009 16:01:51 +0800,
> Wu Fengguang wrote:
> > 
> > On Wed, Aug 19, 2009 at 03:56:59PM +0800, Wu Fengguang wrote:
> > > On Tue, Aug 18, 2009 at 02:33:43PM +0800, Takashi Iwai wrote:
> > > > At Mon, 17 Aug 2009 08:46:14 +0200,
> > > > I wrote:
> > > > > 
> > > > > At Sun, 16 Aug 2009 19:01:10 +0800,
> > > > > Wu Fengguang wrote:
> > > > > > 
> > > > > > On Sun, Aug 16, 2009 at 05:22:23PM +0800, Takashi Iwai wrote:
> > > > > > > At Sun, 16 Aug 2009 16:53:17 +0800,
> > > > > > > Wu Fengguang wrote:
> > > > > > > > 
> > > > > > > > There are 3 causes to the silence of Compaq 6530s' internal speaker:
> > > > > > > > - HP pin 0x11 always return 0xffff,ffff (pin_presence=1),
> > > > > > > >   which automutes the speaker at module loading time.
> > > > > > > 
> > > > > > > This is odd.  Is the sense-trigger issued before reading the pin sense?
> > > > > > 
> > > > > > Sorry, what do you mean?  The facts I explored are:
> > > > > > - ad1884a_hp_automute() will be explicitly called by ad1884a_hp_init()
> > > > > > - ad1884a_hp_unsol_event() is never called on plug events
> > > > > > - I tried manually execute AC_VERB_SET_PIN_SENSE then read pin sense,
> > > > > >   it takes effect on the impedance, but pin_presence still remains 1.
> > > > > 
> > > > > The fact that it returns only -1 sounds rather like a hardware issue.
> > > > > Or, at least, reading a wrong place or so.
> > > > 
> > > > BTW, could you give alsa-info.sh output on both machines?
> > > 
> > > I'm now testing 6531s. All verbs/states seem OK.
> > 
> > In fact for 6531s, the speaker can produce sound on fresh boot.
> > However after a while the sound disappeared. No single write verb
> > was executed during the time! And then I found the 0x1c trick can
> > be applied to 6530s as well as 6531s, and magically make the speaker
> > work by applying this patch.
> 
> OK, I'm going to apply your fix.
> 
> > @@ -4003,6 +4005,8 @@ static struct snd_pci_quirk ad1884a_cfg_
> >  	SND_PCI_QUIRK(0x103c, 0x3030, "HP", AD1884A_MOBILE),
> >  	SND_PCI_QUIRK(0x103c, 0x3037, "HP 2230s", AD1884A_LAPTOP),
> >  	SND_PCI_QUIRK(0x103c, 0x3056, "HP", AD1884A_MOBILE),
> > +	SND_PCI_QUIRK(0x103c, 0x30e8, "HP Compaq 6530s", AD1884A_LAPTOP),
> > +	SND_PCI_QUIRK(0x103c, 0x30e9, "HP Compaq 6531s", AD1884A_LAPTOP),
> >  	SND_PCI_QUIRK_MASK(0x103c, 0xfff0, 0x3070, "HP", AD1884A_MOBILE),
> >  	SND_PCI_QUIRK_MASK(0x103c, 0xfff0, 0x30d0, "HP laptop", AD1884A_LAPTOP),
> >  	SND_PCI_QUIRK_MASK(0x103c, 0xfff0, 0x30e0, "HP laptop", AD1884A_LAPTOP),
> 
> These entries are unnecessary because they match with model=laptop
> with the masked entry 013c:30e* (the last one in the chunk above).

Yes I was aware of this. Just that printing the exact names may make
some users feel better :)

> Could you remove it and repost?

Sure.

---
hda: enable speaker output for Compaq 6530s/6531s

HP Compaq 6530s and 6531s internal speaker is silence or becomes silence
within 1 minute after fresh boot. It is found that pin 0x1c must be set to
PIN_OUT mode to make the speaker work. This is weird - line-in pin 0x1c and
speaker pin 0x16 seem to be unrelated.

The codec differences before/after patch are:

@@ Node 0x17 [Pin Complex] wcaps 0x40020b: 
   Pin Default 0x41a6e130: [N/A] Mic at Ext Rear
     Conn = Digital, Color = White
     DefAssociation = 0x3, Sequence = 0x0
     Misc = NO_PRESENCE
-  Pin-ctls: 0x24: IN
+  Pin-ctls: 0x40: OUT
@@ Node 0x1c [Pin Complex] wcaps 0x40018d: 
   Pin Default 0x41813021: [N/A] Line In at Ext Rear
     Conn = 1/8, Color = Blue
     DefAssociation = 0x2, Sequence = 0x1
-  Pin-ctls: 0x24: IN VREF_80
+  Pin-ctls: 0x40: OUT VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x24

Tests show that it won't impact (external) Mic recording.

Reported-by: "Lin, Ming M" <ming.m.lin@intel.com>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_analog.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_analog.c	2009-08-19 16:56:11.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_analog.c	2009-08-19 16:56:12.000000000 +0800
@@ -3836,9 +3836,11 @@ static struct hda_verb ad1884a_laptop_ve
 	/* Port-F (int speaker) mixer - route only from analog mixer */
 	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
 	{0x0b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
-	/* Port-F pin */
-	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	/* Port-F (int speaker) pin */
+	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	/* required for compaq 6530s/6531s speaker output */
+	{0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	/* Port-C pin - internal mic-in */
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, 0x7002}, /* raise mic as default */
