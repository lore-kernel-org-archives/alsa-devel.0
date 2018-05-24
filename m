From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Wed, 23 May 2018 22:38:03 -0500
Message-ID: <ed07d060-de54-1a35-25d7-a69c6cf47f7f@linux.intel.com>
References: <20180522165842.233949-1-groeck@google.com>
 <649b1c14-e440-0c89-a59c-dc663344faa3@linux.intel.com>
 <CABXOdTdyWVtbWXR6O3VenwTezVLGvEfKuvH=Xz6e5D3np-ZQNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABXOdTdyWVtbWXR6O3VenwTezVLGvEfKuvH=Xz6e5D3np-ZQNw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <groeck@google.com>
Cc: alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Patel, Chintan M" <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


>>> +static int skl_tplg_get_pvt_data_v4(struct snd_soc_tplg_dapm_widget
> *tplg_w,
>>> +                                 struct skl *skl, struct device *dev,
>>> +                                 struct skl_module_cfg *mconfig)
>>> +{
>>> +     struct skl_dfw_v4_module *dfw =
>>> +                             (struct skl_dfw_v4_module
> *)tplg_w->priv.data;
>>> +     int ret;
>>> +
>>> +     dev_dbg(dev, "Parsing Skylake v4 widget topology data\n");
>>> +
>>> +     ret = guid_parse(dfw->uuid, (guid_t *)mconfig->guid);
>>> +     if (ret)
>>> +             return ret;
>>> +     mconfig->id.module_id = -1;
>>> +     mconfig->id.instance_id = dfw->instance_id;
>>> +     mconfig->module->resources[0].cps = dfw->max_mcps;
>>> +     mconfig->module->resources[0].ibs = dfw->ibs;
>>> +     mconfig->module->resources[0].obs = dfw->obs;
>>> +     mconfig->core_id = dfw->core_id;
>>> +     mconfig->module->max_input_pins = dfw->max_in_queue;
>>> +     mconfig->module->max_output_pins = dfw->max_out_queue;
>>> +     mconfig->module->loadable = dfw->is_loadable;
>>> +     skl_tplg_fill_fmt_v4(mconfig->module->formats[0].inputs,
> dfw->in_fmt,
>>> +                          MAX_IN_QUEUE);
>>> +     skl_tplg_fill_fmt_v4(mconfig->module->formats[0].outputs,
> dfw->out_fmt,
>>> +                          MAX_OUT_QUEUE);
>> Not clear to me if there is a confusion between MAX_IN_QUEUE and
>> MODULE_MAX_IN_PINS. The two values happen to be identical.
> 
> 
> The target (mconfig->module->formats[]) size is MAX_IN_QUEUE. Upstream
> v4.4/v4.5
> use both defines interchangeably as far as I can see.
> 
> sound/soc/intel/skylake/skl-topology.h: struct skl_module_fmt
> in_fmt[MODULE_MAX_IN_PINS];
> sound/soc/intel/skylake/skl-tplg-interface.h:   struct skl_dfw_module_fmt
> in_fmt[MAX_IN_QUEUE];
> 
> I could make it
>                    min(MAX_IN_QUEUE, dfw->max_in_queue)
> Would that be better ?

Looks like your code was fine in the first place.
> 
>>> +
>>> +     mconfig->params_fixup = dfw->params_fixup;
>>> +     mconfig->converter = dfw->converter;
>>> +     mconfig->m_type = dfw->module_type;
>>> +     mconfig->vbus_id = dfw->vbus_id;
>>> +     mconfig->module->resources[0].is_pages = dfw->mem_pages;
>>> +
>>> +     ret = skl_tplg_add_pipe_v4(dev, mconfig, skl, &dfw->pipe);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     mconfig->dev_type = dfw->dev_type;
>>> +     mconfig->hw_conn_type = dfw->hw_conn_type;
>>> +     mconfig->time_slot = dfw->time_slot;
>>> +     mconfig->formats_config.caps_size = dfw->caps.caps_size;
> 
>> chromeos-3.18 has this:
>>        if (dfw_config->is_loadable)
>>            memcpy(mconfig->guid, dfw_config->uuid,
>>                        ARRAY_SIZE(dfw_config->uuid));
> 
>> Is this needed here?
> 
> 
> Direct memcpy doesn't work anymore since the uuid format is different. The
> above is replaced
> with (unconditional)
> 
>           ret = guid_parse(dfw->uuid, (guid_t *)mconfig->guid);
>           if (ret)
>                   return ret;
> 
> at the beginning of skl_tplg_get_pvt_data_v4(). The new code, as far as I
> can see, loads
> the uuid unconditionally if it finds SND_SOC_TPLG_TUPLE_TYPE_UUID. I wanted
> to
> be on the safe side and decided to do the same.

ok.
