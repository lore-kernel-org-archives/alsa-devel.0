From: Antonio Ospite <ao2@ao2.it>
Subject: [alsa-lib][PATCH] test/seq-decoder: enable
	timestamping for external subscribers
Date: Tue, 26 Sep 2017 16:44:49 +0200
Message-ID: <20170926144449.28289-1-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id C39CC267115
 for <alsa-devel@alsa-project.org>; Tue, 26 Sep 2017 16:45:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Antonio Ospite <ao2@ao2.it>
List-Id: alsa-devel@alsa-project.org

Events sent by external clients subscribed to the input port are not
timestamped.

This inconsistent behavior may surprise newbies who look at seq-decoder as
a reference example.

See the example below using "vkeybd --addr 128:0" to connect to seq-decoder,
the events sent by vkeybd are on a different queue with no timestamps:

  ...
  EVENT>>> Type = 66, flags = 0x0, time = 0 ticks
           Source = 0.1, dest = 128.0, queue = 253
           Event = Port Subscribed; 129:0 -> 128:0
  EVENT>>> Type = 66, flags = 0x1, time = 4.829712627
           Source = 0.1, dest = 128.0, queue = 0
           Event = Port Subscribed; 129:0 -> 128:0
  EVENT>>> Type = 10, flags = 0x0, time = 0 ticks
           Source = 129.0, dest = 128.0, queue = 253
           Event = Controller; ch=0, param=0, value=0
  EVENT>>> Type = 11, flags = 0x0, time = 0 ticks
           Source = 129.0, dest = 128.0, queue = 253
           Event = Program Change; ch=0, program=0
  ...

After the change events are on the main queue and are timestamped:

  ...
  EVENT>>> Type = 66, flags = 0x1, time = 4.280907223
           Source = 0.1, dest = 128.0, queue = 0
           Event = Port Subscribed; 129:0 -> 128:0
  EVENT>>> Type = 66, flags = 0x1, time = 4.280912063
           Source = 0.1, dest = 128.0, queue = 0
           Event = Port Subscribed; 129:0 -> 128:0
  EVENT>>> Type = 10, flags = 0x1, time = 4.280990702
           Source = 129.0, dest = 128.0, queue = 0
           Event = Controller; ch=0, param=0, value=0
  EVENT>>> Type = 11, flags = 0x1, time = 4.280994862
           Source = 129.0, dest = 128.0, queue = 0
           Event = Program Change; ch=0, program=0
  ...

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---

Hi,

while looking into improving the alsamidisrc[1,2] GStreamer element, I took
a better look at what the sequencer API could do and started using
test/seq-decoder.c as a reference example.

I noticed the issue discussed above and I tried to fix it in order to have
a more consistent behavior of event timestamping.

I think the new behavior is less surprising for newbies but I may still be
missing something, please let me know if I am.

Thanks,
   Antonio

[1] https://cgit.freedesktop.org/gstreamer/gst-plugins-base/tree/ext/alsa/gstalsamidisrc.c
[2] https://bugzilla.gnome.org/show_bug.cgi?id=787683

 test/seq-decoder.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/test/seq-decoder.c b/test/seq-decoder.c
index b110e98d..38755553 100644
--- a/test/seq-decoder.c
+++ b/test/seq-decoder.c
@@ -283,6 +283,12 @@ void event_decoder(snd_seq_t *handle, int argc, char *argv[])
 	snd_seq_port_info_set_name(pinfo, "Input");
 	snd_seq_port_info_set_type(pinfo, SND_SEQ_PORT_TYPE_MIDI_GENERIC);
 	snd_seq_port_info_set_capability(pinfo, SND_SEQ_PORT_CAP_WRITE | SND_SEQ_PORT_CAP_READ | SND_SEQ_PORT_CAP_SUBS_WRITE);
+
+	/* Enable timestamping for events sent by external subscribers. */
+	snd_seq_port_info_set_timestamping(pinfo, 1);
+	snd_seq_port_info_set_timestamp_real(pinfo, 1);
+	snd_seq_port_info_set_timestamp_queue(pinfo, queue);
+
 	if ((err = snd_seq_create_port(handle, pinfo)) < 0) {
 		fprintf(stderr, "Cannot create input port: %s\n", snd_strerror(err));
 		return;
-- 
2.14.1
