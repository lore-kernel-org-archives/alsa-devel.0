From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: [RFC] set up an sync channel between audio and display
 driver (i.e. ALSA and DRM)
Date: Tue, 20 May 2014 02:52:19 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B447059@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DCDA26167D
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 05:48:20 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Vetter, Daniel" <daniel.vetter@intel.com>, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc: "Yang, Libin" <libin.yang@intel.com>, "Nikkanen,
 Kimmo" <kimmo.nikkanen@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Deak,
 Imre" <imre.deak@intel.com>, "Babu, Ramesh" <ramesh.babu@intel.com>, "Li,
 Jocelyn" <jocelyn.li@intel.com>, "Shankar,
 Uma" <uma.shankar@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

This RFC is based on previous discussion to set up a generic communication channel between display and audio driver and
an internal design of Intel MCG/VPG HDMI audio driver. It's still an initial draft and your advice would be appreciated
to improve the design.

The basic idea is to create a new avsink module and let both drm and alsa depend on it.
This new module provides a framework and APIs for synchronization between the display and audio driver.

1. Display/Audio Client

The avsink core provides APIs to create, register and lookup a display/audio client.
A specific display driver (eg. i915) or audio driver (eg. HD-Audio driver) can create a client, add some resources
objects (shared power wells, display outputs, and audio inputs, register ops) to the client, and then register this
client to avisink core. The peer driver can look up a registered client by a name or type, or both. If a client gives
a valid peer client name on registration, avsink core will bind the two clients as peer for each other. And we
expect a display client and an audio client to be peers for each other in a system.

int avsink_new_client ( const char *name,
                            int type,   /* client type, display or audio */
                            struct module *module,
                            void *context,
                            const char *peer_name,
                            struct avsink_client **client_ret);

int avsink_free_client (struct avsink_client *client);

int avsink_register_client(struct avsink_client *client);
int avisink_unregister_client(int client_handle);

struct avsink_client *avsink_lookup_client(const char *name, int type);

struct avsink_client {
         const char *name;  /* client name */
         int type; /* client type*/
         void *context;
         struct module *module;  /* top-level module for locking */

         struct avsink_client *peer;      /* peer client */

         /* shared power wells */
         struct avsink_power_well *power_well;
         int num_power_wells;

         /* endpoints, display outputs or audio inputs */
         struct avsink_endpoint * endpoint;
         int num_endpints;

         struct avsink_registers_ops *reg_ops; /* ops to access registers of a client */
         void *private_data;
         ...
};

On system boots, the avsink module is loaded before the display and audio driver module. And the display and audio
driver may be loaded on parallel.
* If a specific display driver (eg. i915) supports avsink, it can create a display client, add power wells and display
  outputs to the client, and then register the display client to the avsink core. Then it may look up if there is any
  audio client registered, by name or type, and may find an audio client registered by some audio driver.

* If an audio driver supports avsink, it usually should look up a registered display client by name or type at first,
  because it may need the shared power well in GPU and check the display outputs' name to bind the audio inputs. If
  the display client is not registered yet, the audio driver can choose to wait (maybe in a work queue) or return
  -EAGAIN for a deferred probe. After the display client is found, the audio driver can register an audio client with
  the display client's name as the peer name, the avsink core will bind the display and audio clients to each other.

Open question:
If the display or audio driver is disabled by the black list, shall we introduce a time out to avoid waiting for the
other client registered endlessly?

2. Shared power wells (optional)

The audio and display devices, maybe only part of them, may share a common power well (e.g. for Intel Haswell and
Broadwell). If so, the driver that controls the power well should define a power well object, implement the get/put ops,
and add it to its avsink client before registering the client to avsink core. Then the peer client can look up this
power well by its name, and get/put this power well as a user.

A client can have multiple power well objects.

struct avsink_power_well {
         const char *name; /* name of the power well */
         void *context;   /* parameter of get/put ops, maybe device pointer for this power well */
         struct avsink_power_well_ops *ops
};

struct avsink_power_well_ops {
         int (*get)(void *context);
         int (*put)(void *context);
};

API:
int avsink_new_power(struct avsink_client *client,
                   const char *power_name,
                   void * power_context,
                   struct avsink_power_well_ops *ops,
                   struct avsink_power_well **power_ret);

struct avsink_power_well *avisnk_lookup_power(const char *name);

