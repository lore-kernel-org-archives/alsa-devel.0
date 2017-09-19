From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [alsa-devel] [PATCH RESEND1 00/12] ALSA: vsnd: Add Xen
 para-virtualized frontend driver
Date: Tue, 19 Sep 2017 11:57:30 +0300
Message-ID: <d29615e8-0fc2-68b8-d158-90378dc5ebeb@gmail.com>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
 <7e62a406-7dcd-b5c9-b2de-ea52e1d2afd0@sakamocchi.jp>
 <b9e34f0e-4a9a-9ccf-6165-04cd22a070ac@gmail.com>
 <CACvf2oU4puqSuNj2k5REpmFJdvWcTWY+AaNEJtknLP4XMPdbsg@mail.gmail.com>
 <e5d52c8a-09e0-2823-dcff-e595868c7dee@sakamocchi.jp>
 <2a2fd222-fc54-1709-bfc8-a530efc3f307@gmail.com>
 <ad4f2201-bfab-415d-0120-308989653628@sakamocchi.jp>
 <b129960e-b38f-ea94-3e4a-3cd409f7a707@gmail.com>
 <3f8e535b-8607-6b15-6e17-da755a06cc1e@sakamocchi.jp>
 <CACvf2oUJtxVTuV0qu4z4kV=aSOH5O_8v=UjH_3tr4wCJdXuEjw@mail.gmail.com>
 <3fde10f8-4727-e37b-8001-ce2356fffb2b@sakamocchi.jp>
 <162b7251-4040-c61f-1fcd-c32f65bd3c67@gmail.com>
 <8542f293-f2d0-9ba3-7082-967b32fcec17@ladisch.de>
 <CACvf2oUYM5_KWKsv1Q8=fkqzgMHieYQ76GyiwPTh8UsB+K9iFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------60CDEC54B11A09A3AE0FA146"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACvf2oUYM5_KWKsv1Q8=fkqzgMHieYQ76GyiwPTh8UsB+K9iFg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Grytsov <al1img@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, Oleksandr Grytsov <oleksandr_grytsov@epam.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------60CDEC54B11A09A3AE0FA146
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, all!

We did some work on implementing the idea with

feedback events from the backend to the frontend.

Please see attached the changes to the existing sndif protocol [1]:

1. Introduced a new event channel from back to front

2. New event with number of bytes played/captured (XENSND_EVT_CUR_POS,

to be used for sending snd_pcm_period_elapsed at frontend.

Sent in bytes, not frames to make the protocol generic and consistent)

3. New request for playback/capture control (XENSND_OP_TRIGGER)

with start/pause/stop/resume sub-ops.

The implementation we have showed that this is sufficient to
successfully play/capture w/o using emulated interrupts.

Clemens, Sakamoto-san,
could you please review the changes and confirm that these are ok to
be upstreamed to the sndif protocol and are enough for the frontend
driver we want to upstream (we have it implemented, just need to make
sure the general approach is accepted by the ALSA community).

Thank you very much for your time,
Oleksandr Andrushchenko
Oleksandr Grytsov

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/xen/interface/io/sndif.h?h=v4.14-rc1

On 09/12/2017 10:52 AM, Oleksandr Grytsov wrote:
> On Tue, Sep 5, 2017 at 10:24 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> Oleksandr Andrushchenko wrote:
>>>>> We understand that emulated interrupt on the frontend side is completely not
>>>>> acceptable
>> Allow me to expand on that:  Proper synchronization requires that the
>> exact position is communicated, not estimated.  Just because the nominal
>> rate of the stream is known does not imply that you know the actual rate.
>> Forget for the moment that there even is a nominal rate; assume that it
>> works like, e.g., a storage controller, and that you can know that a DMA
>> buffer was consumed by the device only after it has told you.
>>
>> It's possible and likely that there is a latency when reporting the
>> stream position, but that is still better than guessing what the DMA
>> is doing.  (You would never just try to guess when writing data to
>> disk, would you?)
>>
>>>>> and definitely we need to provide some feedback mechanism from
>>>>> Dom0 to DomU.
>>>>>
>>>>> In our case it is technically impossible to provide precise period interrupt
>>>>> (mostly because our backend is a user space application).
>> As far as I can see, all audio APIs (ALSA, PulseAudio, etc.) have poll()
>> or callbacks or similar mechanisms to inform you when new data can be
>> written, and always allow to query the current position.
>>
>>> [...]
>>> ok, so the main concern here is that we cannot properly synchronize Dom0-DomU.
>>> If we put this apart for a second are there any other concerns on having ALSA
>>> frontend driver? If not, can we have the driver with timer implementation upstreamed
>>> as experimental until we have some acceptable synchronization solution?
>>> This will allow broader audience to try and feel the solution and probably contribute?
>> I doubt that the driver architecture will stay completely the same, so I
>> do not think that this experimental driver would demonstrate how the
>> solution would feel.
>>
>> As the first step, I would suggest creating a driver with proper
>> synchronization, even if it has high latency.  Reducing the latency
>> would then be 'just' an optimization.
>>
>>
>> Regards,
>> Clemens
> Definitely feedback from the backend side is required. Currently
> we are working on synchronized version on the backend
> and frontend side. We will be back once we have the solution.
>
> Thanks.


