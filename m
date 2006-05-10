From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Request to change enums to int in alsa-lib
Date: Wed, 10 May 2006 14:47:01 +0200
Message-ID: <4461E0C5.3040305@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030901030805030900000309"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030901030805030900000309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi!

I experience a problem when compiling the alsa library on the avr32
platform. The problem is that our GCC compiler uses short enums, instead
off how GCC usually manage enums. This turns the IOCTLs inside the alsa
library into values not matching the IOCTLs in the Linux kernel.

I have attached a patch which changes all enums into ints, and the
library now works for me. I have no idea if I have broken something
else. I have another issue, but I'll post that in a separate email.

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway

--------------030901030805030900000309
Content-Type: text/x-patch;
 name="alsa-lib-1.0.11-convert-enums-to-int.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-1.0.11-convert-enums-to-int.patch"

--- alsa-lib-1.0.11.orig/./include/local.h	2006-02-20 20:32:53.000000000 +0100
+++ alsa-lib-1.0.11/./include/local.h	2006-05-10 13:32:03.000000000 +0200
@@ -134,13 +134,15 @@
 #define SND_BIG_ENDIAN
 #endif
 
-struct _snd_async_handler {
-	enum {
+enum _snd_async_handler_type {
 		SND_ASYNC_HANDLER_GENERIC,
 		SND_ASYNC_HANDLER_CTL,
 		SND_ASYNC_HANDLER_PCM,
 		SND_ASYNC_HANDLER_TIMER,
-	} type;
+};
+
+struct _snd_async_handler {
+	int type;
 	int fd;
 	union {
 		snd_ctl_t *ctl;
--- alsa-lib-1.0.11.orig/./include/mixer.h	2005-08-24 12:41:16.000000000 +0200
+++ alsa-lib-1.0.11/./include/mixer.h	2006-05-10 13:30:44.000000000 +0200
@@ -208,7 +208,7 @@
 	/** structure version */
 	int ver;
 	/** v1: abstract layer selection */
-	enum snd_mixer_selem_regopt_abstract abstract;
+	int abstract;
 	/** v1: device name (must be NULL when playback_pcm or capture_pcm != NULL) */
 	const char *device;
 	/** v1: playback PCM connected to mixer device (NULL == none) */
--- alsa-lib-1.0.11.orig/./include/sound/asequencer.h	2005-12-12 10:36:02.000000000 +0100
+++ alsa-lib-1.0.11/./include/sound/asequencer.h	2006-05-10 13:33:38.000000000 +0200
@@ -317,7 +317,7 @@
 		struct sndrv_seq_ev_sample sample;
 		struct sndrv_seq_ev_cluster cluster;
 		sndrv_seq_position_t position;
-		enum sndrv_seq_stop_mode stop_mode;
+		int stop_mode;
 		sndrv_seq_frequency_t frequency;
 		struct sndrv_seq_ev_volume volume;
 		struct sndrv_seq_ev_loop loop;
@@ -521,7 +521,7 @@
 
 struct sndrv_seq_client_info {
 	int client;			/* client number to inquire */
-	enum sndrv_seq_client_type type;	/* client type */
+	int type;			/* client type */
 	char name[64];			/* client name */
 	unsigned int filter;		/* filter flags */
 	unsigned char multicast_filter[8]; /* multicast filter bitmap */
--- alsa-lib-1.0.11.orig/./include/sound/asound.h	2005-08-16 14:19:15.000000000 +0200
+++ alsa-lib-1.0.11/./include/sound/asound.h	2006-05-10 13:35:21.000000000 +0200
@@ -122,7 +122,7 @@
 	int card;			/* R: card number */
 	unsigned char id[64];		/* ID (user selectable) */
 	unsigned char name[80];		/* hwdep name */
-	enum sndrv_hwdep_iface iface;	/* hwdep interface */
+	int iface;			/* hwdep interface */
 	unsigned char reserved[64];	/* reserved for future */
 };
 
@@ -306,13 +306,13 @@
 struct sndrv_pcm_info {
 	unsigned int device;		/* RO/WR (control): device number */
 	unsigned int subdevice;		/* RO/WR (control): subdevice number */
-	enum sndrv_pcm_stream stream;	/* RO/WR (control): stream number */
+	int stream;			/* RO/WR (control): stream number */
 	int card;			/* R: card number */
 	unsigned char id[64];		/* ID (user selectable) */
 	unsigned char name[80];		/* name of this device */
 	unsigned char subname[32];	/* subdevice name */
-	enum sndrv_pcm_class dev_class;	/* SNDRV_PCM_CLASS_* */
-	enum sndrv_pcm_subclass dev_subclass; /* SNDRV_PCM_SUBCLASS_* */
+	int dev_class;			/* SNDRV_PCM_CLASS_* */
+	int dev_subclass;		/* SNDRV_PCM_SUBCLASS_* */
 	unsigned int subdevices_count;
 	unsigned int subdevices_avail;
 	union sndrv_pcm_sync_id sync;	/* hardware synchronization ID */
@@ -385,7 +385,7 @@
 };
 
 struct sndrv_pcm_sw_params {
-	enum sndrv_pcm_tstamp tstamp_mode;	/* timestamp mode */
+	int tstamp_mode;			/* timestamp mode */
 	unsigned int period_step;
 	unsigned int sleep_min;			/* min ticks to sleep */
 	sndrv_pcm_uframes_t avail_min;		/* min avail frames for wakeup */
@@ -406,7 +406,7 @@
 };
 
 struct sndrv_pcm_status {
-	enum sndrv_pcm_state state;	/* stream state */
+	int state;			/* stream state */
 	struct timespec trigger_tstamp;	/* time when stream was started/stopped/paused */
 	struct timespec tstamp;		/* reference timestamp */
 	sndrv_pcm_uframes_t appl_ptr;	/* appl ptr */
@@ -415,16 +415,16 @@
 	sndrv_pcm_uframes_t avail;	/* number of frames available */
 	sndrv_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
 	sndrv_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
-	enum sndrv_pcm_state suspended_state; /* suspended stream state */
+	int suspended_state;		/* suspended stream state */
 	unsigned char reserved[60];	/* must be filled with zero */
 };
 
 struct sndrv_pcm_mmap_status {
-	enum sndrv_pcm_state state;	/* RO: state - SNDRV_PCM_STATE_XXXX */
+	int state;			/* RO: state - SNDRV_PCM_STATE_XXXX */
 	int pad1;			/* Needed for 64 bit alignment */
 	sndrv_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
 	struct timespec tstamp;		/* Timestamp */
-	enum sndrv_pcm_state suspended_state; /* RO: suspended stream state */
+	int suspended_state;		/* RO: suspended stream state */
 };
 
 struct sndrv_pcm_mmap_control {
@@ -519,7 +519,7 @@
 struct sndrv_rawmidi_info {
 	unsigned int device;		/* RO/WR (control): device number */
 	unsigned int subdevice;		/* RO/WR (control): subdevice number */
-	enum sndrv_rawmidi_stream stream; /* WR: stream */
+	int stream;			/* WR: stream */
 	int card;			/* R: card number */
 	unsigned int flags;		/* SNDRV_RAWMIDI_INFO_XXXX */
 	unsigned char id[64];		/* ID (user selectable) */
@@ -531,7 +531,7 @@
 };
 
 struct sndrv_rawmidi_params {
-	enum sndrv_rawmidi_stream stream;
+	int stream;
 	size_t buffer_size;		/* queue size in bytes */
 	size_t avail_min;		/* minimum avail bytes for wakeup */
 	unsigned int no_active_sensing: 1; /* do not send active sensing byte in close() */
@@ -539,7 +539,7 @@
 };
 
 struct sndrv_rawmidi_status {
-	enum sndrv_rawmidi_stream stream;
+	int stream;
 	struct timespec tstamp;		/* Timestamp */
 	size_t avail;			/* available bytes */
 	size_t xruns;			/* count of overruns since last status (in bytes) */
@@ -588,8 +588,8 @@
 #define SNDRV_TIMER_FLG_SLAVE		(1<<0)	/* cannot be controlled */
 
 struct sndrv_timer_id {
-	enum sndrv_timer_class dev_class;	
-	enum sndrv_timer_slave_class dev_sclass;
+	int dev_class;
+	int dev_sclass;
 	int card;
 	int device;
 	int subdevice;
@@ -704,7 +704,7 @@
 };
 
 struct sndrv_timer_tread {
-	enum sndrv_timer_event event;
+	int event;
 	struct timespec tstamp;
 	unsigned int val;
 };
@@ -774,7 +774,7 @@
 
 struct sndrv_ctl_elem_id {
 	unsigned int numid;		/* numeric identifier, zero = invalid */
-	enum sndrv_ctl_elem_iface iface; /* interface identifier */
+	int iface;			/* interface identifier */
 	unsigned int device;		/* device/client number */
 	unsigned int subdevice;		/* subdevice (substream) number */
         unsigned char name[44];		/* ASCII name of item */
@@ -792,7 +792,7 @@
 
 struct sndrv_ctl_elem_info {
 	struct sndrv_ctl_elem_id id;	/* W: element ID */
-	enum sndrv_ctl_elem_type type;	/* R: value type - SNDRV_CTL_ELEM_TYPE_* */
+	int type;			/* R: value type - SNDRV_CTL_ELEM_TYPE_* */
 	unsigned int access;		/* R: value access (bitmask) - SNDRV_CTL_ELEM_ACCESS_* */
 	unsigned int count;		/* count of values */
 	pid_t owner;			/* owner's PID of this control */
@@ -887,7 +887,7 @@
 #define SNDRV_CTL_EVENT_MASK_REMOVE	(~0U)	/* element was removed */
 
 struct sndrv_ctl_event {
-	enum sndrv_ctl_event_type type;	/* event type - SNDRV_CTL_EVENT_* */
+	int type;				/* event type - SNDRV_CTL_EVENT_* */
 	union {
 		struct {
 			unsigned int mask;
--- alsa-lib-1.0.11.orig/./include/sound/emu10k1.h	2005-04-02 16:21:59.000000000 +0200
+++ alsa-lib-1.0.11/./include/sound/emu10k1.h	2006-05-10 13:35:40.000000000 +0200
@@ -264,7 +264,7 @@
 
 typedef struct {
 	unsigned int pad;		/* don't use */
-	enum emu10k1_ctl_elem_iface iface;/* interface identifier */
+	int iface;			/* interface identifier */
 	unsigned int device;		/* device/client number */
 	unsigned int subdevice;		/* subdevice (substream) number */
 	unsigned char name[44];		/* ASCII name of item */ 
--- alsa-lib-1.0.11.orig/./src/alisp/alisp_local.h	2003-12-21 19:25:57.000000000 +0100
+++ alsa-lib-1.0.11/./src/alisp/alisp_local.h	2006-05-10 13:36:48.000000000 +0200
@@ -67,18 +67,18 @@
 	} value;
 };
 
-static inline enum alisp_objects alisp_get_type(struct alisp_object *p)
+static inline int alisp_get_type(struct alisp_object *p)
 {
 	return (p->type_refs >> ALISP_TYPE_SHIFT);
 }
 
-static inline void alisp_set_type(struct alisp_object *p, enum alisp_objects type)
+static inline void alisp_set_type(struct alisp_object *p, int type)
 {
 	p->type_refs &= ~ALISP_TYPE_MASK;
 	p->type_refs |= (unsigned int)type << ALISP_TYPE_SHIFT;
 }
 
-static inline int alisp_compare_type(struct alisp_object *p, enum alisp_objects type)
+static inline int alisp_compare_type(struct alisp_object *p, int type)
 {
 	return ((unsigned int)type << ALISP_TYPE_SHIFT) ==
 	       (p->type_refs & ALISP_TYPE_MASK);
--- alsa-lib-1.0.11.orig/./src/pcm/pcm_local.h	2006-04-06 18:38:47.000000000 +0200
+++ alsa-lib-1.0.11/./src/pcm/pcm_local.h	2006-05-10 13:41:28.000000000 +0200
@@ -106,12 +106,18 @@
 	void (*changed)(snd_pcm_t *pcm, snd_pcm_t *src);
 } snd_pcm_rbptr_t;
 
+enum _snd_pcm_channel_info_type {
+	SND_PCM_AREA_SHM,
+	SND_PCM_AREA_MMAP,
+	SND_PCM_AREA_LOCAL
+};
+
 typedef struct _snd_pcm_channel_info {
 	unsigned int channel;
 	void *addr;			/* base address of channel samples */
 	unsigned int first;		/* offset to first sample in bits */
 	unsigned int step;		/* samples distance in bits */
-	enum { SND_PCM_AREA_SHM, SND_PCM_AREA_MMAP, SND_PCM_AREA_LOCAL } type;
+	int type;
 	union {
 		struct {
 			struct snd_shm_area *area;
--- alsa-lib-1.0.11.orig/./src/conf.c	2006-02-27 10:58:32.000000000 +0100
+++ alsa-lib-1.0.11/./src/conf.c	2006-05-10 13:38:01.000000000 +0200
@@ -1076,13 +1076,20 @@
 	return 0;
 }
 
+enum parse_def_mode {
+	MERGE_CREATE,
+	MERGE,
+	OVERRIDE,
+	DONT_OVERRIDE,
+};
+
 static int parse_def(snd_config_t *father, input_t *input, int skip, int override)
 {
 	char *id = NULL;
 	int c;
 	int err;
 	snd_config_t *n;
-	enum {MERGE_CREATE, MERGE, OVERRIDE, DONT_OVERRIDE} mode;
+	int mode;
 	while (1) {
 		c = get_nonwhite(input);
 		if (c < 0)
--- alsa-lib-1.0.11.orig/./src/pcm/pcm_hw.c	2006-04-06 18:57:51.000000000 +0200
+++ alsa-lib-1.0.11/./src/pcm/pcm_hw.c	2006-05-10 13:40:29.000000000 +0200
@@ -112,7 +112,7 @@
 	do { if (hw->shadow_appl_ptr && !hw->avail_update_flag) \
 	       hw->appl_ptr = hw->mmap_control->appl_ptr; } while (0)
 #define FAST_PCM_STATE(hw) \
-	((enum sndrv_pcm_state) (hw)->mmap_status->state)
+	((int) (hw)->mmap_status->state)
 #define FAST_PCM_TSTAMP(hw) \
 	((hw)->mmap_status->tstamp)
 
--- alsa-lib-1.0.11.orig/./src/pcm/pcm_plug.c	2006-04-06 18:38:47.000000000 +0200
+++ alsa-lib-1.0.11/./src/pcm/pcm_plug.c	2006-05-10 13:42:16.000000000 +0200
@@ -51,7 +51,7 @@
 	int schannels;
 	int srate;
 	const char *rate_converter;
-	enum snd_pcm_plug_route_policy route_policy;
+	int route_policy;
 	snd_pcm_route_ttable_entry_t *ttable;
 	int ttable_ok, ttable_last;
 	unsigned int tt_ssize, tt_cused, tt_sused;
@@ -408,7 +408,7 @@
 	} else {
 		unsigned int k;
 		unsigned int c = 0, s = 0;
-		enum snd_pcm_plug_route_policy rpolicy = plug->route_policy;
+		int rpolicy = plug->route_policy;
 		int n;
 		for (k = 0; k < tt_cused * tt_sused; ++k)
 			ttable[k] = 0;
@@ -1016,7 +1016,7 @@
 		      const char *name,
 		      snd_pcm_format_t sformat, int schannels, int srate,
 		      const char *rate_converter,
-		      enum snd_pcm_plug_route_policy route_policy,
+		      int route_policy,
 		      snd_pcm_route_ttable_entry_t *ttable,
 		      unsigned int tt_ssize,
 		      unsigned int tt_cused, unsigned int tt_sused,
@@ -1127,7 +1127,7 @@
 	snd_pcm_t *spcm;
 	snd_config_t *slave = NULL, *sconf;
 	snd_config_t *tt = NULL;
-	enum snd_pcm_plug_route_policy route_policy = PLUG_ROUTE_POLICY_DEFAULT;
+	int route_policy = PLUG_ROUTE_POLICY_DEFAULT;
 	snd_pcm_route_ttable_entry_t *ttable = NULL;
 	unsigned int csize, ssize;
 	unsigned int cused, sused;

--------------030901030805030900000309--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
