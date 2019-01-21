From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] ASoC: Intel: Skylake: Switch to modern
	UUID API
Date: Mon, 21 Jan 2019 09:53:22 +0100
Message-ID: <20190121085322.GH18680@lst.de>
References: <20180716095240.7399-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FED3267263
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 09:53:23 +0100 (CET)
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 16, 2018 at 12:52:40PM +0300, Andy Shevchenko wrote:
> Switch the driver to use modern UUID API, i.e. guid_t type and
> accompanying functions, such as guid_equal().
> 
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

I think we should also propagate the guid_t into the .load_mod
signature, and the mconfig->guid field.
