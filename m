From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 6/6] ALSA: snd-usb: add some documentation
Date: Thu, 12 Apr 2012 13:51:15 +0200
Message-ID: <1334231475-20980-7-git-send-email-zonque@gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F20A104159
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Apr 2012 13:51:27 +0200 (CEST)
In-Reply-To: <1334231475-20980-1-git-send-email-zonque@gmail.com>
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
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

Document the new streaming code and some of the functions so that
contributers can catch up easier.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/endpoint.c |  182 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 171 insertions(+), 11 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 81f19f8..5cfad6d 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -36,6 +36,32 @@
 #define EP_FLAG_RUNNING		1
 
 /*
+ * snd_usb_endpoint is a model that abstracts everything related to an
+ * USB endpoint and its streaming.
+ *
+ * There are functions to activate and deactivate the streaming URBs and
+ * optinal callbacks to let the pcm logic handle the actual content of the
+ * packets for playback and record. Thus, the bus streaming and the audio
+ * handlers are fully decoupled.
+ *
+ * There are two different types of endpoints in for audio applications.
+ *
+ * SND_USB_ENDPOINT_TYPE_DATA handles full audio data payload for both
+ * inbound and outbound traffic.
+ *
+ * SND_USB_ENDPOINT_TYPE_SYNC are for inbound traffic only and expect the
+ * payload to carry Q16.16 formatted sync information (3 or 4 bytes).
+ *
+ * Each endpoint has to be configured (by calling
+ * snd_usb_endpoint_set_params()) before it can be used.
+ *
+ * The model incorporates a reference counting, so that multiple users
+ * can call snd_usb_endpoint_start() and snd_usb_endpoint_stop(), and
+ * only the first user will effectively start the URBs, and only the last
+ * one will tear them down again.
+ */
+
+/*
  * convert a sampling rate into our full speed format (fs/1000 in Q16.16)
  * this will overflow at approx 524 kHz
  */
@@ -91,6 +117,14 @@ static const char *usb_error_string(int err)
 	}
 }
 
+/**
+ * snd_usb_endpoint_implicit_feedback_sink: Report endpoint usage type
+ *
+ * @ep: The endpoint
+ *
+ * Determine whether an endpoint is driven by an implicit feedback
+ * data endpoint source.
+ */
 int snd_usb_endpoint_implict_feedback_sink(struct snd_usb_endpoint *ep)
 {
 	return  ep->sync_master &&
@@ -99,7 +133,13 @@ int snd_usb_endpoint_implict_feedback_sink(struct snd_usb_endpoint *ep)
 		usb_pipeout(ep->pipe);
 }
 
-/* determine the number of frames in the next packet */
+/*
+ * For streaming based on information derived from sync endpoints,
+ * prepare_outbound_urb_sizes() will call next_packet_size() to
+ * determine the number of samples to be sent in the next packet.
+ *
+ * For implicit feedback, next_packet_size() is unused.
+ */
 static int next_packet_size(struct snd_usb_endpoint *ep)
 {
 	unsigned long flags;
@@ -237,6 +277,19 @@ static inline void prepare_inbound_urb(struct snd_usb_endpoint *ep,
 	}
 }
 
+/*
+ * Send output urbs that have been prepared previously. Urbs are dequeued
+ * from ep->ready_playback_urbs and in case there there aren't any available
+ * or there are no packets that have been prepared, this function does
+ * nothing.
+ *
+ * The reason why the functionality of sending and preparing urbs is separated
+ * is that host controllers don't guarantee an ordering in returing inbound
+ * and outbound packets to their submitters.
+ *
+ * This function is only used for implicit feedback endpoints. For endpoints
+ * driven by sync endpoints, urbs are submitted from their completion handler.
+ */
 static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
 {
 	while (test_bit(EP_FLAG_RUNNING, &ep->flags)) {
@@ -270,6 +323,7 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
 		for (i = 0; i < packet->packets; i++)
 			ctx->packet_size[i] = packet->packet_size[i];
 
+		/* call the data handler to fill in playback data */
 		prepare_outbound_urb(ep, ctx);
 
 		err = usb_submit_urb(ctx->urb, GFP_ATOMIC);
@@ -336,6 +390,22 @@ exit_clear:
 	clear_bit(ctx->index, &ep->active_mask);
 }
 
+/**
+ * snd_usb_add_endpoint: Add an endpoint to an audio chip
+ *
+ * @chip: The chip
+ * @alts: The USB host interface
+ * @ep_num: The number of the endpoint to use
+ * @direction: SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CAPTURE
+ * @type: SND_USB_ENDPOINT_TYPE_DATA or SND_USB_ENDPOINT_TYPE_SYNC
+ *
+ * If the requested endpoint has not been added to the given chip before,
+ * a new instance is created. Otherwise, a pointer to the previoulsy
+ * created instance is returned. In case of any error, NULL is returned.
+ *
+ * New endpoints will be added to chip->ep_list and must be freed by
+ * calling snd_usb_endpoint_free().
+ */
 struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 					      struct usb_host_interface *alts,
 					      int ep_num, int direction, int type)
@@ -506,6 +576,9 @@ static void release_urbs(struct snd_usb_endpoint *ep, int force)
 	ep->nurbs = 0;
 }
 
+/*
+ * configure a data endpoint
+ */
 static int data_ep_set_params(struct snd_usb_endpoint *ep,
 			      struct snd_pcm_hw_params *hw_params,
 			      struct audioformat *fmt,
@@ -629,6 +702,9 @@ out_of_memory:
 	return -ENOMEM;
 }
 
