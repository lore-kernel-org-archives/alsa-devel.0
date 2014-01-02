From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH, RFC 24/30] oss: midibuf: fix sleep_on races
Date: Thu,  2 Jan 2014 13:07:48 +0100
Message-ID: <1388664474-1710039-25-git-send-email-arnd@arndb.de>
References: <1388664474-1710039-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186])
 by alsa0.perex.cz (Postfix) with ESMTP id D6EA726172B
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2014 13:08:39 +0100 (CET)
In-Reply-To: <1388664474-1710039-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

sleep_on is known to be racy and going away because of this. All instances
of interruptible_sleep_on and interruptible_sleep_on_timeout in the midibuf
driver can trivially be replaced with wait_event_interruptible and
wait_event_interruptible_timeout.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/oss/midibuf.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/oss/midibuf.c b/sound/oss/midibuf.c
index 8cdb2cf..79615cf 100644
--- a/sound/oss/midibuf.c
+++ b/sound/oss/midibuf.c
@@ -86,9 +86,8 @@ static void drain_midi_queue(int dev)
 	 */
 
 	if (midi_devs[dev]->buffer_status != NULL)
-		while (!signal_pending(current) && midi_devs[dev]->buffer_status(dev)) 
-			interruptible_sleep_on_timeout(&midi_sleeper[dev],
-						       HZ/10);
+		wait_event_interruptible_timeout(midi_sleeper[dev],
+				!midi_devs[dev]->buffer_status(dev), HZ/10);
 }
 
 static void midi_input_intr(int dev, unsigned char data)
@@ -233,8 +232,8 @@ void MIDIbuf_release(int dev, struct file *file)
 							   * devices
 							 */
 
-		while (!signal_pending(current) && DATA_AVAIL(midi_out_buf[dev]))
-			  interruptible_sleep_on(&midi_sleeper[dev]);
+		wait_event_interruptible(midi_sleeper[dev],
+					 !DATA_AVAIL(midi_out_buf[dev]));
 		/*
 		 *	Sync
 		 */
@@ -282,8 +281,8 @@ int MIDIbuf_write(int dev, struct file *file, const char __user *buf, int count)
 				goto out;
 			}
 
-			interruptible_sleep_on(&midi_sleeper[dev]);
-			if (signal_pending(current)) 
+			if (wait_event_interruptible(midi_sleeper[dev],
+						SPACE_AVAIL(midi_out_buf[dev])))
 			{
 				c = -EINTR;
 				goto out;
@@ -325,8 +324,9 @@ int MIDIbuf_read(int dev, struct file *file, char __user *buf, int count)
  			c = -EAGAIN;
 			goto out;
  		}
-		interruptible_sleep_on_timeout(&input_sleeper[dev],
-					       parms[dev].prech_timeout);
+		wait_event_interruptible_timeout(input_sleeper[dev],
+						 DATA_AVAIL(midi_in_buf[dev]),
+					         parms[dev].prech_timeout);
 
 		if (signal_pending(current))
 			c = -EINTR;	/* The user is getting restless */
-- 
1.8.3.2
