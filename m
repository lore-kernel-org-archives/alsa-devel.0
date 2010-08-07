From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: ALC892 optical SPDIF not working
Date: Sat, 7 Aug 2010 10:11:16 +0200
Message-ID: <20100807081116.GA21350@wormhole>
References: <AANLkTi=QxpJSyXgNH+WeUQdTo0kVNuPN73F-iXW5meAa@mail.gmail.com>
	<AANLkTim=_kdSJJ1NSW2D5X7GVWp=8ffwKqSbdQ9MqjMb@mail.gmail.com>
	<s5hvd7xp4dh.wl%tiwai@suse.de>
	<AANLkTin+BUQr0iVq3MT+O-dA6PYyZZF_QVcEdoM-xK9p@mail.gmail.com>
	<1280596972.4074.1.camel@mattotaupa>
	<20100731233223.GA19209@wormhole> <s5hocdl787r.wl%tiwai@suse.de>
	<s5htyndm27f.wl%tiwai@suse.de> <20100805185228.GA32760@wormhole>
	<s5hy6ck2521.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 62B03243E1
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 10:11:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy6ck2521.wl%tiwai@suse.de>
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
Cc: Manuel Lauss <mano@roarinelk.homelinux.net>, alsa-devel@alsa-project.org, Paul Menzel <paulepanter@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 05, 2010 at 10:11:18PM +0200, Takashi Iwai wrote:
> At Thu, 5 Aug 2010 20:52:28 +0200,
> Manuel Lauss wrote:
> > 
> > On Mon, Aug 02, 2010 at 06:03:32PM +0200, Takashi Iwai wrote:
> > > At Mon, 02 Aug 2010 10:02:48 +0200,
> > > I wrote:
> > > > 
> > > > At Sun, 1 Aug 2010 01:32:23 +0200,
> > > > Manuel Lauss wrote:
> > > > > 
> > > > > > > >> Is there a way to insert an initial playback delay?  Under linux, the
> > > > > > > >> first 2-2.5 seconds
> > > > > > > >> of anything played are just silence; on windows audible playback
> > > > > > > >> starts immediately.
> > > > > > > >
> > > > > > > > It's the time for synchronization your digital receiver takes, I guess.
> > > > > > > > Maybe changing SPDIF status makes it resync, which happens at each
> > > > > > > > opening / closing the stream.
> > > > > > > 
> > > > > > > Yes, seems so. I've found a workaround in meantime.
> > > > > > 
> > > > > > Could you elaborate on the workaround please, so others having this
> > > > > > issue know it.
> > > > > 
> > > > > My receiver allows to mix analog and digital inputs; with analog mix
> > > > > enabled it syncs immediately.
> > > > 
> > > > Just wondering whether the patch below helps?
> > > > 
> > > > It's just a proof-of-concept, and it's not safe for multiple streams.
> > > > If this works, we can move on the improvement of the stream assignment.
> > > 
> > > ... and the below is the patch.  If the previous patch worked, try
> > > this instead of the previous one.
> > 
> > 
> > Tested with mplayer.  The initial 2-2.5sec silence is still there (on every
> > invocation of mplayer), but seeking now works as it should (previously
> > there was 2 sec silence too).  Disabling codec pm doesn't help.
> 
> OK, it's a slight improvement.  Now the question is why it still happens
> at each invocation of mplayer.  Assuming that it's no power-save, one
> possible explanation is the call of azx_stream_reset() in prepare.
> But, then this should happen at each seek, too.
> 
> Could you put some printk's and check whether AC_VERB_SET_CHANNEL_STREAMID
> and/or AC_VERB_GET_STREAM_FORMAT verbs are executed at each time or
> properly cached?

Something new in the dmesg:

hda_codec: ALC892: BIOS auto-probing.
ALSA hda_codec.c:337: hda_codec: connection list not available for 0x1f
ALSA device list:
  #0: HDA ATI SB at 0xfe024000 irq 16


I added a few printks (see patch below).  This is the output generated
at every invocation of mplayer:

S1: p->stream_tag 00000000 stream_tag 00000005 p->channel_id 0 channel_id 0
S2: oldval 0 newval 50
S3: p->format_id 0 format 49
S4: oldval 0 newval 50
S1: p->stream_tag 00000000 stream_tag 00000005 p->channel_id 0 channel_id 0
S2: oldval 0 newval 50
S3: p->format_id 0 format 49
S4: oldval 0 newval 50
S1: p->stream_tag 00000000 stream_tag 00000005 p->channel_id 0 channel_id 0
S2: oldval 0 newval 50
S3: p->format_id 0 format 49
S4: oldval 0 newval 50
S1: p->stream_tag 00000000 stream_tag 00000005 p->channel_id 0 channel_id 0
S2: oldval 0 newval 50
S3: p->format_id 0 format 49
S4: oldval 0 newval 50
S1: p->stream_tag 00000000 stream_tag 00000005 p->channel_id 0 channel_id 0
S2: oldval 0 newval 50
S3: p->format_id 0 format 49
S4: oldval 0 newval 50



diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index d510359..d6036c6 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1227,9 +1227,13 @@ void snd_hda_codec_setup_stream(struct hda_codec *codec, hda_nid_t nid,
        if (!p)
                return;
        /* update the stream-id if changed */
+       printk(KERN_ERR "S1: p->stream_tag %08lx stream_tag %08lx p->channel_id %d channel_id %d\n",
+               p->stream_tag, stream_tag, p->channel_id, channel_id);
+
        if (p->stream_tag != stream_tag || p->channel_id != channel_id) {
                oldval = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
                newval = (stream_tag << 4) | channel_id;
+               printk(KERN_ERR "S2: oldval %x newval %x\n", oldval, newval);
                if (oldval != newval)
                        snd_hda_codec_write(codec, nid, 0,
                                            AC_VERB_SET_CHANNEL_STREAMID,
@@ -1238,9 +1242,11 @@ void snd_hda_codec_setup_stream(struct hda_codec *codec, hda_nid_t nid,
                p->channel_id = channel_id;
        }
        /* update the format-id if changed */
+       printk(KERN_ERR "S3: p->format_id %d format %d\n", p->format_id, format);
        if (p->format_id != format) {
                oldval = snd_hda_codec_read(codec, nid, 0,
                                            AC_VERB_GET_STREAM_FORMAT, 0);
+               printk(KERN_ERR "S4: oldval %x newval %x\n", oldval, newval);
                if (oldval != format) {
                        msleep(1);
                        snd_hda_codec_write(codec, nid, 0,


Thanks!
       Manuel Lauss
