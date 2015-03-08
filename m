From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 0/5] Create hdalib for common hda code
Date: Sun, 8 Mar 2015 22:25:36 +0530
Message-ID: <20150308165536.GQ2613@intel.com>
References: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
 <s5ha8znzdwj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D4F432604BA
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 17:59:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5ha8znzdwj.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 08, 2015 at 04:50:52PM +0100, Takashi Iwai wrote:
> At Sun,  8 Mar 2015 20:07:54 +0530,
> Vinod Koul wrote:
> > 
> > This patch series attempts to split existing HDA code to create common hda
> > library. This is done in order to make HDA code available to other users like
> > upcoming Intel platforms which sport a HDA controller along with an I2S
> > link.  This series is 1st patch series which will try to refactor HDA by
> > splitting it up and then adding ASoC HDA controller driver for these
> > platforms.
> > 
> > This series moves code to sound/hda, renames the files mostly. The second
> > series will do API changes and subsequent ones will be using HDA bus patches
> > which Takashi posted recently
> > 
> > Comments welcome...
> 
> I have a working tree that already contains some HD-audio core stuff
> changes (I think I formed it in private mail threads), too.  They are
> found in topic/hda-core branch.  This will be rather picking up only
> the necessary pieces into sound/hda core directory instead of copying
> the whole fat ones, targeted to build up a minimalistic HD-audio codec
> driver.  So, it's a bit different strategy.  You can find the header
> file (include/sound/hdaudio.h) below and understand what I meant.
> (BTW, it contains the regmap support, found in topic/hda-regmap
> branch.)
I don't mind using this statergy if you recommend that :)

In that case let me post incremental patches moving code on top of
topic/hda-core picking changes one by one.

> 
> I don't mind to abandon my patches, but before that, we should define
> the global goal and discuss how to achieve in a better form.
>From our side the goal is to split the current HDA code and move the common
bits into sound/hda/ That way both existing code and new ASoC HDA code can
use the existing interfaces. We didn't do much changes on existing HDA since
we were concerned about possible regressions on existing HDA, but I think
you want to improve HDA, so we can do both bits togther... :)

-- 
~Vinod

