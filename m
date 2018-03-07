From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel][PATCH 0/2] sndif: add explicit back
 and front synchronization
Date: Wed, 7 Mar 2018 10:49:24 +0200
Message-ID: <397eb20c-096a-f8d1-1e63-3662d79f14cf@gmail.com>
References: <1517819100-1029-1-git-send-email-andr2000@gmail.com>
 <s5hd10hcw6t.wl-tiwai@suse.de>
 <d460d2f9-8a93-7046-dbe3-fe921c2da130@gmail.com>
 <s5h4lltcud4.wl-tiwai@suse.de>
 <1531a22b-5df6-a66e-72ee-775538aeff4d@gmail.com>
 <s5hwoypbc3c.wl-tiwai@suse.de>
 <e11de1a2-5095-6297-184b-00405300bfe7@gmail.com>
 <s5hpo4hb9hg.wl-tiwai@suse.de>
 <621aaaa9-5994-176c-b243-c2fc9823a699@gmail.com>
 <s5hfu5db7pd.wl-tiwai@suse.de>
 <18f6eced-a932-ad82-0097-e18ac1a562ae@gmail.com>
 <s5ha7vlb5vl.wl-tiwai@suse.de>
 <670e6d78-1dbd-dcc9-fd82-813c2f45c5d3@gmail.com>
 <s5hwoyp9nem.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------E342242EB9E1B5DE96F903FB"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CF732671E9
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 09:49:27 +0100 (CET)
Received: by mail-lf0-f51.google.com with SMTP id 37-v6so2050927lfs.7
 for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2018 00:49:27 -0800 (PST)
