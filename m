From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] soc: intel: sst-haswell-ipc: Remove some
 unused functions
Date: Sun, 4 Jan 2015 01:39:24 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901B7EC2B@SHSMSX101.ccr.corp.intel.com>
References: <1420331724-5579-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B83C826058E
 for <alsa-devel@alsa-project.org>; Sun,  4 Jan 2015 02:39:32 +0100 (CET)
In-Reply-To: <1420331724-5579-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
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
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Christian Engelmayer <cengelma@gmx.at>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Piskorski,
 Pawel" <pawel.piskorski@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org


Hi Rickard,

Thanks for your checking.

I have just confirmed that those functions really not used currently, although they may be needed for advanced developing. 
So, I have no objection if you remove them now.

Liam, what's your opinion?

~Keyon

> -----Original Message-----
> From: Rickard Strandqvist [mailto:rickard_strandqvist@spectrumdigital.se]
> Sent: Sunday, January 04, 2015 8:35 AM
> To: Liam Girdwood; Mark Brown
> Cc: Rickard Strandqvist; Jaroslav Kysela; Takashi Iwai; Jie, Yang; Jarkko Nikula;
> Dan Carpenter; Christian Engelmayer; Piskorski, Pawel;
> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] soc: intel: sst-haswell-ipc: Remove some unused functions
> 
> Removes some functions that are not used anywhere:
> sst_hsw_stream_unmute() sst_hsw_stream_mute() msg_set_stage_type()
> sst_hsw_dx_get_state() sst_hsw_dx_set_state()
> sst_hsw_stream_set_write_position()
> sst_hsw_stream_get_vol_reg() sst_hsw_stream_get_peak_reg()
> sst_hsw_stream_get_pointer_reg() sst_hsw_stream_get_read_reg()
> sst_hsw_stream_get_mixer_id() sst_hsw_stream_get_hw_id()
> sst_hsw_mixer_set_volume_curve() sst_hsw_mixer_unmute()
> sst_hsw_mixer_mute()
> sst_hsw_stream_set_volume_curve()
> 
> This was partially found by using a static code analysis program called
> cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  sound/soc/intel/sst-haswell-ipc.c |  226 -------------------------------------
>  sound/soc/intel/sst-haswell-ipc.h |   34 ------
>  2 files changed, 260 deletions(-)
> 
> diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
> index b629151..26f856c 100644
> --- a/sound/soc/intel/sst-haswell-ipc.c
> +++ b/sound/soc/intel/sst-haswell-ipc.c
> @@ -333,12 +333,6 @@ static inline u32 msg_get_stage_type(u32 msg)
>  	return (msg & IPC_STG_TYPE_MASK) >>  IPC_STG_TYPE_SHIFT;  }
> 
> -static inline u32 msg_set_stage_type(u32 msg, u32 type) -{
> -	return (msg & ~IPC_STG_TYPE_MASK) +
> -		(type << IPC_STG_TYPE_SHIFT);
> -}
> -
>  static inline u32 msg_get_stream_id(u32 msg)  {
>  	return (msg & IPC_STR_ID_MASK) >>  IPC_STR_ID_SHIFT; @@ -965,45
> +959,6 @@ int sst_hsw_fw_get_version(struct sst_hsw *hsw,  }
> 
>  /* Mixer Controls */
> -int sst_hsw_stream_mute(struct sst_hsw *hsw, struct sst_hsw_stream
> *stream,
> -	u32 stage_id, u32 channel)
> -{
> -	int ret;
> -
> -	ret = sst_hsw_stream_get_volume(hsw, stream, stage_id, channel,
> -		&stream->mute_volume[channel]);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = sst_hsw_stream_set_volume(hsw, stream, stage_id, channel, 0);
> -	if (ret < 0) {
> -		dev_err(hsw->dev, "error: can't unmute stream %d channel %d\n",
> -			stream->reply.stream_hw_id, channel);
> -		return ret;
> -	}
> -
> -	stream->mute[channel] = 1;
> -	return 0;
> -}
> -
> -int sst_hsw_stream_unmute(struct sst_hsw *hsw, struct sst_hsw_stream
> *stream,
> -	u32 stage_id, u32 channel)
> -
> -{
> -	int ret;
> -
> -	stream->mute[channel] = 0;
> -	ret = sst_hsw_stream_set_volume(hsw, stream, stage_id, channel,
> -		stream->mute_volume[channel]);
> -	if (ret < 0) {
> -		dev_err(hsw->dev, "error: can't unmute stream %d channel %d\n",
> -			stream->reply.stream_hw_id, channel);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  int sst_hsw_stream_get_volume(struct sst_hsw *hsw, struct
> sst_hsw_stream *stream,
>  	u32 stage_id, u32 channel, u32 *volume)  { @@ -1017,17 +972,6 @@ int
> sst_hsw_stream_get_volume(struct sst_hsw *hsw, struct sst_hsw_stream
> *stream
>  	return 0;
>  }
> 
> -int sst_hsw_stream_set_volume_curve(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream, u64 curve_duration,
> -	enum sst_hsw_volume_curve curve)
> -{
> -	/* curve duration in steps of 100ns */
> -	stream->vol_req.curve_duration = curve_duration;
> -	stream->vol_req.curve_type = curve;
> -
> -	return 0;
> -}
> -
>  /* stream volume */
>  int sst_hsw_stream_set_volume(struct sst_hsw *hsw,
>  	struct sst_hsw_stream *stream, u32 stage_id, u32 channel, u32 volume)
> @@ -1065,42 +1009,6 @@ int sst_hsw_stream_set_volume(struct sst_hsw
> *hsw,
>  	return 0;
>  }
> 
> -int sst_hsw_mixer_mute(struct sst_hsw *hsw, u32 stage_id, u32 channel) -{
> -	int ret;
> -
> -	ret = sst_hsw_mixer_get_volume(hsw, stage_id, channel,
> -		&hsw->mute_volume[channel]);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = sst_hsw_mixer_set_volume(hsw, stage_id, channel, 0);
> -	if (ret < 0) {
> -		dev_err(hsw->dev, "error: failed to unmute mixer channel %d\n",
> -			channel);
> -		return ret;
> -	}
> -
> -	hsw->mute[channel] = 1;
> -	return 0;
> -}
> -
> -int sst_hsw_mixer_unmute(struct sst_hsw *hsw, u32 stage_id, u32 channel) -{
> -	int ret;
> -
> -	ret = sst_hsw_mixer_set_volume(hsw, stage_id, channel,
> -		hsw->mixer_info.volume_register_address[channel]);
> -	if (ret < 0) {
> -		dev_err(hsw->dev, "error: failed to unmute mixer channel %d\n",
> -			channel);
> -		return ret;
> -	}
> -
> -	hsw->mute[channel] = 0;
> -	return 0;
> -}
> -
>  int sst_hsw_mixer_get_volume(struct sst_hsw *hsw, u32 stage_id, u32
> channel,
>  	u32 *volume)
>  {
> @@ -1114,16 +1022,6 @@ int sst_hsw_mixer_get_volume(struct sst_hsw
> *hsw, u32 stage_id, u32 channel,
>  	return 0;
>  }
> 
> -int sst_hsw_mixer_set_volume_curve(struct sst_hsw *hsw,
> -	 u64 curve_duration, enum sst_hsw_volume_curve curve)
> -{
> -	/* curve duration in steps of 100ns */
> -	hsw->curve_duration = curve_duration;
> -	hsw->curve_type = curve;
> -
> -	return 0;
> -}
> -
>  /* global mixer volume */
>  int sst_hsw_mixer_set_volume(struct sst_hsw *hsw, u32 stage_id, u32
> channel,
>  	u32 volume)
> @@ -1425,50 +1323,6 @@ int sst_hsw_stream_commit(struct sst_hsw *hsw,
> struct sst_hsw_stream *stream)
>  	return 0;
>  }
> 
> -/* Stream Information - these calls could be inline but we want the IPC
> - ABI to be opaque to client PCM drivers to cope with any future ABI changes */
> -int sst_hsw_stream_get_hw_id(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream)
> -{
> -	return stream->reply.stream_hw_id;
> -}
> -
> -int sst_hsw_stream_get_mixer_id(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream)
> -{
> -	return stream->reply.mixer_hw_id;
> -}
> -
> -u32 sst_hsw_stream_get_read_reg(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream)
> -{
> -	return stream->reply.read_position_register_address;
> -}
> -
> -u32 sst_hsw_stream_get_pointer_reg(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream)
> -{
> -	return stream->reply.presentation_position_register_address;
> -}
> -
> -u32 sst_hsw_stream_get_peak_reg(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream, u32 channel)
> -{
> -	if (channel >= 2)
> -		return 0;
> -
> -	return stream->reply.peak_meter_register_address[channel];
> -}
> -
> -u32 sst_hsw_stream_get_vol_reg(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream, u32 channel)
> -{
> -	if (channel >= 2)
> -		return 0;
> -
> -	return stream->reply.volume_register_address[channel];
> -}
> -
>  int sst_hsw_mixer_get_info(struct sst_hsw *hsw)  {
>  	struct sst_hsw_ipc_stream_info_reply *reply; @@ -1591,30 +1445,6 @@
> u64 sst_hsw_get_dsp_presentation_position(struct sst_hsw *hsw,
>  	return ppos;
>  }
> 
> -int sst_hsw_stream_set_write_position(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream, u32 stage_id, u32 position)
> -{
> -	u32 header;
> -	int ret;
> -
> -	trace_stream_write_position(stream->reply.stream_hw_id, position);
> -
> -	header = IPC_GLB_TYPE(IPC_GLB_STREAM_MESSAGE) |
> -		IPC_STR_TYPE(IPC_STR_STAGE_MESSAGE);
> -	header |= (stream->reply.stream_hw_id << IPC_STR_ID_SHIFT);
> -	header |= (IPC_STG_SET_WRITE_POSITION << IPC_STG_TYPE_SHIFT);
> -	header |= (stage_id << IPC_STG_ID_SHIFT);
> -	stream->wpos.position = position;
> -
> -	ret = ipc_tx_message_nowait(hsw, header, &stream->wpos,
> -		sizeof(stream->wpos));
> -	if (ret < 0)
> -		dev_err(hsw->dev, "error: stream %d set position %d failed\n",
> -			stream->reply.stream_hw_id, position);
> -
> -	return ret;
> -}
> -
>  /* physical BE config */
>  int sst_hsw_device_set_config(struct sst_hsw *hsw,
>  	enum sst_hsw_device_id dev, enum sst_hsw_device_mclk mclk, @@
> -1644,63 +1474,7 @@ int sst_hsw_device_set_config(struct sst_hsw *hsw,  }
> EXPORT_SYMBOL_GPL(sst_hsw_device_set_config);
> 
> -/* DX Config */
> -int sst_hsw_dx_set_state(struct sst_hsw *hsw,
> -	enum sst_hsw_dx_state state, struct sst_hsw_ipc_dx_reply *dx)
> -{
> -	u32 header, state_;
> -	int ret, item;
> -
> -	header = IPC_GLB_TYPE(IPC_GLB_ENTER_DX_STATE);
> -	state_ = state;
> -
> -	trace_ipc_request("PM enter Dx state", state);
> -
> -	ret = ipc_tx_message_wait(hsw, header, &state_, sizeof(state_),
> -		dx, sizeof(*dx));
> -	if (ret < 0) {
> -		dev_err(hsw->dev, "ipc: error set dx state %d failed\n", state);
> -		return ret;
> -	}
> -
> -	for (item = 0; item < dx->entries_no; item++) {
> -		dev_dbg(hsw->dev,
> -			"Item[%d] offset[%x] - size[%x] - source[%x]\n",
> -			item, dx->mem_info[item].offset,
> -			dx->mem_info[item].size,
> -			dx->mem_info[item].source);
> -	}
> -	dev_dbg(hsw->dev, "ipc: got %d entry numbers for state %d\n",
> -		dx->entries_no, state);
> -
> -	memcpy(&hsw->dx, dx, sizeof(*dx));
> -	return 0;
> -}
> -
>  /* Used to save state into hsw->dx_reply */ -int sst_hsw_dx_get_state(struct
> sst_hsw *hsw, u32 item,
> -	u32 *offset, u32 *size, u32 *source)
> -{
> -	struct sst_hsw_ipc_dx_memory_item *dx_mem;
> -	struct sst_hsw_ipc_dx_reply *dx_reply;
> -	int entry_no;
> -
> -	dx_reply = &hsw->dx;
> -	entry_no = dx_reply->entries_no;
> -
> -	trace_ipc_request("PM get Dx state", entry_no);
> -
> -	if (item >= entry_no)
> -		return -EINVAL;
> -
> -	dx_mem = &dx_reply->mem_info[item];
> -	*offset = dx_mem->offset;
> -	*size = dx_mem->size;
> -	*source = dx_mem->source;
> -
> -	return 0;
> -}
> -
>  static int msg_empty_list_init(struct sst_hsw *hsw)  {
>  	int i;
> diff --git a/sound/soc/intel/sst-haswell-ipc.h
> b/sound/soc/intel/sst-haswell-ipc.h
> index 2ac194a..b6297cb 100644
> --- a/sound/soc/intel/sst-haswell-ipc.h
> +++ b/sound/soc/intel/sst-haswell-ipc.h
> @@ -371,32 +371,18 @@ int sst_hsw_fw_get_version(struct sst_hsw *hsw,
>  u32 create_channel_map(enum sst_hsw_channel_config config);
> 
>  /* Stream Mixer Controls - */
> -int sst_hsw_stream_mute(struct sst_hsw *hsw, struct sst_hsw_stream
> *stream,
> -	u32 stage_id, u32 channel);
> -int sst_hsw_stream_unmute(struct sst_hsw *hsw, struct sst_hsw_stream
> *stream,
> -	u32 stage_id, u32 channel);
> 
>  int sst_hsw_stream_set_volume(struct sst_hsw *hsw,
>  	struct sst_hsw_stream *stream, u32 stage_id, u32 channel, u32 volume);
> int sst_hsw_stream_get_volume(struct sst_hsw *hsw,
>  	struct sst_hsw_stream *stream, u32 stage_id, u32 channel, u32
> *volume);
> 
> -int sst_hsw_stream_set_volume_curve(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream, u64 curve_duration,
> -	enum sst_hsw_volume_curve curve);
> -
>  /* Global Mixer Controls - */
> -int sst_hsw_mixer_mute(struct sst_hsw *hsw, u32 stage_id, u32 channel);
> -int sst_hsw_mixer_unmute(struct sst_hsw *hsw, u32 stage_id, u32 channel);
> -
>  int sst_hsw_mixer_set_volume(struct sst_hsw *hsw, u32 stage_id, u32
> channel,
>  	u32 volume);
>  int sst_hsw_mixer_get_volume(struct sst_hsw *hsw, u32 stage_id, u32
> channel,
>  	u32 *volume);
> 
> -int sst_hsw_mixer_set_volume_curve(struct sst_hsw *hsw,
> -	u64 curve_duration, enum sst_hsw_volume_curve curve);
> -
>  /* Stream API */
>  struct sst_hsw_stream *sst_hsw_stream_new(struct sst_hsw *hsw, int id,
>  	u32 (*get_write_position)(struct sst_hsw_stream *stream, void *data),
> @@ -436,18 +422,6 @@ int sst_hsw_stream_set_pmemory_info(struct
> sst_hsw *hsw,
>  	struct sst_hsw_stream *stream, u32 offset, u32 size);  int
> sst_hsw_stream_set_smemory_info(struct sst_hsw *hsw,
>  	struct sst_hsw_stream *stream, u32 offset, u32 size); -int
> sst_hsw_stream_get_hw_id(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream);
> -int sst_hsw_stream_get_mixer_id(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream);
> -u32 sst_hsw_stream_get_read_reg(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream);
> -u32 sst_hsw_stream_get_pointer_reg(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream);
> -u32 sst_hsw_stream_get_peak_reg(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream, u32 channel);
> -u32 sst_hsw_stream_get_vol_reg(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream, u32 channel);
>  int sst_hsw_mixer_get_info(struct sst_hsw *hsw);
> 
>  /* Stream ALSA trigger operations */
> @@ -462,8 +436,6 @@ int sst_hsw_stream_get_read_pos(struct sst_hsw
> *hsw,
>  	struct sst_hsw_stream *stream, u32 *position);  int
> sst_hsw_stream_get_write_pos(struct sst_hsw *hsw,
>  	struct sst_hsw_stream *stream, u32 *position); -int
> sst_hsw_stream_set_write_position(struct sst_hsw *hsw,
> -	struct sst_hsw_stream *stream, u32 stage_id, u32 position);
>  u32 sst_hsw_get_dsp_position(struct sst_hsw *hsw,
>  	struct sst_hsw_stream *stream);
>  u64 sst_hsw_get_dsp_presentation_position(struct sst_hsw *hsw, @@
> -474,12 +446,6 @@ int sst_hsw_device_set_config(struct sst_hsw *hsw,
>  	enum sst_hsw_device_id dev, enum sst_hsw_device_mclk mclk,
>  	enum sst_hsw_device_mode mode, u32 clock_divider);
> 
> -/* DX Config */
> -int sst_hsw_dx_set_state(struct sst_hsw *hsw,
> -	enum sst_hsw_dx_state state, struct sst_hsw_ipc_dx_reply *dx);
> -int sst_hsw_dx_get_state(struct sst_hsw *hsw, u32 item,
> -	u32 *offset, u32 *size, u32 *source);
> -
>  /* init */
>  int sst_hsw_dsp_init(struct device *dev, struct sst_pdata *pdata);  void
> sst_hsw_dsp_free(struct device *dev, struct sst_pdata *pdata);
> --
> 1.7.10.4
