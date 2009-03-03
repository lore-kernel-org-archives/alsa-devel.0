From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: PCM File plugin - minor fix
Date: Tue, 03 Mar 2009 15:26:38 +0100
Message-ID: <49AD3E1E.9030806@insite.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030107070405080100000800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id BAC2D103804
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 15:26:36 +0100 (CET)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030107070405080100000800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

After some consideration I decided to ask for changing the meaning of 
the %b key from bytes to bits as it provides more convenience.

Thanks for commiting the patch.

Pavel Hofman.

--------------030107070405080100000800
Content-Type: text/x-diff;
 name="pcm_file.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_file.c.patch"

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 6ddf14f..bfa1cc8 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -172,7 +172,7 @@ static int snd_pcm_file_replace_fname(snd_pcm_file_t *file, char **new_fname_p)
 
 			case BWIDTH_KEY:
 				snprintf(value, sizeof(value), "%d",
-					pcm->frame_bits/(8 * pcm->channels));
+					pcm->frame_bits/pcm->channels);
 				err = snd_pcm_file_append_value(&new_fname,
 						&new_index_ch, &new_len, value);
 				if (err < 0)
@@ -816,7 +816,7 @@ pcm.name {
 				# real values corresponding to the stream:
 				# %r	rate (replaced with: 48000)
 				# %c	channels (replaced with: 2)
-				# %b	bytes per sample (replaced with: 2)
+				# %b	bits per sample (replaced with: 16)
 				# %f	sample format string
 				#			(replaced with: S16_LE)
 				# %%	replaced with %

--------------030107070405080100000800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030107070405080100000800--
