From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3] mfd: cros: Update EC to use BIT() and merge
Date: Sat, 30 Mar 2019 14:43:36 +0000
Message-ID: <20190330144336.5fd8b9a0@archlinux>
References: <CAPUE2uti=fketJ4vJw34et_y9L_gsEUwXNDdjg0sG8Z27ir1Hg@mail.gmail.com>
        <20190329175628.31481-1-gwendal@chromium.org>
        <CAPUE2uuh2TvUiQCuG7KzQ=GD5Gm3C5ZbfZ42J0__H2R6yD1j9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPUE2uuh2TvUiQCuG7KzQ=GD5Gm3C5ZbfZ42J0__H2R6yD1j9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: enric.balletbo@collabora.com, bleung@chromium.org, groeck@chromium.org, lee.jones@linaro.org, broonie@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Mar 2019 10:56:37 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

What is "and merge" referring to in the title?

> Instead of using 1 << ..., use BIT() cleaner and safer.
> Fix minor fixes since major cros_ec_commands.h cleanup was uploaded.
> 
> TEST=compile.

Personally I'd prefer this is a a couple of patches as several
different changes going on.

A few minor comments below.

> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  include/linux/mfd/cros_ec_commands.h | 268 ++++++++++++++-------------
>  1 file changed, 143 insertions(+), 125 deletions(-)
> 
> diff --git a/include/linux/mfd/cros_ec_commands.h
> b/include/linux/mfd/cros_ec_commands.h
> index ea25e1644d23..5c4764e3db6f 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -46,7 +46,7 @@ extern "C"{
>  #define EC_PROTO_VERSION          0x00000002
...
> 
>  /**
>   * struct ec_response_get_protocol_info - Response to the get protocol info.
> @@ -1347,12 +1347,12 @@ enum ec_feature_code {
>  	EC_FEATURE_AUDIO_CODEC = 38,
>  	/* EC Supports SCP. */
>  	EC_FEATURE_SCP = 39,
> -	/* The MCU is Intel Integrated Sensor Hub */
> +	/* The MCU is an Integrated Sensor Hub */

Unrelated from the other changes so I'd like to see it in a separate
patch.

>  	EC_FEATURE_ISH = 40,
>  };
...
>  enum ec_led_colors {
>  	EC_LED_COLOR_RED = 0,
> @@ -2438,6 +2438,7 @@ enum motionsensor_chip {
>  	MOTIONSENSE_CHIP_LIS2DE = 15,
>  	MOTIONSENSE_CHIP_LIS2MDL = 16,
>  	MOTIONSENSE_CHIP_LSM6DS3 = 17,
> +	MOTIONSENSE_CHIP_LSM6DSO = 18,

Why is this here?

>  	MOTIONSENSE_CHIP_MAX,
>  };
> 
...
> 
>  enum mkbp_config_valid {
Bit odd that this was an enum in the first place..

I checked and it doesn't seem that the type is used anywhere,
so I would just make this set of defines.

> -	EC_MKBP_VALID_SCAN_PERIOD		= 1 << 0,
> -	EC_MKBP_VALID_POLL_TIMEOUT		= 1 << 1,
> -	EC_MKBP_VALID_MIN_POST_SCAN_DELAY	= 1 << 3,
> -	EC_MKBP_VALID_OUTPUT_SETTLE		= 1 << 4,
> -	EC_MKBP_VALID_DEBOUNCE_DOWN		= 1 << 5,
> -	EC_MKBP_VALID_DEBOUNCE_UP		= 1 << 6,
> -	EC_MKBP_VALID_FIFO_MAX_DEPTH		= 1 << 7,
> +	EC_MKBP_VALID_SCAN_PERIOD		= BIT(0),
> +	EC_MKBP_VALID_POLL_TIMEOUT		= BIT(1),
> +	EC_MKBP_VALID_MIN_POST_SCAN_DELAY	= BIT(3),
> +	EC_MKBP_VALID_OUTPUT_SETTLE		= BIT(4),
> +	EC_MKBP_VALID_DEBOUNCE_DOWN		= BIT(5),
> +	EC_MKBP_VALID_DEBOUNCE_UP		= BIT(6),
> +	EC_MKBP_VALID_FIFO_MAX_DEPTH		= BIT(7),
>  };
> 
...
