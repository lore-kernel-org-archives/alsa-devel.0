Return-Path: <SRS0=jDen=FJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D587C433FE
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 07:47:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCA622D0B
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Dec 2020 07:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCA622D0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20D7E18C6;
	Sat,  5 Dec 2020 08:46:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20D7E18C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607154425;
	bh=E//ldQD+TeV8HCUYzMii3JTE74QciR7JyOaYyr12bKs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SIuo97dpBakNb/yTkvTi8KRoOlFIfv67xLZTwe/OuwyLMzkZmO0F7dN+bft+IteNi
	 yGVFjbAbfaZiWIaU5NPMSzqUXhRtNaf8vgJgmjv0QPssEK/VYEkwrxy7erPYH3RJxb
	 jyJAq8TflujM8bc+DI9t0M3ispgIUpm3e3nhlC6Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58FD9F8025F;
	Sat,  5 Dec 2020 08:46:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2ACAF8025F; Sat,  5 Dec 2020 08:46:06 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D0AFF80254
 for <alsa-devel@alsa-project.org>; Sat,  5 Dec 2020 08:46:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D0AFF80254
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uMIHDlcD"
Date: Sat, 5 Dec 2020 13:15:54 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607154358;
 bh=E//ldQD+TeV8HCUYzMii3JTE74QciR7JyOaYyr12bKs=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=uMIHDlcDGdteusCW1MAbeyFsTH9qqwWeoyijGXtOzJd3kLzUIpPUt8tNgP9bn8TUo
 s2xV0klJP0LHZ7RaHrOvUS6Rp9T4igu5f/zNDOjTKS8+MC0ZIVl8BtAep0YhFeqV03
 0rYBSdgCa24ETK5HObcjQBhX4pa2dPPi5X5Vd8JyfArCIyMh08lHHTdwcUyOpmjpAv
 4OlXZlQXrtlLsEESoeYzhazLIyWYiMn6QxObeoEY4SSU2VgSkcPJX6fggKd4nUSYAp
 zgR3eWchsp17yXNRdDZIGcGzKqRZsDZuCFS7tm3K6qQUp6x9H0f/t/VWKkfY9VVlGO
 KOy3RN0RnvedQ==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 4/7] soundwire/regmap: use _no_pm functions in
 regmap_read/write
Message-ID: <20201205074554.GR8403@vkoul-mobl>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-5-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202204645.23891-5-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 03-12-20, 04:46, Bard Liao wrote:
> sdw_update_slave_status will be invoked when a codec is attached,
> and the codec driver will initialize the codec with regmap functions
> while the codec device is pm_runtime suspended.
> 
> regmap routines currently rely on regular SoundWire IO functions,
> which will call pm_runtime_get_sync()/put_autosuspend.
> 
> This causes a deadlock where the resume routine waits for an
> initialization complete signal that while the initialization complete
> can only be reached when the resume completes.
> 
> The only solution if we allow regmap functions to be used in resume
> operations as well as during codec initialization is to use _no_pm
> routines. The duty of making sure the bus is operational needs to be
> handled above the regmap level.
> 
> Fixes: 7c22ce6e21840 ('regmap: Add SoundWire bus support')
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> ---
>  drivers/base/regmap/regmap-sdw.c | 4 ++--
>  drivers/soundwire/bus.c          | 6 ++++--
>  include/linux/soundwire/sdw.h    | 2 ++
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
> index c92d614b4943..4b8d2d010cab 100644
> --- a/drivers/base/regmap/regmap-sdw.c
> +++ b/drivers/base/regmap/regmap-sdw.c
> @@ -11,7 +11,7 @@ static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
>  	struct device *dev = context;
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  
> -	return sdw_write(slave, reg, val);
> +	return sdw_write_no_pm(slave, reg, val);
>  }
>  
>  static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
> @@ -20,7 +20,7 @@ static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	int read;
>  
> -	read = sdw_read(slave, reg);
> +	read = sdw_read_no_pm(slave, reg);
>  	if (read < 0)
>  		return read;
>  
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 86c339d77a39..c5ea59673dee 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -405,10 +405,11 @@ sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>  	return sdw_transfer(slave->bus, &msg);
>  }
>  
> -static int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
> +int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
>  {
>  	return sdw_nwrite_no_pm(slave, addr, 1, &value);
>  }
> +EXPORT_SYMBOL(sdw_write_no_pm);

Why not export this is patch 1..?

>  
>  static int
>  sdw_bread_no_pm(struct sdw_bus *bus, u16 dev_num, u32 addr)
> @@ -476,7 +477,7 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
>  }
>  EXPORT_SYMBOL(sdw_bwrite_no_pm_unlocked);
>  
> -static int
> +int
>  sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
>  {
>  	u8 buf;
> @@ -488,6 +489,7 @@ sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
>  	else
>  		return buf;
>  }
> +EXPORT_SYMBOL(sdw_read_no_pm);
>  
>  static int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
>  {
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index f0b01b728640..d08039d65825 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -1005,6 +1005,8 @@ int sdw_bus_exit_clk_stop(struct sdw_bus *bus);
>  
>  int sdw_read(struct sdw_slave *slave, u32 addr);
>  int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
> +int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
> +int sdw_read_no_pm(struct sdw_slave *slave, u32 addr);
>  int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
>  int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val);
>  
> -- 
> 2.17.1

-- 
~Vinod
