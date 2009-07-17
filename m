From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: add bounds checking for the codec command
	fields v2
Date: Fri, 17 Jul 2009 16:49:19 +0800
Message-ID: <20090717084919.GA24645@localhost>
References: <20090717082410.GA20628@localhost>
	<20090717082703.GA21835@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id AB36710381D
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 10:49:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090717082703.GA21835@localhost>
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
Cc: Takashi Iwai <tiwai@suse.de>, Chaohong Guo <chaohong.guo@intel.com>, John Villalovos <jvillalo@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 17, 2009 at 04:27:03PM +0800, Wu Fengguang wrote:
> On Fri, Jul 17, 2009 at 04:24:10PM +0800, Wu Fengguang wrote:
> > A recent bug involves passing auto detected >0x7f NID to codec command,
> > creating an invalid codec addr field, and finally lead to cmd timeout
> > and fall back into single command mode. Jaroslav fixed that bug in
> > alc880_parse_auto_config().
> > 
> > It would be safer to further check the bounds of all cmd fields.
> > 
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> > ---
> > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> > index 462e2ce..7d09650 100644
> > --- a/sound/pci/hda/hda_codec.c
> > +++ b/sound/pci/hda/hda_codec.c
> > @@ -150,6 +150,16 @@ make_codec_cmd(struct hda_codec *codec, hda_nid_t nid, int direct,
> >  {
> >  	u32 val;
> >  
> > +	if ((direct & ~1) || (nid & ~0x7f) ||
> > +	    (verb & ~0xfff) || (parm & ~0xff)) {
> > +		printk(KERN_ERR "hda-codec: out of range cmd %x:%x:%x:%x:%x\n",
> > +		       codec->addr, direct, nid, verb, parm);
> 
> Maybe we shall simply return here?

Here it is :)

---
hda: add bounds checking for the codec command fields

A recent bug involves passing auto detected >0x7f NID to codec command,
creating an invalid codec addr field, and finally lead to cmd timeout
and fall back into single command mode. Jaroslav fixed that bug in
alc880_parse_auto_config().

It would be safer to further check the bounds of all cmd fields.

Cc: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_codec.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/hda_codec.c
+++ sound-2.6/sound/pci/hda/hda_codec.c
@@ -150,7 +150,14 @@ make_codec_cmd(struct hda_codec *codec, 
 {
 	u32 val;
 
-	val = (u32)(codec->addr & 0x0f) << 28;
+	if ((codec->addr & ~0xf) | (direct & ~1) | (nid & ~0x7f) |
+	    (verb & ~0xfff) | (parm & ~0xff)) {
+		printk(KERN_ERR "hda-codec: out of range cmd %x:%x:%x:%x:%x\n",
+		       codec->addr, direct, nid, verb, parm);
+		return ~0;
+	}
+
+	val = (u32)codec->addr << 28;
 	val |= (u32)direct << 27;
 	val |= (u32)nid << 20;
 	val |= verb << 8;
@@ -167,6 +174,9 @@ static int codec_exec_verb(struct hda_co
 	struct hda_bus *bus = codec->bus;
 	int err;
 
+	if (cmd == ~0)
+		return -1;
+
 	if (res)
 		*res = -1;
  again:
