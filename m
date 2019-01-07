From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: Intel: Skylake: Switch to modern
	UUID API
Date: Mon, 7 Jan 2019 17:55:56 +0200
Message-ID: <20190107155556.GR9170@smile.fi.intel.com>
References: <20180716095240.7399-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A0128266875
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 16:56:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180716095240.7399-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Christoph Hellwig <hch@lst.de>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 16, 2018 at 12:52:40PM +0300, Andy Shevchenko wrote:
> Switch the driver to use modern UUID API, i.e. guid_t type and
> accompanying functions, such as guid_equal().
> 

Any comments on this?

> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/intel/skylake/skl-pcm.c       | 12 ++++++------
>  sound/soc/intel/skylake/skl-sst-dsp.h   |  6 +++---
>  sound/soc/intel/skylake/skl-sst-utils.c | 23 +++++++----------------
>  sound/soc/intel/skylake/skl-sst.c       |  4 ++--
>  sound/soc/intel/skylake/skl-topology.c  | 24 ++++++++++++------------
>  sound/soc/intel/skylake/skl-topology.h  |  6 +++---
>  6 files changed, 33 insertions(+), 42 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
> index 823e39103edd..86f8ebc77a32 100644
> --- a/sound/soc/intel/skylake/skl-pcm.c
> +++ b/sound/soc/intel/skylake/skl-pcm.c
> @@ -1268,12 +1268,12 @@ static int skl_get_module_info(struct skl *skl, struct skl_module_cfg *mconfig)
>  {
>  	struct skl_sst *ctx = skl->skl_sst;
>  	struct skl_module_inst_id *pin_id;
> -	uuid_le *uuid_mod, *uuid_tplg;
> +	guid_t *uuid_mod, *uuid_tplg;
>  	struct skl_module *skl_module;
>  	struct uuid_module *module;
>  	int i, ret = -EIO;
>  
> -	uuid_mod = (uuid_le *)mconfig->guid;
> +	uuid_mod = (guid_t *)mconfig->guid;
>  
>  	if (list_empty(&ctx->uuid_list)) {
>  		dev_err(ctx->dev, "Module list is empty\n");
> @@ -1281,7 +1281,7 @@ static int skl_get_module_info(struct skl *skl, struct skl_module_cfg *mconfig)
>  	}
>  
>  	list_for_each_entry(module, &ctx->uuid_list, list) {
> -		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
> +		if (guid_equal(uuid_mod, &module->uuid)) {
>  			mconfig->id.module_id = module->id;
>  			if (mconfig->module)
>  				mconfig->module->loadable = module->is_loadable;
> @@ -1298,7 +1298,7 @@ static int skl_get_module_info(struct skl *skl, struct skl_module_cfg *mconfig)
>  	for (i = 0; i < skl->nr_modules; i++) {
>  		skl_module = skl->modules[i];
>  		uuid_tplg = &skl_module->uuid;
> -		if (!uuid_le_cmp(*uuid_mod, *uuid_tplg)) {
> +		if (guid_equal(uuid_mod, uuid_tplg)) {
>  			mconfig->module = skl_module;
>  			ret = 0;
>  			break;
> @@ -1310,13 +1310,13 @@ static int skl_get_module_info(struct skl *skl, struct skl_module_cfg *mconfig)
>  	list_for_each_entry(module, &ctx->uuid_list, list) {
>  		for (i = 0; i < MAX_IN_QUEUE; i++) {
>  			pin_id = &mconfig->m_in_pin[i].id;
> -			if (!uuid_le_cmp(pin_id->mod_uuid, module->uuid))
> +			if (guid_equal(&pin_id->mod_uuid, &module->uuid))
>  				pin_id->module_id = module->id;
>  		}
>  
>  		for (i = 0; i < MAX_OUT_QUEUE; i++) {
>  			pin_id = &mconfig->m_out_pin[i].id;
> -			if (!uuid_le_cmp(pin_id->mod_uuid, module->uuid))
> +			if (guid_equal(&pin_id->mod_uuid, &module->uuid))
>  				pin_id->module_id = module->id;
>  		}
>  	}
> diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
> index e1d6f6719f7e..cbc7a93d56c2 100644
> --- a/sound/soc/intel/skylake/skl-sst-dsp.h
> +++ b/sound/soc/intel/skylake/skl-sst-dsp.h
> @@ -177,7 +177,7 @@ struct skl_dsp_loader_ops {
>  #define MAX_INSTANCE_BUFF 2
>  
>  struct uuid_module {
> -	uuid_le uuid;
> +	guid_t uuid;
>  	int id;
>  	int is_loadable;
>  	int max_instance;
> @@ -241,8 +241,8 @@ void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
>  
>  int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
>  				unsigned int offset, int index);
> -int skl_get_pvt_id(struct skl_sst *ctx, uuid_le *uuid_mod, int instance_id);
> -int skl_put_pvt_id(struct skl_sst *ctx, uuid_le *uuid_mod, int *pvt_id);
> +int skl_get_pvt_id(struct skl_sst *ctx, guid_t *uuid_mod, int instance_id);
> +int skl_put_pvt_id(struct skl_sst *ctx, guid_t *uuid_mod, int *pvt_id);
>  int skl_get_pvt_instance_id_map(struct skl_sst *ctx,
>  				int module_id, int instance_id);
>  void skl_freeup_uuid_list(struct skl_sst *ctx);
> diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
> index 2ae405617876..85551321c35b 100644
> --- a/sound/soc/intel/skylake/skl-sst-utils.c
> +++ b/sound/soc/intel/skylake/skl-sst-utils.c
> @@ -21,17 +21,11 @@
>  #include "../common/sst-dsp-priv.h"
>  #include "skl-sst-ipc.h"
>  
> -
> -#define UUID_STR_SIZE 37
>  #define DEFAULT_HASH_SHA256_LEN 32
>  
>  /* FW Extended Manifest Header id = $AE1 */
>  #define SKL_EXT_MANIFEST_HEADER_MAGIC   0x31454124
>  
> -struct UUID {
> -	u8 id[16];
> -};
> -
>  union seg_flags {
>  	u32 ul;
>  	struct {
> @@ -65,7 +59,7 @@ struct module_type {
>  struct adsp_module_entry {
>  	u32 struct_id;
>  	u8  name[8];
> -	struct UUID uuid;
> +	u8  uuid[16];
>  	struct module_type type;
>  	u8  hash1[DEFAULT_HASH_SHA256_LEN];
>  	u32 entry_point;
> @@ -184,13 +178,13 @@ static inline int skl_pvtid_128(struct uuid_module *module)
>   * This generates a 128 bit private unique id for a module TYPE so that
>   * module instance is unique
>   */
> -int skl_get_pvt_id(struct skl_sst *ctx, uuid_le *uuid_mod, int instance_id)
> +int skl_get_pvt_id(struct skl_sst *ctx, guid_t *uuid_mod, int instance_id)
>  {
>  	struct uuid_module *module;
>  	int pvt_id;
>  
>  	list_for_each_entry(module, &ctx->uuid_list, list) {
> -		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
> +		if (guid_equal(uuid_mod, &module->uuid)) {
>  
>  			pvt_id = skl_pvtid_128(module);
>  			if (pvt_id >= 0) {
> @@ -214,13 +208,13 @@ EXPORT_SYMBOL_GPL(skl_get_pvt_id);
>   *
>   * This frees a 128 bit private unique id previously generated
>   */
> -int skl_put_pvt_id(struct skl_sst *ctx, uuid_le *uuid_mod, int *pvt_id)
> +int skl_put_pvt_id(struct skl_sst *ctx, guid_t *uuid_mod, int *pvt_id)
>  {
>  	int i;
>  	struct uuid_module *module;
>  
>  	list_for_each_entry(module, &ctx->uuid_list, list) {
> -		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
> +		if (guid_equal(uuid_mod, &module->uuid)) {
>  
>  			if (*pvt_id != 0)
>  				i = (*pvt_id) / 64;
> @@ -247,7 +241,6 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
>  	struct adsp_fw_hdr *adsp_hdr;
>  	struct adsp_module_entry *mod_entry;
>  	int i, num_entry, size;
> -	uuid_le *uuid_bin;
>  	const char *buf;
>  	struct skl_sst *skl = ctx->thread_context;
>  	struct uuid_module *module;
> @@ -279,8 +272,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
>  		return -EINVAL;
>  	}
>  
> -	mod_entry = (struct adsp_module_entry *)
> -		(buf + offset + adsp_hdr->len);
> +	mod_entry = (struct adsp_module_entry *)(buf + offset + adsp_hdr->len);
>  
>  	num_entry = adsp_hdr->num_modules;
>  
> @@ -307,8 +299,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
>  			goto free_uuid_list;
>  		}
>  
> -		uuid_bin = (uuid_le *)mod_entry->uuid.id;
> -		memcpy(&module->uuid, uuid_bin, sizeof(module->uuid));
> +		guid_copy(&module->uuid, (guid_t *)&mod_entry->uuid);
>  
>  		module->id = (i | (index << 12));
>  		module->is_loadable = mod_entry->type.load_type;
> diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
> index 5951bbdf1f1a..92806119a755 100644
> --- a/sound/soc/intel/skylake/skl-sst.c
> +++ b/sound/soc/intel/skylake/skl-sst.c
> @@ -420,9 +420,9 @@ static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, u8 *guid)
>  	struct skl_module_table *module_entry = NULL;
>  	int ret = 0;
>  	char mod_name[64]; /* guid str = 32 chars + 4 hyphens */
> -	uuid_le *uuid_mod;
> +	guid_t *uuid_mod;
>  
> -	uuid_mod = (uuid_le *)guid;
> +	uuid_mod = (guid_t *)guid;
>  	snprintf(mod_name, sizeof(mod_name), "%s%pUL%s",
>  				"intel/dsp_fw_", uuid_mod, ".bin");
>  
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 76dde12cc2bb..160a5c864b3f 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -577,7 +577,7 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
>  	int ret = 0;
>  
>  	list_for_each_entry(w_module, &pipe->w_list, node) {
> -		uuid_le *uuid_mod;
> +		guid_t *uuid_mod;
>  		w = w_module->w;
>  		mconfig = w->priv;
>  
> @@ -585,7 +585,7 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
>  		if (mconfig->id.module_id < 0) {
>  			dev_err(skl->skl_sst->dev,
>  					"module %pUL id not populated\n",
> -					(uuid_le *)mconfig->guid);
> +					(guid_t *)mconfig->guid);
>  			return -EIO;
>  		}
>  
> @@ -619,7 +619,7 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
>  		 * FE/BE params
>  		 */
>  		skl_tplg_update_module_params(w, ctx);
> -		uuid_mod = (uuid_le *)mconfig->guid;
> +		uuid_mod = (guid_t *)mconfig->guid;
>  		mconfig->id.pvt_id = skl_get_pvt_id(ctx, uuid_mod,
>  						mconfig->id.instance_id);
>  		if (mconfig->id.pvt_id < 0)
> @@ -658,9 +658,9 @@ static int skl_tplg_unload_pipe_modules(struct skl_sst *ctx,
>  	struct skl_module_cfg *mconfig = NULL;
>  
>  	list_for_each_entry(w_module, &pipe->w_list, node) {
> -		uuid_le *uuid_mod;
> +		guid_t *uuid_mod;
>  		mconfig  = w_module->w->priv;
> -		uuid_mod = (uuid_le *)mconfig->guid;
> +		uuid_mod = (guid_t *)mconfig->guid;
>  
>  		if (mconfig->module->loadable && ctx->dsp->fw_ops.unload_mod &&
>  			mconfig->m_state > SKL_MODULE_UNINIT) {
> @@ -916,12 +916,12 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
>  	return 0;
>  }
>  
> -static int skl_get_module_id(struct skl_sst *ctx, uuid_le *uuid)
> +static int skl_get_module_id(struct skl_sst *ctx, guid_t *uuid)
>  {
>  	struct uuid_module *module;
>  
>  	list_for_each_entry(module, &ctx->uuid_list, list) {
> -		if (uuid_le_cmp(*uuid, module->uuid) == 0)
> +		if (guid_equal(uuid, &module->uuid))
>  			return module->id;
>  	}
>  
> @@ -2121,11 +2121,11 @@ static int skl_tplg_add_pipe(struct device *dev,
>  	return 0;
>  }
>  
> -static int skl_tplg_get_uuid(struct device *dev, u8 *guid,
> +static int skl_tplg_get_uuid(struct device *dev, guid_t *guid,
>  	      struct snd_soc_tplg_vendor_uuid_elem *uuid_tkn)
>  {
>  	if (uuid_tkn->token == SKL_TKN_UUID) {
> -		memcpy(guid, &uuid_tkn->uuid, 16);
> +		guid_copy(guid, (guid_t *)&uuid_tkn->uuid);
>  		return 0;
>  	}
>  
> @@ -2151,7 +2151,7 @@ static int skl_tplg_fill_pin(struct device *dev,
>  		break;
>  
>  	case SKL_TKN_UUID:
> -		ret = skl_tplg_get_uuid(dev, m_pin[pin_index].id.mod_uuid.b,
> +		ret = skl_tplg_get_uuid(dev, &m_pin[pin_index].id.mod_uuid,
>  			(struct snd_soc_tplg_vendor_uuid_elem *)tkn_elem);
>  		if (ret < 0)
>  			return ret;
> @@ -2666,7 +2666,7 @@ static int skl_tplg_get_tokens(struct device *dev,
>  
>  		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
>  			if (is_module_guid) {
> -				ret = skl_tplg_get_uuid(dev, mconfig->guid,
> +				ret = skl_tplg_get_uuid(dev, (guid_t *)mconfig->guid,
>  							array->uuid);
>  				is_module_guid = false;
>  			} else {
> @@ -3484,7 +3484,7 @@ static int skl_tplg_get_manifest_uuid(struct device *dev,
>  
>  	if (uuid_tkn->token == SKL_TKN_UUID) {
>  		mod = skl->modules[ref_count];
> -		memcpy(&mod->uuid, &uuid_tkn->uuid, sizeof(uuid_tkn->uuid));
> +		guid_copy(&mod->uuid, (guid_t *)&uuid_tkn->uuid);
>  		ref_count++;
>  	} else {
>  		dev_err(dev, "Not an UUID token tkn %d\n", uuid_tkn->token);
> diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
> index 82282cac9751..9311e248b6f9 100644
> --- a/sound/soc/intel/skylake/skl-topology.h
> +++ b/sound/soc/intel/skylake/skl-topology.h
> @@ -224,7 +224,7 @@ struct skl_mod_inst_map {
>  struct skl_uuid_inst_map {
>  	u16 inst_id;
>  	u16 reserved;
> -	uuid_le mod_uuid;
> +	guid_t mod_uuid;
>  } __packed;
>  
>  struct skl_kpb_params {
> @@ -236,7 +236,7 @@ struct skl_kpb_params {
>  };
>  
>  struct skl_module_inst_id {
> -	uuid_le mod_uuid;
> +	guid_t mod_uuid;
>  	int module_id;
>  	u32 instance_id;
>  	int pvt_id;
> @@ -369,7 +369,7 @@ struct skl_module_res {
>  };
>  
>  struct skl_module {
> -	uuid_le uuid;
> +	guid_t uuid;
>  	u8 loadable;
>  	u8 input_pin_type;
>  	u8 output_pin_type;
> -- 
> 2.18.0
> 

-- 
With Best Regards,
Andy Shevchenko
