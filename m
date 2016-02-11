From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] conf: topology: Add topolgy for skylake
	i2s configuration
Date: Thu, 11 Feb 2016 22:56:03 +0900
Message-ID: <56BC92F3.5070007@sakamocchi.jp>
References: <1454903756-2075-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5ha8naxhge.wl-tiwai@suse.de> <20160209114749.GA7243@subhransu-desktop>
 <s5h1t8mxfnk.wl-tiwai@suse.de> <20160209131415.GA26322@subhransu-desktop>
 <s5hpow6vx6l.wl-tiwai@suse.de> <20160209133432.GN19598@localhost>
 <s5hh9hivvt7.wl-tiwai@suse.de> <20160211035258.GU19598@localhost>
 <s5hio1viqu8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 95C3A260A5D
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2016 14:56:11 +0100 (CET)
In-Reply-To: <s5hio1viqu8.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 11 2016 17:38, Takashi Iwai wrote:
> On Thu, 11 Feb 2016 04:52:58 +0100,
> Vinod Koul wrote:
>>
>> On Tue, Feb 09, 2016 at 02:48:36PM +0100, Takashi Iwai wrote:
>>>>> Well, the question is whether this IP is a programmed data block, not
>>>>> some simple numbers.  If yes, it's always a question whether it's
>>>>> compatible with GPL.  Although alsa-lib is LGPL, putting the binary
>>>>> blob in the *code tree* doesn't look good to me.
>>>>
>>>> Hi Takashi,
>>>>
>>>> This is simple numbers only. Numbers which identify the data for firmware,
>>>> its resources, ids, pipe number, module number and for controls default
>>>> values etc. Basically this struct
>>>>
>>>> struct skl_dfw_module {
>>>>         char uuid[SKL_UUID_STR_SZ];
>>>>
>>>>         u16 module_id;
>>>>         u16 instance_id;
>>>>         u32 max_mcps;
>>>>         u32 mem_pages;
>>>>         u32 obs;
>>>>         u32 ibs;
>>>>         u32 vbus_id;
>>>>
>>>>         u32 max_in_queue:8;
>>>>         u32 max_out_queue:8;
>>>>         u32 time_slot:8;
>>>>         u32 core_id:4;
>>>>         u32 rsvd1:4;
>>>>
>>>>         u32 module_type:8;
>>>>         u32 conn_type:4;
>>>>         u32 dev_type:4;
>>>>         u32 hw_conn_type:4;
>>>>         u32 rsvd2:12;
>>>>
>>>>         u32 params_fixup:8;
>>>>         u32 converter:8;
>>>>         u32 input_pin_type:1;
>>>>         u32 output_pin_type:1;
>>>>         u32 is_dynamic_in_pin:1;
>>>>         u32 is_dynamic_out_pin:1;
>>>>         u32 is_loadable:1;
>>>>         u32 rsvd3:11;
>>>>
>>>>         struct skl_dfw_pipe pipe;
>>>>         struct skl_dfw_module_fmt in_fmt[MAX_IN_QUEUE];
>>>>         struct skl_dfw_module_fmt out_fmt[MAX_OUT_QUEUE];
>>>>         struct skl_dfw_module_pin in_pin[MAX_IN_QUEUE];
>>>>         struct skl_dfw_module_pin out_pin[MAX_OUT_QUEUE];
>>>>         struct skl_dfw_module_caps caps;
>>>> } __packed;
>>>
>>> OK, but how did you create it?  Via a hex editor?  If you used some
>>> converter, you'd better provide the readable source, too.
>>>
>>>>> IMO, this should go to firmware tree instead, unless you can give the
>>>>> source code to build the binary.
>>>>
>>>> Okay that should be fine, where do we add the source?
>>>
>>> In alsa-lib.  It's not necessarily to be in form as all build-ready
>>> there, but providing the capability is important for future
>>> development.
>>
>> Okay so we will add a intel-topology.c file to alsa-lib, this will also
>> include a file which will contain the above structure values for each module
>> in C style.
>>
>> This way anyone can edit it easily and we can build blobs from alsa lib and
>> then run topology tool on it.
> 
> It's much better, indeed.
> 
>> Do you have recommendation for location of these two files in alsa-lib?
> 
> Just put in the same directory?

Could I ask your opinion about device-dependent codes in common library?

The alsa-lib is designed for generic ALSA applications. So codes in
alsa-lib can be used by the applications. On the other hand, your codes
are not completely common. Even if Intel SoCs are widely used in this
world, I think there's rest of consideration about merging it.

And when you include device-dependent code into such common library, I
think it increases maintenance cost, because no one except you can
understand it. I think it's not so better shape of shared library. In
short, IF Interl corp. lost their interests in ALSA, your codes might
not be mainteined anymore.
(And I can remember some OSS projects got by Intel corp.)

For example, simple mixer API has backend modules for AC97/HDA/python2
and the modules are not currently maintained. Near future, your codes
will join in such bothersome stuffs, won't they?


Well. I'm not so goot at what you achieve with this patch and a series
of your work for TLV extensions of ALSA ctl interface. So could I
request your intension about this patch? At least, I cannot still
understand what your codes works with kernel implementation for features
integrated into skl SoC.


I believe we should take more time to this patch, at least for some
developers who select alternative ways to control devices for which they
currently work.

Of cource, I believe that your work will reach more users than our
effort. We can judge that it's more reasonable to merge your codes into
common library. But to reach the decision, more explainations and
discussions are required.


Regards

Takashi Sakamoto
