From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 21/40] soundwire: export helpers to find row and
 column values
Date: Mon, 5 Aug 2019 15:09:23 +0530
Message-ID: <20190805093923.GC22437@buildpc-HP-Z230>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-22-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-22-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 06:40:13PM -0500, Pierre-Louis Bossart wrote:
> Add a prefix for common tables and export 2 helpers to set the frame
> shapes based on row/col values.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.h    |  7 +++++--
>  drivers/soundwire/stream.c | 14 ++++++++------
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 06ac4adb0074..c57c9c23f6ca 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -73,8 +73,11 @@ struct sdw_msg {
>  
>  #define SDW_DOUBLE_RATE_FACTOR		2
>  
> -extern int rows[SDW_FRAME_ROWS];
> -extern int cols[SDW_FRAME_COLS];
> +extern int sdw_rows[SDW_FRAME_ROWS];
> +extern int sdw_cols[SDW_FRAME_COLS];
> +
> +int sdw_find_row_index(int row);
> +int sdw_find_col_index(int col);

We use index values only in bank switch operations to program registers. Do we
really need to export sdw_find_row_index & sdw_find_col_index?? If i understand
correctly the allocation algorithm only needs to know about cols and rows values
and not index.

>  
>  /**
>   * sdw_port_runtime: Runtime port parameters for Master or Slave
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index a0476755a459..53f5e790fcd7 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -21,37 +21,39 @@
>   * The rows are arranged as per the array index value programmed
>   * in register. The index 15 has dummy value 0 in order to fill hole.
>   */
> -int rows[SDW_FRAME_ROWS] = {48, 50, 60, 64, 75, 80, 125, 147,
> +int sdw_rows[SDW_FRAME_ROWS] = {48, 50, 60, 64, 75, 80, 125, 147,
>  			96, 100, 120, 128, 150, 160, 250, 0,
>  			192, 200, 240, 256, 72, 144, 90, 180};
>  
> -int cols[SDW_FRAME_COLS] = {2, 4, 6, 8, 10, 12, 14, 16};
> +int sdw_cols[SDW_FRAME_COLS] = {2, 4, 6, 8, 10, 12, 14, 16};
>  
> -static int sdw_find_col_index(int col)
> +int sdw_find_col_index(int col)
>  {
>  	int i;
>  
>  	for (i = 0; i < SDW_FRAME_COLS; i++) {
> -		if (cols[i] == col)
> +		if (sdw_cols[i] == col)
>  			return i;
>  	}
>  
>  	pr_warn("Requested column not found, selecting lowest column no: 2\n");
>  	return 0;
>  }
> +EXPORT_SYMBOL(sdw_find_col_index);
>  
> -static int sdw_find_row_index(int row)
> +int sdw_find_row_index(int row)
>  {
>  	int i;
>  
>  	for (i = 0; i < SDW_FRAME_ROWS; i++) {
> -		if (rows[i] == row)
> +		if (sdw_rows[i] == row)
>  			return i;
>  	}
>  
>  	pr_warn("Requested row not found, selecting lowest row no: 48\n");
>  	return 0;
>  }
> +EXPORT_SYMBOL(sdw_find_row_index);
>  
>  static int _sdw_program_slave_port_params(struct sdw_bus *bus,
>  					  struct sdw_slave *slave,
> -- 
> 2.20.1
> 

-- 
