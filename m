From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] rawmidi: virtual: fix reading into a small
	buffer
Date: Sat, 18 Mar 2017 23:10:33 +0100
Message-ID: <b91aca79-8808-0cc4-ff3b-ad7ea16dec4b@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D706266AF1
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 23:10:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In the special case for handling partial messages, the pointer
calculations were wrong, which would result in data corruption.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- alsa-lib/src/rawmidi/rawmidi_virt.c
+++ alsa-lib/src/rawmidi/rawmidi_virt.c
@@ -263,8 +263,8 @@ static ssize_t snd_rawmidi_virtual_read(snd_rawmidi_t *rmidi, void *buffer, size
 		}
 		size1 = virt->in_buf_size - virt->in_buf_ofs;
 		if ((size_t)size1 > size) {
-			virt->in_buf_ofs += size1 - size;
-			memcpy(buffer, virt->in_buf_ptr, size);
+			memcpy(buffer, virt->in_buf_ptr + virt->in_buf_ofs, size);
+			virt->in_buf_ofs += size;
 			result += size;
 			break;
 		}
