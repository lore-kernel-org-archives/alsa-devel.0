From: "Paul \"TBBle\" Hampson" <Paul.Hampson@Pobox.com>
Subject: HDA model specification and a topic/hda bug?
Date: Wed, 23 Dec 2009 16:21:34 +1100
Message-ID: <297c1a110912222121u51afae9cu8ec77a40b375591d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f185.google.com (mail-px0-f185.google.com
	[209.85.216.185])
	by alsa0.perex.cz (Postfix) with ESMTP id A1460103841
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 06:21:35 +0100 (CET)
Received: by pxi15 with SMTP id 15so4641678pxi.23
	for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2009 21:21:34 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I've a couple of questions. Firstly, I've been through "MORE NOTES ON
HD-AUDIO DRIVER"
and was able to use codecgraph and hda-analyzer to identify
non-disabled speakers on my
laptop (the laptop claims four speakers plus a subwoofer, Alsa's
autodetect only enables the
subwoofer for output) but I'm having trouble working out how to
convert this knowledge into either
changes to patch_realtek.c or even a patch file to feed the driver, so
that it comes up correctly
by default.

I do have a printout of the Intel HDA spec's codec layout chapter, but
I haven't read it yet. I'm
hoping not to have to, but I suspect I will.

Anyway, I've been tracking topic/hda from the Alsa git repository,
hoping it'll magically fix my
sound-card detection, but I'm having a problem with
5b0cb1d850c26893b1468b3a519433a1b7a176be
(ALSA: hda - add more NID->Control mapping) which I believe is part of
the 1.0.22 release.

For reference, it's an MSI GT725 laptop...

Basically, snd_hda_add_nids is being called with an array of three
nids, the third of which is 0.

I've been throwing snd_kprintd statements at it, and it seems that I
see input_mux->num_items
as 3 (which I _think_ is correct, I have a buit-in microphone,
microphone jack and line-in jack) but
I only have two analog aud_in nodes (0x8 and 0x9, 0x7 is a vendor node).

>From the look of it, this call to snd_hda_add_nids is wrong:
err = snd_hda_add_nids(codec, kctl, i, spec->capsrc_nids,
spec->input_mux->num_items);
it maybe should be
err = snd_hda_add_nids(codec, kctl, i, spec->capsrc_nids, spec->num_adc_nids);
if I'm understanding patch_alc882 correctly, although that looks wrong
in pretty much every
other use I can see.

It's prolly me not understanding how the HDA stuff ties together very
well, but right now the
inbuilt sound fails to load with a -22 (-EINVAL) error, which is
snd_hda_add_nid rejecting a
nid <= 0.

I suspect http://bugs.gentoo.org/show_bug.cgi?id=297454 is the same problem, and
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4846 looks like it too.

On searching, https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4841
is exactly the
same problem, and the same model laptop as mine.

I'm happy to do debugging and whatnot, since I hope to actually work
out the correct patch
overrides to get my laptop speakers properly working so any debugging
I do for this problem
will hopefully improve my understanding of the HDA driver.
