From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] hctl: remove assertion from element
	event handler because removal event overwrites all of queued events
Date: Mon, 11 Jul 2016 00:12:34 +0900
Message-ID: <1468163554-22826-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C6DB3260617
 for <alsa-devel@alsa-project.org>; Sun, 10 Jul 2016 17:12:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

In ALSA control core, when several events occurs for an element, they're
represented bit mask (struct snd_ctl_event.data.elem.mask). Thus userspace
applications can handles these events separately in one I/O operation.

There's an exception; removal event. This is represented by all of bits in
the mask. Therefore, when a removal event occurs for an element, all of
queued events for the element are overwritten.

This works worse for a combination of applications which add/remove control
elements and applications which keep a cache of elements. For example,
let's assume a case that:

1.some elements are added by ioctl(SNDRV_CTL_IOCTL_ELEM_ADD).
2.ALSA control core handles the request and queues 'add' event.
3.applications don't read the event yet.
4.the elements are removed by ioctl(SNDRV_CTL_IOCTL_ELEM_REMOVE)
5.ALSA control core handles the request and queues 'removal' event by
  overwriting queued events.
6.applications read the event at last.
7.the applications cannot find removed elements in their cache data.

Especially, when applications use hctl interface of ALSA userspace library,
this situation occurs because the interface is designed to keep element
cache implicitly inner the library. PulseAudio is such an application. When
executing a test program of ALSA library (test/user-ctl-element-set.c),
pulseaudio process aborts due to assertion at calls of
snd_hctl_handle_events().

The rule to represent events is in ALSA kernel/userspace interfaces
(UAPI header) and it's difficult to improve the rule. Therefore,
developers should pay enough attention to the fact that userspace
applications can receive removal events for elements which are not
notified with 'add' event.

For this reason, this commit removes assertion from event handler of ALSA
hctl API.

CC: pulseaudio-discuss@lists.freedesktop.org
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/hcontrol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/control/hcontrol.c b/src/control/hcontrol.c
index 7645c57..c40a807 100644
--- a/src/control/hcontrol.c
+++ b/src/control/hcontrol.c
@@ -742,7 +742,6 @@ static int snd_hctl_handle_event(snd_hctl_t *hctl, snd_ctl_event_t *event)
 	if (event->data.elem.mask == SNDRV_CTL_EVENT_MASK_REMOVE) {
 		int dir;
 		res = _snd_hctl_find_elem(hctl, &event->data.elem.id, &dir);
-		assert(res >= 0 && dir == 0);
 		if (res < 0 || dir != 0)
 			return -ENOENT;
 		snd_hctl_elem_remove(hctl, (unsigned int) res);
-- 
2.7.4