int avsink_get_power(struct avsink_power_well *power);  /* Reqesut the power */
int avsink_put_power(struct avsink_power_well *power);    /* Release the power */

For example, the i915 display driver can create a device for the shared power well in Haswell GPU, implement its PM
functions, and use the device pointer as the context when creating the power well object, like below

struct avsink_power_well_ops i915_power_well_ops = {
         .get = pm_runtime_get_sync;
         .put = pm_runtime_put_sync;
};
...
avsink_new_power ( display_client,
                   "i915_display_power_well",
                   pdev,  /* pointer of the power well device */
                   &i915_power_well_ops,
                   ...)

Power domain is not used here since a single device seems enough to represent a power well.

3. Display output and audio input endpoints

A display client should register the display output endpoints and its audio peer client should register the audio input
endpoints. A client can have multiple endpoints. The avsink core will bind an audio input and a display output as peer
to each other. This is to allow the audio and display driver to synchronize with each other for each display pipeline.

All endpoints should be added to a client before the client is registered to avsink core. Dynamic endpoints are not
supported now.

A display out here represents a physical HDMI/DP output port. And as long as it's usable in the system (i.e. physically
connected to the HDMP/DP port on the machine board), the display output should be registered not matter the port is
connected to an external display device or not. And if HW and display driver can support DP1.2 daisy chain (multiple DP
display devices can be connected to a single port), multiple static displays outputs should be defined for the DP port
according to the HW capability. The port & display device number can be indicated by the name (e.g. "i915_DDI_B",
"i915_DDI_B_DEV0", "i915_DDI_B_DEV1", or "i915_DDI_B_DEV2"), defined by the display driver.

The audio driver can check the endpoints of its peer display client and use an display endpoint's name, or a presumed
display endpoint name, as peer name when registering an audio endpoint, thus the avsink core will bind the two display
and audio endpoints as peers.

struct avsink_endpoint {
         const char *name;  /*name of the endpoint */
         int type;            /* DISPLAY_OUTPUT or AUDIO_INPUT */
         void *context;           /* private data, used as parameter of the ops */
         struct avsink_endpoint_ops *ops;

         struct avsink_endpoint *peer; /* peer endpoint */
};

struct avsink_endpoint_ops {
         int (*get_caps) (enum had_caps_list query_element,
                            void *capabilities,
                            void *context);
         int (*set_caps) (enum had_caps_list set_element,
                            void *capabilities,
                            void *context);
         int (*event_handler) (enum avsink_event_type event_type, void *context);
};

API:
int avsink_new_endpoint (struct avsink_client *client,
                            const char *name,
                            int type, /* DISPLAY_OUTPUT or AUDIO_INPUT*/
                            void *context,
                            const char *peer_name, /* can be NULL if no clue */
                            avsink_endpoint_ops *ops,
                            struct avsink_endpoint **endpoint_ret);

int avsink_endpoint_get_caps(struct avsink_endpoint *endpoint,
                            enum avsink_caps_list t get_element,
                            void *capabilities);
int avsink_endpoint_set_caps(struct avsink_endpoint *endpoint,
                            enum had_caps_list set_element,
                            void *capabilities);

int avsink_endpoint_post_event(struct avsink_endpoint *endpoint,
                            enum avsink_event_type event_type);

4. Get/Set caps on an endpoint

The display or audio driver can get or set capabilities on an endpoint. Depending on the capability ID, the avsink core
will call get_caps/set_caps ops of this endpoint, or call get_caps/set_caps ops of its peer endpoint and return the
result to the caller.

enum avsink_caps_list {
         /* capabilities for display output endpoints */
         AVSINK_GET_DISPLAY_ELD = 1,
         AVSINK_GET_DISPLAY_TYPE, /* HDMI or DisplayPort */
         AVSINK_GET_DISPLAY_NAME, /* Hope to use display device name under /sys/class/drm, like "card0-DP-1", for user
                                     * space to figure out which HDMI/DP output on the drm side corresponds to which audio
                                       * stream device on the alsa side */
         AVSINK_GET_DISPLAY_SAMPLING_FREQ,      /* HDMI TMDS clock or DP link symbol clock, for audio driver to
                                                         * program N value
                                                        */
         AVSINK_GET_DISPLAY_HDCP_STATUS,
         AVSINK_GET_DISPLAY_AUDIO_STATUS, /* Whether audio is enabled */
         AVSINK_SET_DISPLAY_ENABLE_AUDIO, /* Enable audio */
         AVSINK_SET_DISPLAY_DISABLE_AUDIO,         /* Disable audio */
         AVSINK_SET_DISPLAY_ENABLE_AUDIO_INT, /* Enable audio interrupt */
         AVSINK_SET_DISPLAY_DISABLE_AUDIO_INT,         /* Disable audio interrupt */