In-Reply-To: <s5hwoyp9nem.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------E342242EB9E1B5DE96F903FB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/06/2018 06:30 PM, Takashi Iwai wrote:
> On Tue, 06 Mar 2018 17:04:41 +0100,
> Oleksandr Andrushchenko wrote:
>>>>>> If we decide to negotiate the parameters, then it can't be done
>>>>>> at .open stage as well, as at this moment we don't know stream
>>>>>> parameters yet, e.g. we don't know the number of channels, PCM
>>>>>> format etc., so we cannot explain to the backend what we want.
>>>>>> Thus, it seems that we need to move the negotiation to .hw_params
>>>>>> callback where stream properties are known. But this leaves the
>>>>>> only option to ask the backend if it can handle the requested
>>>>>> buffer/period and other parameters or not... This is what I do now :(
>>>>> The additional parameter setup can be done via hw_constraints.  The hw
>>>>> constraint is basically a function call for each parameter change to
>>>>> narrow down the range of the given parameter.
>>>>>
>>>>> snd_pcm_hw_constraint_integer() in the above is just an example.
>>>>> The actual function to adjust values can be freely written.
>>>> Yes, this is clear, the question here mostly was not
>>>> *how* to set the constraints, but *where* to get those
>>> ... and here comes the hw constraint into the play.
>>>
>>> For each parameter change, for example, the frontend just passes the
>>> inquiry to the backend.  The basis of the hw constraint is nothing but
>>> to reduce the range of the given parameter.  It's either interval
>>> (range, used for period/buffer size or sample rate) or the list (for
>>> the format).  When any parameter is changed, ALSA PCM core invokes the
>>> corresponding hw constraint function, and the function reduces the
>>> range.  It's repeated until all parameters are set and settled down.
>>>
>>> So, for your driver, the frontend just passes the hw constraint for
>>> each of basic 5 parameters to the backend.  For example, at beginning,
>>> the hw constraint for the buffer size will pass the range (1,INTMAX).
>>> Then the backend returns the range like (1024,65536).   This already
>>> gives users the min/max buffer size information.  The similar
>>> procedure will be done for all other parameters.
>>>
>>> In addition, you can put the implicit rule like the integer periods,
>>> which makes things easier.
>>>
>> Thank you very much for such a detailed explanation.
>> Could you please give me an example of ALSA driver which
>> code I can read in order to understand how it is supposed
>> to be used, e.g. which meets the expectations we have for
>> Xen PV sound driver?
> This is the most difficult part, apparently :)
> There are lots of codes deploying the own hw constraints, but nothing
> is similar like your case.
>
> Suppose that we negotiate from the frontend to the backend like
>
> 	int query_hw_param(int parm, int *min_p, int *max_p);
>
> so that you can call like
> 	err = query_hw_param(PARM_RATE, &min_rate, &max_rate);
>
> This assumes that min_rate and max_rate were already filled by the
> values requested from frontend user-space.  In query_hw_parm, the
> backend receives this range, checks it, and fills again the actually
> applicable range that satisfies the given range in return.
>
> In that way, user-space will reduce the configuration space
> repeatedly.  And at the last step, the configurator chooses the
> optimal values that fit in the given configuration space.
>
> As mentioned in the previous post, in your driver at open, you'd need
> to add the hw constraint for each parameter.  That would be like:
>
> 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> 				  hw_rule_rate, NULL, -1);
>
> and hw_rule_rate() would look like:
>
> static int hw_rule_rate(struct snd_pcm_hw_params *params,
> 			struct snd_pcm_hw_rule *rule)
> {
> 	struct snd_interval *p =
> 		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
> 	int min_rate = p->min;
> 	int max_rate = p->max;
> 	struct snd_interval t;
> 	int err;
>
> 	err = query_hw_param(PARM_RATE, &min_rate, &max_rate);
> 	if (err < 0)
> 		return err;
>
> 	t.min = min_rate;
> 	t.max = max_rate;
> 	t.openmin = t.openmax = 0;
> 	t.integer = 1;
>
> 	return snd_interval_refine(p, &t);
> }
>
> The above is simplified not to allow the open min/max and assume only
> integer, which should be enough for your cases, I suppose.
>
> And the above function can be generalized like
>
> static int hw_rule_interval(struct snd_pcm_hw_params *params,
> 			    struct snd_pcm_hw_rule *rule)
> {
> 	struct snd_interval *p =
> 		hw_param_interval(params, rule->var);
> 	int min_val = p->min;
> 	int max_val = p->max;
> 	struct snd_interval t;
> 	int err;
>
> 	err = query_hw_param(alsa_parm_to_xen_parm(rule->var),
> 			&min_val, &max_val);
> 	if (err < 0)
> 		return err;
>
> 	t.min = min_val;
> 	t.max = max_val;
> 	t.openmin = t.openmax = 0;
> 	t.integer = 1;
>
> 	return snd_interval_refine(p, &t);
> }
>
> and registering this via
>
> 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> 				  hw_rule_interval, NULL, -1);
>
> In the above NULL can be referred in the callback via rule->private,
> if you need some closure in the function, too.
Thank you so much for that detailed explanation and code sample!!!
This is really great to see such a comprehensive response.
Meanwhile, I did a yet another change to the protocol (please find
attached) which will be added to those two found in this patch set
already:
In order to provide explicit stream parameter negotiation between
     backend and frontend the following changes are introduced in the 
protocol:
      - add XENSND_OP_HW_PARAM_SET request to set one of the stream
        parameters: frame rate, sample rate, number of channels,
        buffer and period sizes
      - add XENSND_OP_HW_PARAM_QUERY request to read a reduced
        configuration space for the parameter given: in the response
        to this request return min/max interval for the parameter
        given
      - add minimum buffer size to XenStore configuration

With this change:
1. Frontend sends XENSND_OP_HW_PARAM_SET to the backend in response
to user space's snd_pcm_hw_params_set_XXX calls, using XenStore entries
as initial configuration space (this is what returned on 
snd_pcm_hw_params_any)
2. Frontend uses snd_pcm_hw_rule_add to set the rules (for sample rate,
format, number of channels, buffer and period sizes) as you described
above: querying is done with XENSND_OP_HW_PARAM_QUERY request
3. Finally, frontend issues XENSND_OP_OPEN request with all the negotiated
configuration values

Questions:

