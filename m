From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 07/13] soundwire: Add stream
	configuration APIs
Date: Thu, 5 Apr 2018 18:40:20 -0500
Message-ID: <06b35225-232a-7220-ffda-e42b5c6c9366@linux.intel.com>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 09E36267299
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 01:40:23 +0200 (CEST)
In-Reply-To: <1522946904-2089-8-git-send-email-vinod.koul@intel.com>
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
To: Vinod Koul <vinod.koul@intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


> +/**
> + * sdw_prepare_stream: Prepare SoundWire stream
> + *
> + * @stream: Soundwire stream
> + *
> + * Documentation/soundwire/stream.txt explains this API in detail
> + */
> +int sdw_prepare_stream(struct sdw_stream_runtime *stream)
> +{
> +	int ret = 0;
> +
> +	if (!stream) {
> +		pr_err("SoundWire: Handle not found for stream");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&stream->m_rt->bus->bus_lock);
> +
> +	if (stream->state == SDW_STREAM_DISABLED)
> +		goto error;
> +
> +	if (stream->state != SDW_STREAM_CONFIGURED) {
> +		ret = -EINVAL;
> +		goto error;
> +	}

this seems to be a new pattern in this file.
Why is the first test even needed?

> +
> +	ret = _sdw_prepare_stream(stream);
> +	if (ret < 0) {
> +		pr_err("Prepare for stream:%s failed: %d", stream->name, ret);
> +		goto error;
> +	}
> +
> +error:
> +	mutex_unlock(&stream->m_rt->bus->bus_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(sdw_prepare_stream);
> +
> +static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
> +{
> +	struct sdw_master_runtime *m_rt = stream->m_rt;
> +	struct sdw_bus *bus = m_rt->bus;
> +	int ret;
> +
> +	/* Program params */
> +	ret = sdw_program_params(bus);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Program params failed: %d", ret);
> +		return ret;
> +	}
> +
> +	/* Enable port(s) */
> +	ret = sdw_enable_disable_ports(m_rt, true);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Enable port(s) failed ret: %d", ret);
> +		return ret;
> +	}
> +
> +	ret = do_bank_switch(stream);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Bank switch failed: %d", ret);
> +		return ret;
> +	}
> +
> +	stream->state = SDW_STREAM_ENABLED;
> +	return 0;
> +}
> +
> +/**
> + * sdw_enable_stream: Enable SoundWire stream
> + *
> + * @stream: Soundwire stream
> + *
> + * Documentation/soundwire/stream.txt explains this API in detail
> + */
> +int sdw_enable_stream(struct sdw_stream_runtime *stream)
> +{
> +	int ret = 0;
> +
> +	if (!stream) {
> +		pr_err("SoundWire: Handle not found for stream");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&stream->m_rt->bus->bus_lock);
> +
> +	if (stream->state == SDW_STREAM_ENABLED)
> +		goto error;
> +
> +	if ((stream->state != SDW_STREAM_PREPARED) &&
> +		(stream->state != SDW_STREAM_DISABLED)) {
> +		ret = -EINVAL;
> +		goto error;
> +	}

same here, why would you enable a stream that's already enabled? Why is 
this an error that returns 0?

> +
> +	ret = _sdw_enable_stream(stream);
> +	if (ret < 0) {
> +		pr_err("Enable for stream:%s failed: %d", stream->name, ret);
> +		goto error;
> +	}
> +
> +error:
> +	mutex_unlock(&stream->m_rt->bus->bus_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(sdw_enable_stream);
> +
> +static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
> +{
> +	struct sdw_master_runtime *m_rt = stream->m_rt;
> +	struct sdw_bus *bus = m_rt->bus;
> +	int ret;
> +
> +	/* Disable port(s) */
> +	ret = sdw_enable_disable_ports(m_rt, false);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Disable port(s) failed: %d", ret);
> +		return ret;
> +	}
> +
> +	stream->state = SDW_STREAM_DISABLED;
> +
> +	/* Program params */
> +	ret = sdw_program_params(bus);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Program params failed: %d", ret);
> +		return ret;
> +	}
> +
> +	return do_bank_switch(stream);
> +}
> +
> +/**
> + * sdw_disable_stream: Disable SoundWire stream
> + *
> + * @stream: Soundwire stream
> + *
> + * Documentation/soundwire/stream.txt explains this API in detail
> + */
> +int sdw_disable_stream(struct sdw_stream_runtime *stream)
> +{
> +	int ret = 0;
> +
> +	if (!stream) {
> +		pr_err("SoundWire: Handle not found for stream");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&stream->m_rt->bus->bus_lock);
> +
> +	if (stream->state == SDW_STREAM_DISABLED)
> +		goto error;
> +
> +	if (stream->state != SDW_STREAM_ENABLED) {
> +		ret = -EINVAL;
> +		goto error;
> +	}

and here to.

> +
> +	ret = _sdw_disable_stream(stream);
> +	if (ret < 0) {
> +		pr_err("Disable for stream:%s failed: %d", stream->name, ret);
> +		goto error;
> +	}
> +
> +error:
> +	mutex_unlock(&stream->m_rt->bus->bus_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(sdw_disable_stream);
> +
> +static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
> +{
> +	struct sdw_master_runtime *m_rt = stream->m_rt;
> +	struct sdw_bus *bus = m_rt->bus;
> +	int ret = 0;
> +
> +	/* De-prepare port(s) */
> +	ret = sdw_prep_deprep_ports(m_rt, false);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "De-prepare port(s) failed: %d", ret);
> +		return ret;
> +	}
> +
> +	bus->params.bandwidth -= m_rt->stream->params.rate *
> +		m_rt->ch_count * m_rt->stream->params.bps;
> +
> +	if (!bus->params.bandwidth) {
> +		bus->params.row = 0;
> +		bus->params.col = 0;
> +		goto exit;
> +
> +	}
> +
> +	/* Program params */
> +	ret = sdw_program_params(bus);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Program params failed: %d", ret);
> +		return ret;
> +	}
> +
> +	return do_bank_switch(stream);
> +
> +exit:
> +	stream->state = SDW_STREAM_DEPREPARED;
> +
> +	return ret;
> +}
> +
> +/**
> + * sdw_deprepare_stream: Deprepare SoundWire stream
> + *
> + * @stream: Soundwire stream
> + *
> + * Documentation/soundwire/stream.txt explains this API in detail
> + */
> +int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
> +{
> +	int ret = 0;
> +
> +	if (!stream) {
> +		pr_err("SoundWire: Handle not found for stream");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&stream->m_rt->bus->bus_lock);
> +
> +	if (stream->state != SDW_STREAM_DISABLED) {
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	ret = _sdw_deprepare_stream(stream);
> +	if (ret < 0) {
> +		pr_err("De-prepare for stream:%d failed: %d", ret, ret);
> +		goto error;
> +	}
> +
> +error:
> +	mutex_unlock(&stream->m_rt->bus->bus_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(sdw_deprepare_stream);
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 4120a220ae42..4d9c3f86d0f0 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -791,6 +791,10 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
>   		struct sdw_stream_runtime *stream);
>   int sdw_stream_remove_slave(struct sdw_slave *slave,
>   		struct sdw_stream_runtime *stream);
> +int sdw_prepare_stream(struct sdw_stream_runtime *stream);
> +int sdw_enable_stream(struct sdw_stream_runtime *stream);
> +int sdw_disable_stream(struct sdw_stream_runtime *stream);
> +int sdw_deprepare_stream(struct sdw_stream_runtime *stream);
>   
>   /* messaging and data APIs */
>   
> 