--------------60CDEC54B11A09A3AE0FA146
Content-Type: text/x-patch;
 name="sndif_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sndif_v2.patch"

diff --git a/include/xen/interface/io/sndif.h b/include/xen/interface/io/sndif.h
index 5c918276835e..763a3f0164f4 100644
--- a/include/xen/interface/io/sndif.h
+++ b/include/xen/interface/io/sndif.h
@@ -38,6 +38,13 @@
 
 /*
  ******************************************************************************
+ *                           Protocol version
+ ******************************************************************************
+ */
+#define XENDISPL_PROTOCOL_VERSION	"2"
+
+/*
+ ******************************************************************************
  *                  Feature and Parameter Negotiation
  ******************************************************************************
  *
@@ -104,8 +111,10 @@
  * /local/domain/1/device/vsnd/0/0/0/sample-formats = "s8,u8"
  * /local/domain/1/device/vsnd/0/0/0/unique-id = "0"
  *
- * /local/domain/1/device/vsnd/0/0/0/ring-ref = "386"
- * /local/domain/1/device/vsnd/0/0/0/event-channel = "15"
+ * /local/domain/1/device/vsnd/0/0/0/req-ring-ref = "386"
+ * /local/domain/1/device/vsnd/0/0/0/req-event-channel = "15"
+ * /local/domain/1/device/vsnd/0/0/0/evt-ring-ref = "1386"
+ * /local/domain/1/device/vsnd/0/0/0/evt-event-channel = "215"
  *
  *------------------------------ Stream 1, capture ----------------------------
  *
@@ -113,8 +122,10 @@
  * /local/domain/1/device/vsnd/0/0/1/channels-max = "2"
  * /local/domain/1/device/vsnd/0/0/1/unique-id = "1"
  *
- * /local/domain/1/device/vsnd/0/0/1/ring-ref = "384"
- * /local/domain/1/device/vsnd/0/0/1/event-channel = "13"
+ * /local/domain/1/device/vsnd/0/0/1/req-ring-ref = "384"
+ * /local/domain/1/device/vsnd/0/0/1/req-event-channel = "13"
+ * /local/domain/1/device/vsnd/0/0/1/evt-ring-ref = "1384"
+ * /local/domain/1/device/vsnd/0/0/1/evt-event-channel = "213"
  *
  *------------------------------- PCM device 1 --------------------------------
  *
@@ -126,8 +137,10 @@
  * /local/domain/1/device/vsnd/0/1/0/type = "c"
  * /local/domain/1/device/vsnd/0/1/0/unique-id = "2"
  *
- * /local/domain/1/device/vsnd/0/1/0/ring-ref = "387"
- * /local/domain/1/device/vsnd/0/1/0/event-channel = "151"
+ * /local/domain/1/device/vsnd/0/1/0/req-ring-ref = "387"
+ * /local/domain/1/device/vsnd/0/1/0/req-event-channel = "151"
+ * /local/domain/1/device/vsnd/0/1/0/evt-ring-ref = "1387"
+ * /local/domain/1/device/vsnd/0/1/0/evt-event-channel = "351"
  *
  *------------------------------- PCM device 2 --------------------------------
  *
@@ -138,8 +151,10 @@
  * /local/domain/1/device/vsnd/0/2/0/type = "p"
  * /local/domain/1/device/vsnd/0/2/0/unique-id = "3"
  *
- * /local/domain/1/device/vsnd/0/2/0/ring-ref = "389"
- * /local/domain/1/device/vsnd/0/2/0/event-channel = "152"
+ * /local/domain/1/device/vsnd/0/2/0/req-ring-ref = "389"
+ * /local/domain/1/device/vsnd/0/2/0/req-event-channel = "152"
+ * /local/domain/1/device/vsnd/0/2/0/evt-ring-ref = "1389"
+ * /local/domain/1/device/vsnd/0/2/0/evt-event-channel = "452"
  *
  ******************************************************************************
  *                            Backend XenBus Nodes
@@ -273,13 +288,30 @@
  *
  *-------------------- Stream Request Transport Parameters --------------------
  *
- * event-channel
+ * req-event-channel
+ *      Values:         <uint32_t>
+ *
+ *      The identifier of the Xen event channel used to signal activity
+ *      in the ring buffer.
+ *
+ * req-ring-ref
+ *      Values:         <uint32_t>
+ *
+ *      The Xen grant reference granting permission for the backend to map
+ *      a sole page in a single page sized ring buffer.
+ *
+ *--------------------- Stream Event Transport Parameters ---------------------
+ *
+ * This communication path is used to deliver asynchronous events from backend
+ * to frontend, set up per stream.
+ *
+ * evt-event-channel
  *      Values:         <uint32_t>
  *
  *      The identifier of the Xen event channel used to signal activity
  *      in the ring buffer.
  *
- * ring-ref
+ * evt-ring-ref
  *      Values:         <uint32_t>
  *
  *      The Xen grant reference granting permission for the backend to map
@@ -432,6 +464,19 @@
 #define XENSND_OP_GET_VOLUME		5
 #define XENSND_OP_MUTE			6
 #define XENSND_OP_UNMUTE		7
+#define XENSND_OP_TRIGGER		8
+
+#define XENSND_OP_TRIGGER_START		0
+#define XENSND_OP_TRIGGER_PAUSE		1
+#define XENSND_OP_TRIGGER_STOP		2
+#define XENSND_OP_TRIGGER_RESUME	3
+
+/*
+ ******************************************************************************
+ *                                 EVENT CODES
+ ******************************************************************************
+ */
+#define XENSND_EVT_CUR_POS		0
 
 /*
  ******************************************************************************
@@ -446,8 +491,10 @@
 #define XENSND_FIELD_FE_VERSION		"version"
 #define XENSND_FIELD_VCARD_SHORT_NAME	"short-name"
 #define XENSND_FIELD_VCARD_LONG_NAME	"long-name"
-#define XENSND_FIELD_RING_REF		"ring-ref"
-#define XENSND_FIELD_EVT_CHNL		"event-channel"
+#define XENSND_FIELD_REQ_RING_REF	"req-ring-ref"
+#define XENSND_FIELD_REQ_EVT_CHNL	"req-event-channel"
+#define XENSND_FIELD_EVT_RING_REF	"evt-ring-ref"
+#define XENSND_FIELD_EVT_EVT_CHNL	"evt-event-channel"
 #define XENSND_FIELD_DEVICE_NAME	"name"
 #define XENSND_FIELD_TYPE		"type"
 #define XENSND_FIELD_STREAM_UNIQUE_ID	"unique-id"
@@ -559,9 +606,7 @@
  * +----------------+----------------+----------------+----------------+
  * |                           gref_directory                          | 24
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 28
- * +----------------+----------------+----------------+----------------+
- * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * |                             period_sz                             | 28
  * +----------------+----------------+----------------+----------------+
  * |                             reserved                              | 32
  * +----------------+----------------+----------------+----------------+
@@ -571,6 +616,14 @@
  * pcm_channels - uint8_t, number of channels of this stream,
  *   [channels-min; channels-max]
  * buffer_sz - uint32_t, buffer size to be allocated, octets
+ * period_sz - uint32_t, recommended event period size, octets
+ *   This is the recommended (hint) value of the period at which frontend would
+ *   like to receive XENSND_EVT_CUR_POS notifications from the backend when
+ *   stream position advances during playback/capture.
+ *   It shows how many octets are expected to be played/captured before
+ *   sending such an event.
+ *   If set to 0 no XENSND_EVT_CUR_POS events are sent by the backend.
+ *
  * gref_directory - grant_ref_t, a reference to the first shared page
  *   describing shared buffer references. At least one page exists. If shared
  *   buffer size  (buffer_sz) exceeds what can be addressed by this single page,
@@ -585,6 +638,11 @@ struct xensnd_open_req {
 	uint16_t reserved;
 	uint32_t buffer_sz;
 	grant_ref_t gref_directory;
+	uint32_t period_sz;
+};
+
+struct xensnd_trigger_req {
+	uint8_t type;
 };
 
 /*
@@ -767,8 +825,51 @@ struct xensnd_rw_req {
  * id - uint16_t, copied from the request
  * operation - uint8_t, XENSND_OP_* - copied from request
  * status - int32_t, response status, zero on success and -XEN_EXX on failure
+ *
+ *----------------------------------- Events ----------------------------------
+ *
+ * Events are sent via a shared page allocated by the front and propagated by
+ *   evt-event-channel/evt-ring-ref XenStore entries
+ * All event packets have the same length (32 octets)
+ * All event packets have common header:
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |               id                |      type      |   reserved     | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ *
+ * id - uint16_t, event id, may be used by front
+ * type - uint8_t, type of the event
+ *
+ *
+ * Current stream position - event from back to front when stream's
+ *   playback/capture position has advanced:
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |               id                |   _EVT_CUR_POS |   reserved     | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                         position low 32-bit                       | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                         position high 32-bit                      | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 32
+ * +----------------+----------------+----------------+----------------+
+ *
+ * position - current value of stream's playback/capture position, octets
+ *
  */
 