         /* capabilities for audio input endpoints */
         AVSINK_GET_AUDIO_IS_BUSY,  /* Whether there is an active audio streaming */
         OTHERS_TBD,
};

For example, the audio driver can query ELD info on an audio input endpoint by using caps AVSINK_GET_DISPLAY_ELD, and
avsink core will call get_caps() on the peer display output endpoint and return the ELD info to the audio driver.

Some audio driver may only use part of these caps. E.g. HD-Audio driver can use bus commands instead of the ops to
control the audio on gfx side, so it doesn't use caps like ENABLE/DISABLE_AUDIO or ENABLE/DISABLE_AUDIO.

When the display driver want to disable a display pipeline for hot-plug, mode change or power saving, it can use caps
AVSINK_GET_AUDIO_IS_BUSY to check if the audio input is busy (active streaming) on this display pipeline. And if audio
is busy, the display driver can choose to wait or go ahead to disable display pipeline anyway. For the latter case, the
audio input endpoint will be notified by an event and should abort audio streaming.

5. Event handling of endpoints

A driver can post events on an endpoint. Depending on the event type, the avsink core will call the endpoint's event
handler or pass the event to its peer endpoint and trigger the peer's event handler function if defined.

int avsink_endpoint_post_event(struct avsink_endpoint *endpoint,
                                     enum avsink_event_type event_type);

Now we only defined event types which should be handled by the audio input endpoints. The event types can be extended
in the future.

enum avsink_event_type {
        AVSINK_EVENT_DISPLAY_DISABLE = 1,  /* The display pipeline is disabled for hot-plug, mode change or
                                                         * suspend. Audio driver should stop any active streaming.
                                                        */
        AVSINK_EVENT_DISPLAY_ENABLE,                   /* The display pipeline is enabled after hot-plug, mode change or
                                                         * resume. Audio driver can restore previously interrupted streaming
                                                         */
        AVSINK_EVENT_DISPLAY_MODE_CHANGE,   /* Display mode change event. At this time, the new display mode is
                                                         * configured but the display pipeline is not enabled yet. Audio driver
                                                        * can do some configurations such as programing N value */
        AVSINK_EVENT_DISPLAY_AUDIO_BUFFER_DONE,         /* Audio Buffer done interrupts. Only for audio drivers if DMA and
                                                         * interrupt are handled by GPU
                                                        */
        AVSINK_EVENT_DISPLAY_AUDIO_BUFFER_UNDERRUN,       /* Audio Buffer under run interrupts. Only for audio drivers if
                                                                  * DMA and interrupt are handled by GPU
                                                                 */
};

So for a display driver, it can post an event on a display output endpoint and get processed by the peer audio input
endpoint. Or it can also directly post an event on a peer audio input endpoint, by using the 'peer' pointer on a
display output endpoint.

6. Display register operation (optional)

Some audio driver needs to access GPU audio registers. The register ops are provided by the peer display client.

struct avsink_registers_ops {
         int (*read_register) (uint32_t reg_addr, uint32_t *data, void *context);
         int (*write_register) (uint32_t reg_addr, uint32_t data, void *context);
         int (*read_modify_register) (uint32_t reg_addr, uint32_t data, uint32_t mask, void *context);

int avsink_define_reg_ops (struct avsink_client *client, struct avsink_registers_ops *ops);

And avsink core provides API for the audio driver to access the display registers:

int avsink_read_display_register(struct avsink_client *client , uint32_t offset, uint32_t *data);
int avsink_write_display_register(struct avsink_client *client , uint32_t offset, uint32_t data);
int avsink_read_modify_display_register(struct avsink_client *client, uint32_t offset, uint32_t data, uint32_t mask);

If the client is an audio client, the avsink core will find it peer display client and call its register ops;
and if the client is a display client, the avsink core will just call its own register ops.

Thanks
Mengdong
