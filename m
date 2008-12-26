From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda - fix name for ALC1200
Date: Fri, 26 Dec 2008 12:20:43 +0800
Message-ID: <20081226042043.GA14192@localhost>
References: <4950C9F5.3030803@gmx.net> <20081225043102.GB7519@localhost>
	<49538716.4040401@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BCD61037EE
	for <alsa-devel@alsa-project.org>; Fri, 26 Dec 2008 05:20:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49538716.4040401@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thomas Schneider <nailstudio@gmx.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 25, 2008 at 03:13:58PM +0200, Thomas Schneider wrote:
> Hi,
> 
> here is the output from alsa-info.sh
> 
> http://www.alsa-project.org/db/?f=8282910dc807e1f141896886cd5f8fd574117000
> 
> I found another small mistake. In the Mixer my Soundcard is shown as "Realtek ALC888".
> When i switch this to lines in patch_realtek.c then it is shown as "Realtek ALC1200".
> 
> 
> static struct hda_codec_preset snd_hda_preset_realtek[] = {
> ......
> 
>     { .id = 0x10ec0888, .name = "ALC888", .patch = patch_alc883 },
>     { .id = 0x10ec0888, .rev = 0x100101, .name = "ALC1200",
>       .patch = patch_alc883 },
> 
> .....

Good catch!

Reversing the order should fix the name.

Thanks,
Fengguang
---
hda - fix name for ALC1200

Move the more specific preset for ALC1200 above the general one for
ALC888, so that it will have the chance to get matched and selected.

Reported-by: Thomas Schneider <nailstudio@gmx.net>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/patch_realtek.c
+++ sound-2.6/sound/pci/hda/patch_realtek.c
@@ -16638,9 +16638,9 @@ static struct hda_codec_preset snd_hda_p
 	  .patch = patch_alc882 }, /* should be patch_alc883() in future */
 	{ .id = 0x10ec0885, .name = "ALC885", .patch = patch_alc882 },
 	{ .id = 0x10ec0887, .name = "ALC887", .patch = patch_alc883 },
-	{ .id = 0x10ec0888, .name = "ALC888", .patch = patch_alc883 },
 	{ .id = 0x10ec0888, .rev = 0x100101, .name = "ALC1200",
 	  .patch = patch_alc883 },
+	{ .id = 0x10ec0888, .name = "ALC888", .patch = patch_alc883 },
 	{ .id = 0x10ec0889, .name = "ALC889", .patch = patch_alc883 },
 	{} /* terminator */
 };