1. For XENSND_OP_HW_PARAM_SET I will need a hook in the frontend driver
so I can intercept snd_pcm_hw_params_set_XXX calls - is this available 
in ALSA?

2. From backend side, if it runs as ALSA client, it is almost 1:1
mapping for XENSND_OP_HW_PARAM_SET/snd_pcm_hw_params_set_XXX, so I can 
imagine
how to do that. But what do I do if I run the backend as PulseAudio client?

3. Period size rules will not allow the check you mentioned before, e.g.
require that buffer_size % period_size == 0). Can frontend driver assume
that on its own? So, I simply add the rule regardless of what backend can?

4. Do you think the attached change together with the previous one (
which adds sync event) makes the protocol look good? Do we need any 
other change?
>
> Takashi
Thank you very much for helping with this,
Oleksandr

--------------E342242EB9E1B5DE96F903FB
Content-Type: text/x-patch;
 name="0001-sndif-add-explicit-back-and-front-parameter-negotiat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-sndif-add-explicit-back-and-front-parameter-negotiat.pa";
 filename*1="tch"

>From 267fb5f74026b8313a54c47fcecdeb8c644f3257 Mon Sep 17 00:00:00 2001
From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Date: Wed, 7 Mar 2018 10:21:20 +0200
Subject: [PATCH] sndif: add explicit back and front parameter negotiation

In order to provide explicit stream parameter negotiation between
backend and frontend the following changes are introduced in the protocol:
 - add XENSND_OP_HW_PARAM_SET request to set one of the stream
   parameters: frame rate, sample rate, number of channels,
   buffer and period sizes
 - add XENSND_OP_HW_PARAM_QUERY request to read a reduced
   configuration space for the parameter given: in the response
   to this request return min/max interval for the parameter
   given
 - add minimum buffer size to XenStore configuration

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 xen/include/public/io/sndif.h | 127 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 120 insertions(+), 7 deletions(-)

diff --git a/xen/include/public/io/sndif.h b/xen/include/public/io/sndif.h
index e38644423c0a..8036c5c2f212 100644
--- a/xen/include/public/io/sndif.h
+++ b/xen/include/public/io/sndif.h
@@ -250,6 +250,11 @@
  *
  *      The maximum size in octets of the buffer to allocate per stream.
  *
+ * buffer-size-min
+ *      Values:         <uint32_t>
+ *
+ *      The minimum size in octets of the buffer to allocate per stream.
+ *
  *----------------------- Virtual sound card settings -------------------------
  * short-name
  *      Values:         <char[32]>
@@ -465,12 +470,20 @@
 #define XENSND_OP_MUTE                  6
 #define XENSND_OP_UNMUTE                7
 #define XENSND_OP_TRIGGER               8
+#define XENSND_OP_HW_PARAM_SET          9
+#define XENSND_OP_HW_PARAM_QUERY        10
 
 #define XENSND_OP_TRIGGER_START         0
 #define XENSND_OP_TRIGGER_PAUSE         1
 #define XENSND_OP_TRIGGER_STOP          2
 #define XENSND_OP_TRIGGER_RESUME        3
 
+#define XENSND_OP_HW_PARAM_FORMAT       0
+#define XENSND_OP_HW_PARAM_RATE         1
+#define XENSND_OP_HW_PARAM_BUFFER       2
+#define XENSND_OP_HW_PARAM_PERIOD       3
+#define XENSND_OP_HW_PARAM_CHANNELS     4
+
 /*
  ******************************************************************************
  *                                 EVENT CODES
@@ -503,6 +516,7 @@
 #define XENSND_FIELD_SAMPLE_RATES       "sample-rates"
 #define XENSND_FIELD_SAMPLE_FORMATS     "sample-formats"
 #define XENSND_FIELD_BUFFER_SIZE        "buffer-size"
+#define XENSND_FIELD_BUFFER_SIZE_MIN    "buffer-size-min"
 
 /* Stream type field values. */
 #define XENSND_STREAM_TYPE_PLAYBACK     "p"
