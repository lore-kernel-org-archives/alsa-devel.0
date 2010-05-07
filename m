From: Daniel Mack <daniel@caiaq.de>
Subject: Re: usbaudio: Support for USB audio v2.0 devices
Date: Fri, 7 May 2010 22:12:02 +0200
Message-ID: <20100507201202.GC30801@buzzloop.caiaq.de>
References: <4BD6E564.5050100@freemail.gr> <4BD6E737.8030805@gmail.com>
	<20100427140735.GD30804@buzzloop.caiaq.de>
	<4BD702F0.6080108@gmail.com>
	<20100427154346.GH30801@buzzloop.caiaq.de>
	<4BD71E73.5020106@gmail.com>
	<20100427173329.GI30801@buzzloop.caiaq.de>
	<4BDDAEB2.2010303@gmail.com>
	<20100503205558.GM30801@buzzloop.caiaq.de>
	<4BE4135C.80009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 145831037FC
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 22:12:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BE4135C.80009@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: The Source <thesourcehim@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 07, 2010 at 05:19:24PM +0400, The Source wrote:
> Bisect results:
> 
> 23caaf19b11eda7054348452e1618d4512a86907 is the first bad commit
> commit 23caaf19b11eda7054348452e1618d4512a86907
> Author: Daniel Mack <daniel@caiaq.de>
> Date:   Thu Mar 11 21:13:25 2010 +0100
> 
>     ALSA: usb-mixer: Add support for Audio Class v2.0
> 
>     USB Audio Class v2.0 compliant devices have different descriptors and a
>     different way of setting/getting min/max/res/cur properties. This patch
>     adds support for them.
> 
>     Signed-off-by: Daniel Mack <daniel@caiaq.de>
>     Cc: Clemens Ladisch <clemens@ladisch.de>
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 

I've found two changes in this commit that are obviously wrong.
Could you try the patch below please?

Sorry for the trouble.

Daniel


diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index 905a87c..57f2055 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -244,7 +244,7 @@ struct uac_selector_unit_descriptor {
 static inline __u8 uac_selector_unit_iSelector(struct uac_selector_unit_descriptor *desc)
 {
 	__u8 *raw = (__u8 *) desc;
-	return raw[desc->bLength - 1];
+	return raw[9 + desc->bLength - 1];
 }
 
 /* 4.3.2.5 Feature Unit Descriptor */
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 21613fe..fa0fb77 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -656,7 +656,7 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
 		case UAC_FEATURE_UNIT: {
 			/* the header is the same for v1 and v2 */
 			struct uac_feature_unit_descriptor *d = p1;
-			id = d->bUnitID;
+			id = d->bSourceID;
 			break; /* continue to parse */
 		}
 		case UAC_MIXER_UNIT: {