+struct xensnd_cur_pos_evt {
+	uint64_t position;
+};
+
 struct xensnd_req {
 	uint16_t id;
 	uint8_t operation;
@@ -776,6 +877,7 @@ struct xensnd_req {
 	union {
 		struct xensnd_open_req open;
 		struct xensnd_rw_req rw;
+		struct xensnd_trigger_req trigger;
 		uint8_t reserved[24];
 	} op;
 };
@@ -788,6 +890,47 @@ struct xensnd_resp {
 	uint8_t reserved1[24];
 };
 
+struct xensnd_evt {
+	uint16_t id;
+	uint8_t type;
+	uint8_t reserved[5];
+	union {
+		struct xensnd_cur_pos_evt cur_pos;
+		uint8_t reserved[24];
+	} op;
+};
+
 DEFINE_RING_TYPES(xen_sndif, struct xensnd_req, struct xensnd_resp);
 
+/*
+ ******************************************************************************
+ *                        Back to front events delivery
+ ******************************************************************************
+ * In order to deliver asynchronous events from back to front a shared page is
+ * allocated by front and its granted reference propagated to back via
+ * XenStore entries (evt-ring-ref/evt-event-channel).
+ * This page has a common header used by both front and back to synchronize
+ * access and control event's ring buffer, while back being a producer of the
+ * events and front being a consumer. The rest of the page after the header
+ * is used for event packets.
+ *
+ * Upon reception of an event(s) front may confirm its reception
+ * for either each event, group of events or none.
+ */
+
+struct xensnd_event_page {
+	uint32_t in_cons;
+	uint32_t in_prod;
+	uint8_t reserved[24];
+};
+
+#define XENSND_EVENT_PAGE_SIZE XEN_PAGE_SIZE
+#define XENSND_IN_RING_OFFS (sizeof(struct xensnd_event_page))
+#define XENSND_IN_RING_SIZE (XENSND_EVENT_PAGE_SIZE - XENSND_IN_RING_OFFS)
+#define XENSND_IN_RING_LEN (XENSND_IN_RING_SIZE / sizeof(struct xensnd_evt))
+#define XENSND_IN_RING(page) \
+	((struct xensnd_evt *)((char *)(page) + XENSND_IN_RING_OFFS))
+#define XENSND_IN_RING_REF(page, idx) \
+	(XENSND_IN_RING((page))[(idx) % XENSND_IN_RING_LEN])
+
 #endif /* __XEN_PUBLIC_IO_SNDIF_H__ */

--------------60CDEC54B11A09A3AE0FA146--