@@ -828,28 +842,122 @@ struct xensnd_trigger_req {
 };
 
 /*
+ * Request stream configuration parameter selection:
+ *   Sound device configuration for a particular stream is a limited subset
+ *   of the multidimensional configuration available on XenStore, e.g.
+ *   once the frame rate has been selected there is a limited supported range
+ *   for sample rates becomes available (which might be the same set configured
+ *   on XenStore or less). For example, selecting 96kHz sample rate may limit
+ *   number of channels available for such configuration from 4 to 2 etc.
+ *   Thus, each call to XENSND_OP_SET_HW_PARAM will reduce configuration space
+ *   making it possible to iteratively get the final stream configuration,
+ *   used in XENSND_OP_OPEN request.
+ *
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |               id                |_OP_SET_HW_PARAM|    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                               value                               | 12
+ * +----------------+----------------+----------------+----------------+
+ * |      type      |                     reserved                     | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 24
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 28
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 32
+ * +----------------+----------------+----------------+----------------+
+ *
+ * value - uint32_t, requested value of the parameter
+ * type - uint8_t, XENSND_OP_HW_PARAM_XXX value
+ */
+
+struct xensnd_set_hw_param_req {
+    uint32_t value;
+    uint8_t type;
+};
+
+/*
+ * Request stream configuration parameter interval: request interval of
+ *   supported values for the parameter given. See response format for this
+ *   request.
+ *
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |               id                | _HW_PARAM_QUERY|    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |      type      |                     reserved                     | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 24
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 28
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 32
+ * +----------------+----------------+----------------+----------------+
+ *
+ * type - uint8_t, XENSND_OP_HW_PARAM_XXX value
+ */
+
+struct xensnd_query_hw_param_req {
+    uint8_t type;
+};
+
+/*
  *---------------------------------- Responses --------------------------------
  *
  * All response packets have the same length (32 octets)
  *
- * Response for all requests:
+ * All response packets have common header:
  *         0                1                 2               3        octet
  * +----------------+----------------+----------------+----------------+
  * |               id                |    operation   |    reserved    | 4
  * +----------------+----------------+----------------+----------------+
  * |                              status                               | 8
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 12
+ *
+ * id - uint16_t, copied from the request
+ * operation - uint8_t, XENSND_OP_* - copied from request
+ * status - int32_t, response status, zero on success and -XEN_EXX on failure
+ *
+ *
+ * HW parameter query response - response for XENSND_OP_HW_PARAM_QUERY:
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |               id                |    operation   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                              status                               | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                                min                                | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                                max                                | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 20
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
  * |                             reserved                              | 32
  * +----------------+----------------+----------------+----------------+
  *
- * id - uint16_t, copied from the request
- * operation - uint8_t, XENSND_OP_* - copied from request
- * status - int32_t, response status, zero on success and -XEN_EXX on failure
- *
+ * min - uint32_t, minimum value of the parameter that can be used
+ * max - uint32_t, maximum value of the parameter that can be used
+ */
+
+struct xensnd_query_hw_param_resp {
+    uint32_t min;
+    uint32_t max;
+};
+
+/*
  *----------------------------------- Events ----------------------------------
  *
  * Events are sent via a shared page allocated by the front and propagated by
@@ -902,6 +1010,8 @@ struct xensnd_req {
         struct xensnd_open_req open;
         struct xensnd_rw_req rw;
         struct xensnd_trigger_req trigger;
+        struct xensnd_set_hw_param_req set_hw_param;
+        struct xensnd_query_hw_param_req query_hw_param;
         uint8_t reserved[24];
     } op;
 };
@@ -911,7 +1021,10 @@ struct xensnd_resp {
     uint8_t operation;
     uint8_t reserved;
     int32_t status;
-    uint8_t reserved1[24];
+    union {
+        struct xensnd_query_hw_param_resp hw_param;
+        uint8_t reserved1[24];
+    } resp;
 };
 
 struct xensnd_evt {
-- 
2.7.4


--------------E342242EB9E1B5DE96F903FB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------E342242EB9E1B5DE96F903FB--