+/*
+ * configure a sync endpoint
+ */
 static int sync_ep_set_params(struct snd_usb_endpoint *ep,
 			      struct snd_pcm_hw_params *hw_params,
 			      struct audioformat *fmt)
@@ -669,6 +745,15 @@ out_of_memory:
 	return -ENOMEM;
 }
 
+/**
+ * snd_usb_endpoint_set_params: configure an snd_endpoint
+ *
+ * @ep: the endpoint to configure
+ *
+ * Determine the number of of URBs to be used on this endpoint.
+ * An endpoint must be configured before it can be started.
+ * An endpoint that is already running can not be reconfigured.
+ */
 int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 				struct snd_pcm_hw_params *hw_params,
 				struct audioformat *fmt,
@@ -717,6 +802,19 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 	return err;
 }
 
+/**
+ * snd_usb_endpoint_start: start an snd_usb_endpoint
+ *
+ * @ep: the endpoint to start
+ *
+ * A call to this function will increment the use count of the endpoint.
+ * In case this not already running, the URBs for this endpoint will be
+ * submitted. Otherwise, this function does nothing.
+ *
+ * Must be balanced to calls of snd_usb_endpoint_stop().
+ *
+ * Returns an error if the URB submission failed, 0 in all other cases.
+ */
 int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
 {
 	int err;
@@ -788,6 +886,17 @@ __error:
 	return -EPIPE;
 }
 
+/**
+ * snd_usb_endpoint_stop: stop an snd_usb_endpoint
+ *
+ * @ep: the endpoint to stop (may be NULL)
+ *
+ * A call to this function will decrement the use count of the endpoint.
+ * In case the last user has requested the endpoint stop, the URBs will
+ * actually deactivated.
+ *
+ * Must be balanced to calls of snd_usb_endpoint_start().
+ */
 void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
 			   int force, int can_sleep, int wait)
 {
@@ -812,6 +921,19 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
 	}
 }
 
+/**
+ * snd_usb_endpoint_activate: activate an snd_usb_endpoint
+ *
+ * @ep: the endpoint to activate
+ *
+ * If the endpoint is not currently in use, this functions will select the
+ * correct alternate interface setting for the interface of this endpoint.
+ *
+ * In case of any active users, this functions does nothing.
+ *
+ * Returns an error if usb_set_interface() failed, 0 in all other
+ * cases.
+ */
 int snd_usb_endpoint_activate(struct snd_usb_endpoint *ep)
 {
 	if (ep->use_count != 0)
@@ -835,6 +957,19 @@ int snd_usb_endpoint_activate(struct snd_usb_endpoint *ep)
 	return -EBUSY;
 }
 
+/**
+ * snd_usb_endpoint_deactivate: deactivate an snd_usb_endpoint
+ *
+ * @ep: the endpoint to deactivate
+ *
+ * If the endpoint is not currently in use, this functions will select the
+ * alternate interface setting 0 for the interface of this endpoint.
+ *
+ * In case of any active users, this functions does nothing.
+ *
+ * Returns an error if usb_set_interface() failed, 0 in all other
+ * cases.
+ */
 int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
 {
 	if (!ep)
@@ -860,6 +995,13 @@ int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
 	return -EBUSY;
 }
 
+/** snd_usb_endpoint_free: Free the resources of an snd_usb_endpoint
+ *
+ * @ep: the list header of the endpoint to free
+ *
+ * This function does not care for the endpoint's use count but will tear
+ * down all the streaming URBs immediately and free all resources.
+ */
 void snd_usb_endpoint_free(struct list_head *head)
 {
 	struct snd_usb_endpoint *ep;
@@ -869,15 +1011,15 @@ void snd_usb_endpoint_free(struct list_head *head)
 	kfree(ep);
 }
 
-/*
- * process after playback sync complete
- *
- * Full speed devices report feedback values in 10.14 format as samples per
- * frame, high speed devices in 16.16 format as samples per microframe.
- * Because the Audio Class 1 spec was written before USB 2.0, many high speed
- * devices use a wrong interpretation, some others use an entirely different
- * format.  Therefore, we cannot predict what format any particular device uses
- * and must detect it automatically.
+/**
+ * snd_usb_handle_sync_urb: parse an USB sync packet
+ *
+ * @ep: the endpoint to handle the packet
+ * @sender: the sending endpoint
+ * @urb: the received packet
+ *
+ * This function is called from the context of an endpoint that received
+ * the packet and is used to let another endpoint object handle the payload.
  */
 void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 			     struct snd_usb_endpoint *sender,
@@ -889,6 +1031,11 @@ void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 
 	snd_BUG_ON(ep == sender);
 
+	/*
+	 * In case the endpoint is operating in implicit feedback mode, prepare
+	 * and a new outbound URB that has the same layout as the received
+	 * packet and add it to the list of pending urbs.
+	 */
 	if (snd_usb_endpoint_implict_feedback_sink(ep) &&
 	    ep->use_count != 0) {
 
@@ -938,7 +1085,20 @@ void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 		return;
 	}
 
-	/* parse sync endpoint packet */
+	/*
+	 * process after playback sync complete
+	 *
+	 * Full speed devices report feedback values in 10.14 format as samples
+	 * per frame, high speed devices in 16.16 format as samples per
+	 * microframe.
+	 *
+	 * Because the Audio Class 1 spec was written before USB 2.0, many high
+	 * speed devices use a wrong interpretation, some others use an
+	 * entirely different format.
+	 *
+	 * Therefore, we cannot predict what format any particular device uses
+	 * and must detect it automatically.
+	 */
 
 	if (urb->iso_frame_desc[0].status != 0 ||
 	    urb->iso_frame_desc[0].actual_length < 3)
-- 
1.7.7.6
