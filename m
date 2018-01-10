From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH 1/2] soundwire: Fix a signedness bug
Date: Wed, 10 Jan 2018 16:24:25 +0530
Message-ID: <20180110105425.GY18649@localhost>
References: <20180109093700.7275ardpus7g6rkq@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180109093700.7275ardpus7g6rkq@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 09, 2018 at 12:37:00PM +0300, Dan Carpenter wrote:
> "ret" is an int and "buf" is a u8.  sdw_read() returns negative error
> codes which are truncated to the u8, 0-255 range before being stored as
> an int.  It means that "ret" can't be less than zero.
> 
> Fixes: b0a9c37b0178 ("soundwire: Add slave status handling")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 4c345197eb55..ac88031f7664 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -771,12 +771,13 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
>  
>  	/* Read Instat 1, Instat 2 and Instat 3 registers */
> -	ret = buf = sdw_read(slave, SDW_SCP_INT1);
> +	ret = sdw_read(slave, SDW_SCP_INT1);

How about:

	buf = ret = sdw_read(slave, SDW_SCP_INT1);

That should make sure truncation happens latter, but then this is simpler to
read...

>  	if (ret < 0) {
>  		dev_err(slave->bus->dev,
>  					"SDW_SCP_INT1 read failed:%d", ret);
>  		return ret;
>  	}
> +	buf = ret;
>  
>  	ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, buf2);
>  	if (ret < 0) {
> @@ -870,12 +871,13 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  		 * Read status again to ensure no new interrupts arrived
>  		 * while servicing interrupts.
>  		 */
> -		ret = _buf = sdw_read(slave, SDW_SCP_INT1);
> +		ret = sdw_read(slave, SDW_SCP_INT1);
>  		if (ret < 0) {
>  			dev_err(slave->bus->dev,
>  					"SDW_SCP_INT1 read failed:%d", ret);
>  			return ret;
>  		}
> +		_buf = ret;
>  
>  		ret = sdw_nread(slave, SDW_SCP_INTSTAT2, 2, _buf2);
>  		if (ret < 0) {
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
