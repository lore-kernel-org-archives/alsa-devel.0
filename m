From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: 2.6.0-t1 garbage in /proc/ioports and oops
Date: Sun, 27 Jul 2003 22:43:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030727224357.GA27040@neo.rr.com>
References: <20030718011101.GD15716@ruvolo.net> <20030717211533.77c0f943.akpm@osdl.org> <20030718150429.GE15716@ruvolo.net> <20030727163812.75b98b02.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20030727163812.75b98b02.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Ruvolo <chris@ruvolo.net>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 27, 2003 at 04:38:12PM -0700, Andrew Morton wrote:
> Chris Ruvolo <chris@ruvolo.net> wrote:
> >
> > (adding alsa-devel)
> > 
> > On Thu, Jul 17, 2003 at 09:15:33PM -0700, Andrew Morton wrote:
> > > You could load all those modules one at a time, doing a `cat /proc/ioports'
> > > after each one.  One sneaky way of doing that would be to make your
> > > modprobe executable be:
> > 
> > Ok, this let me track it down to the ALSA snd-sbawe module.  I did not have
> > isapnp compiled into the kernel and was relying on the userspace isapnp to
> > configure the device (carried over from 2.4).  Apparently the module didn't
> > like this.
> 
> OK, thanks for that.
> 
> >From my reading, snd_sb16_probe() is, in the case of !CONFIG_PNP, doing:
> 
> 	/* block the 0x388 port to avoid PnP conflicts */
> 	acard->fm_res = request_region(0x388, 4, "SoundBlaster FM");
> 
> but this reservation is never undone.  So later, after the module is
> unloaded, a read of /proc/ioports is oopsing when trying to access that
> string "SoundBlaster FM".  Because it now resides in vfree'd memory.
> 
> The fix would be to run release_region() either at the end of
> snd_sb16_probe() or on module unload.
> 
> Adam or Jaroslav, could you please take care of this?
> 
> Thanks.

I believe this will fix it.  Testing would be appreciated.

Thanks,
Adam

--- a/sound/isa/sb/sb16.c	2003-07-14 03:37:15.000000000 +0000
+++ b/sound/isa/sb/sb16.c	2003-07-27 22:33:22.000000000 +0000
@@ -350,6 +350,18 @@
 
 #endif /* CONFIG_PNP */
 
+static void snd_sb16_free(snd_card_t *card)
+{
+	struct snd_card_sb16 *acard = (struct snd_card_sb16 *) card->private_data;
+
+	if (acard == NULL)
+		return;
+	if (acard->fm_res) {
+		release_resource(acard->fm_res);
+		kfree_nocheck(acard->fm_res);
+	}
+}
+
 static int __init snd_sb16_probe(int dev,
 				 struct pnp_card_link *pcard,
 				 const struct pnp_card_device_id *pid)
@@ -374,6 +386,7 @@
 	if (card == NULL)
 		return -ENOMEM;
 	acard = (struct snd_card_sb16 *) card->private_data;
+	card->private_free = snd_sb16_free;
 #ifdef CONFIG_PNP
 	if (isapnp[dev]) {
 		if ((err = snd_card_sb16_pnp(dev, acard, pcard, pid))) {