> 
> 
> thanks,
> 
> Takashi
> 
> ===
> 
> /*
>  * HD-audio core stuff
>  */
> 
> #ifndef __SOUND_HDAUDIO_H
> #define __SOUND_HDAUDIO_H
> 
> #include <linux/device.h>
> #include <sound/hda_verbs.h>
> 
> /* codec node id */
> typedef u16 hda_nid_t;
> 
> struct hdac_bus;
> struct hdac_device;
> struct hdac_driver;
> struct hdac_widget_tree;
> 
> /*
>  * exported bus type
>  */
> extern struct bus_type snd_hda_bus_type;
> 
> /*
>  * generic arrays
>  */
> struct snd_array {
> 	unsigned int used;
> 	unsigned int alloced;
> 	unsigned int elem_size;
> 	unsigned int alloc_align;
> 	void *list;
> };
> 
> /*
>  * HD-audio codec base device
>  */
> struct hdac_device {
> 	struct device dev;
> 	int type;
> 	struct hdac_bus *bus;
> 	unsigned int addr;		/* codec address */
> 	struct list_head list;		/* list point for bus codec_list */
> 
> 	hda_nid_t afg;			/* AFG node id */
> 	hda_nid_t mfg;			/* MFG node id */
> 
> 	/* ids */
> 	unsigned int vendor_id;
> 	unsigned int subsystem_id;
> 	unsigned int revision_id;
> 	unsigned int afg_function_id;
> 	unsigned int mfg_function_id;
> 	unsigned int afg_unsol:1;
> 	unsigned int mfg_unsol:1;
> 
> 	unsigned int power_caps;	/* FG power caps */
> 
> 	const char *vendor_name;	/* codec vendor name */
> 	const char *chip_name;		/* codec chip name */
> 
> 	/* verb exec op override */
> 	int (*exec_verb)(struct hdac_device *dev, unsigned int cmd,
> 			 unsigned int flags, unsigned int *res);
> 
> 	/* widgets */
> 	unsigned int num_nodes;
> 	hda_nid_t start_nid, end_nid;
> 
> 	/* misc flags */
> 	atomic_t in_pm;		/* suspend/resume being performed */
> 
> 	/* sysfs */
> 	struct hdac_widget_tree *widgets;
> 
> 	/* regmap */
> 	struct regmap *regmap;
> 	struct snd_array vendor_verbs;
> 	bool lazy_cache:1;	/* don't wake up for writes */
> 	bool caps_overwriting:1; /* caps overwrite being in process */
> };
> 
> /* device/driver type used for matching */
> enum {
> 	HDA_DEV_CORE,
> 	HDA_DEV_LEGACY,
> };
> 
> /* direction */
> enum {
> 	HDA_INPUT, HDA_OUTPUT
> };
> 
> #define dev_to_hdac_dev(_dev)	container_of(_dev, struct hdac_device, dev)
> 
> int snd_hdac_device_init(struct hdac_device *dev, struct hdac_bus *bus,
> 			 const char *name, unsigned int addr);
> void snd_hdac_device_exit(struct hdac_device *dev);
> int snd_hdac_device_register(struct hdac_device *codec);
> void snd_hdac_device_unregister(struct hdac_device *codec);
> 
> int snd_hdac_refresh_widgets(struct hdac_device *codec);
> 
> unsigned int snd_hdac_make_cmd(struct hdac_device *codec, hda_nid_t nid,
> 			       unsigned int verb, unsigned int parm);
> int snd_hdac_exec_verb(struct hdac_device *codec, unsigned int cmd,
> 		       unsigned int flags, unsigned int *res);
> int snd_hdac_read(struct hdac_device *codec, hda_nid_t nid,
> 		  unsigned int verb, unsigned int parm, unsigned int *res);
> int _snd_hdac_read_parm(struct hdac_device *codec, hda_nid_t nid, int parm,
> 			unsigned int *res);
> int snd_hdac_read_parm_uncached(struct hdac_device *codec, hda_nid_t nid,
> 				int parm);
> int snd_hdac_override_parm(struct hdac_device *codec, hda_nid_t nid,
> 			   unsigned int parm, unsigned int val);
> int snd_hdac_get_connections(struct hdac_device *codec, hda_nid_t nid,
> 			     hda_nid_t *conn_list, int max_conns);
> int snd_hdac_get_sub_nodes(struct hdac_device *codec, hda_nid_t nid,
> 			   hda_nid_t *start_id);
> 
> /**
>  * snd_hdac_read_parm - read a codec parameter
>  * @codec: the codec object
>  * @nid: NID to read a parameter
>  * @parm: parameter to read
>  *
>  * Returns -1 for error.  If you need to distinguish the error more
>  * strictly, use _snd_hdac_read_parm() directly.
>  */
> static inline int snd_hdac_read_parm(struct hdac_device *codec, hda_nid_t nid,
> 				     int parm)
> {
> 	unsigned int val;
> 
> 	return _snd_hdac_read_parm(codec, nid, parm, &val) < 0 ? -1 : val;
> }
> 
> #ifdef CONFIG_PM
> void snd_hdac_power_up(struct hdac_device *codec);
> void snd_hdac_power_down(struct hdac_device *codec);
> #else
> static inline void snd_hdac_power_up(struct hdac_device *codec) {}
> static inline void snd_hdac_power_down(struct hdac_device *codec) {}
> #endif
> 
> /*
>  * HD-audio codec base driver
>  */
> struct hdac_driver {
> 	struct device_driver driver;
> 	int type;
> 	int (*match)(struct hdac_device *dev, struct hdac_driver *drv);
> 	void (*unsol_event)(struct hdac_device *dev, unsigned int event);
> };
> 
> #define drv_to_hdac_driver(_drv) container_of(_drv, struct hdac_driver, driver)
> 
> /*
>  * HD-audio bus base driver
>  */
> struct hdac_bus_ops {
> 	/* send a single command */
> 	int (*command)(struct hdac_bus *bus, unsigned int cmd);
> 	/* get a response from the last command */
> 	int (*get_response)(struct hdac_bus *bus, unsigned int addr,
> 			    unsigned int *res);
> };
> 
> #define HDA_UNSOL_QUEUE_SIZE	64
> 
> struct hdac_bus {
> 	struct device *dev;
> 	const struct hdac_bus_ops *ops;
> 
> 	/* codec linked list */
> 	struct list_head codec_list;
> 	unsigned int num_codecs;
> 
> 	/* link caddr -> codec */
> 	struct hdac_device *caddr_tbl[HDA_MAX_CODEC_ADDRESS + 1];
> 
> 	/* unsolicited event queue */
> 	u32 unsol_queue[HDA_UNSOL_QUEUE_SIZE * 2]; /* ring buffer */
> 	unsigned int unsol_rp, unsol_wp;
> 	struct work_struct unsol_work;
> 
> 	/* bit flags of powered codecs */
> 	unsigned long codec_powered;
> 
> 	/* flags */
> 	bool sync_write:1;		/* sync after verb write */
> 
> 	/* locks */
> 	struct mutex cmd_mutex;
> };
> 
> int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
> 		      const struct hdac_bus_ops *ops);
> void snd_hdac_bus_exit(struct hdac_bus *bus);
> int snd_hdac_bus_exec_verb(struct hdac_bus *bus, unsigned int addr,
> 			   unsigned int cmd, unsigned int *res);
> int snd_hdac_bus_exec_verb_unlocked(struct hdac_bus *bus, unsigned int addr,
> 				    unsigned int cmd, unsigned int *res);
> void snd_hdac_bus_queue_event(struct hdac_bus *bus, u32 res, u32 res_ex);
> 
> int snd_hdac_bus_add_device(struct hdac_bus *bus, struct hdac_device *codec);
> void snd_hdac_bus_remove_device(struct hdac_bus *bus,
> 				struct hdac_device *codec);
> 
> static inline void snd_hdac_codec_link_up(struct hdac_device *codec)
> {
> 	set_bit(codec->addr, &codec->bus->codec_powered);
> }
> 
> static inline void snd_hdac_codec_link_down(struct hdac_device *codec)
> {
> 	clear_bit(codec->addr, &codec->bus->codec_powered);
> }
> 
> /*
>  * generic array helpers
>  */
> void *snd_array_new(struct snd_array *array);
> void snd_array_free(struct snd_array *array);
> static inline void snd_array_init(struct snd_array *array, unsigned int size,
> 				  unsigned int align)
> {
> 	array->elem_size = size;
> 	array->alloc_align = align;
> }
> 
> static inline void *snd_array_elem(struct snd_array *array, unsigned int idx)
> {
> 	return array->list + idx * array->elem_size;
> }
> 
> static inline unsigned int snd_array_index(struct snd_array *array, void *ptr)
> {
> 	return (unsigned long)(ptr - array->list) / array->elem_size;
> }
> 
> #endif /* __SOUND_HDAUDIO_H */

-- 
