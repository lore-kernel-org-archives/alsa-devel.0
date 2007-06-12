From: acallan.alsa@ugnet.org
Subject: Re: Alsa 1.0.13 (and others) does not work on ALC880
Date: Tue, 12 Jun 2007 00:51:48 -0500 (CDT)
Message-ID: <Pine.LNX.4.58.0706120045540.6306@integrity.ugnet.org>
References: <Pine.LNX.4.58.0705190144230.8331@integrity.ugnet.org>
	<s5h7ir4etl6.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0706022134120.29661@integrity.ugnet.org>
	<s5hvee3ajs9.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0706042306580.23775@integrity.ugnet.org>
	<s5hzm3e65tv.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0706060101550.19660@integrity.ugnet.org>
	<s5hfy55450v.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0706070053430.25249@integrity.ugnet.org>
	<s5h645y3mfi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from integrity.ugnet.org (integrity.ugnet.org [208.251.149.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 55A3D10382D
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 06:52:29 +0200 (CEST)
In-Reply-To: <s5h645y3mfi.wl%tiwai@suse.de>
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

Yes, I had tried it, and it did not work.  However, I hadn't grasped what
you were trying to accomplish with it.  The problem was that
hda_set_power_state() still called snd_hda_get_sub_nodes() on the modem
codec before looping over the calls to get_wcaps(), and
snd_hda_get_sub_nodes() is the function causing problems for my chip.

The following patch works for me, and I think it accomplishes what you
wanted.

Andrew

On Fri, 8 Jun 2007, Takashi Iwai wrote:

> At Thu, 7 Jun 2007 01:01:54 -0500 (CDT),
> acallan.alsa@ugnet.org wrote:
> >
> > On Wed, 6 Jun 2007, Takashi Iwai wrote:
> >
> > > At Wed, 6 Jun 2007 01:07:15 -0500 (CDT),
> > > acallan.alsa@ugnet.org wrote:
> > > >
> > > > cat /proc/asound/card0/codec#1 works just fine, and sound still works
> > > > fine even after that.  Looking at the function print_codec_info()
> > > > (hda_proc.c), there is already the check:
> > > > if (! codec->afg)
> > > >         return;
> > > > after the vendor, subsystem, and revision are retrieved but before the
> > > > pcm, amp caps, and node information are retrieved.
> > >
> > > Oh silly me.
> > >
> > > I guess the following patch works alone.  Could you test it?
> > >
> > >
> > > Takashi
> > >
> >
> > I had to also add in the workarounds for the power states as in the
> > following patch.
>
> Did you try my latest patch?
> It sets the power state of only the FG node, and doesn't touch child
> nodes any more for modem FG.  You patch will skip the power state
> completely for modem FG.
>
>
> Takashi
>

diff -r 95e93362c92d pci/hda/hda_codec.c
--- a/pci/hda/hda_codec.c	Mon Jun 11 12:23:31 2007 +0200
+++ b/pci/hda/hda_codec.c	Mon Jun 11 23:27:33 2007 -0500
@@ -562,7 +562,7 @@ int __devinit snd_hda_codec_new(struct h
 		return -ENODEV;
 	}

-	if (read_widget_caps(codec, codec->afg ? codec->afg : codec->mfg) < 0) {
+	if (codec->afg && read_widget_caps(codec, codec->afg) < 0) {
 		snd_printk(KERN_ERR "hda_codec: cannot malloc\n");
 		snd_hda_codec_free(codec);
 		return -ENOMEM;
@@ -1351,6 +1351,8 @@ static void hda_set_power_state(struct h
 	snd_hda_codec_write(codec, fg, 0, AC_VERB_SET_POWER_STATE,
 			    power_state);

+	if (! codec->afg)
+		return;
 	nodes = snd_hda_get_sub_nodes(codec, fg, &nid_start);
 	for (nid = nid_start; nid < nodes + nid_start; nid++) {
 		if (get_wcaps(codec, nid) & AC_WCAP_POWER)
