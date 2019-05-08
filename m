From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH v2 24/30] mfd: cros_ec: Add API for EC-EC
	communication
Date: Wed, 8 May 2019 16:22:39 -0700
Message-ID: <20190508232239.GB41543@google.com>
References: <20190503220233.64546-1-gwendal@chromium.org>
 <20190503220233.64546-25-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3755417370401129016=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97BA8F807B5
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2019 01:22:48 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id y3so153358plp.0
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2019 16:22:48 -0700 (PDT)
In-Reply-To: <20190503220233.64546-25-gwendal@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: alsa-devel@alsa-project.org, linux-iio@vger.kernel.org, bleung@chromium.org, tiwai@suse.com, groeck@chromium.org, broonie@kernel.org, enric.balletbo@collabora.com, lee.jones@linaro.org, jic23@kernel.org, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============3755417370401129016==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gwendal,

Really tiny commit message nit, otherwise look good.

On Fri, May 03, 2019 at 03:02:27PM -0700, Gwendal Grignou wrote:
> Allow EC to talk to other ECs that are not presented to the host.
> Neeed when EC are present in detachable keyboard.

s/Neeed/Needed


Thanks,
Benson
>=20
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  include/linux/mfd/cros_ec_commands.h | 95 ++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>=20
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cro=
s_ec_commands.h
> index 59ad6bae3f9b..52fd9bfafc7f 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -5043,6 +5043,101 @@ struct ec_response_pd_chip_info_v1 {
>  	};
>  } __ec_align2;
> =20
> +/***********************************************************************=
******/
> +/* EC-EC communication commands: range 0x0600-0x06FF */
> +
> +#define EC_COMM_TEXT_MAX 8
> +
> +/*
> + * Get battery static information, i.e. information that never changes, =
or
> + * very infrequently.
> + */
> +#define EC_CMD_BATTERY_GET_STATIC 0x0600
> +
> +/**
> + * struct ec_params_battery_static_info - Battery static info parameters
> + * @index: Battery index.
> + */
> +struct ec_params_battery_static_info {
> +	uint8_t index;
> +} __ec_align_size1;
> +
> +/**
> + * struct ec_response_battery_static_info - Battery static info response
> + * @design_capacity: Battery Design Capacity (mAh)
> + * @design_voltage: Battery Design Voltage (mV)
> + * @manufacturer: Battery Manufacturer String
> + * @model: Battery Model Number String
> + * @serial: Battery Serial Number String
> + * @type: Battery Type String
> + * @cycle_count: Battery Cycle Count
> + */
> +struct ec_response_battery_static_info {
> +	uint16_t design_capacity;
> +	uint16_t design_voltage;
> +	char manufacturer[EC_COMM_TEXT_MAX];
> +	char model[EC_COMM_TEXT_MAX];
> +	char serial[EC_COMM_TEXT_MAX];
> +	char type[EC_COMM_TEXT_MAX];
> +	/* TODO(crbug.com/795991): Consider moving to dynamic structure. */
> +	uint32_t cycle_count;
> +} __ec_align4;
> +
> +/*
> + * Get battery dynamic information, i.e. information that is likely to c=
hange
> + * every time it is read.
> + */
> +#define EC_CMD_BATTERY_GET_DYNAMIC 0x0601
> +
> +/**
> + * struct ec_params_battery_dynamic_info - Battery dynamic info paramete=
rs
> + * @index: Battery index.
> + */
> +struct ec_params_battery_dynamic_info {
> +	uint8_t index;
> +} __ec_align_size1;
> +
> +/**
> + * struct ec_response_battery_dynamic_info - Battery dynamic info respon=
se
> + * @actual_voltage: Battery voltage (mV)
> + * @actual_current: Battery current (mA); negative=3Ddischarging
> + * @remaining_capacity: Remaining capacity (mAh)
> + * @full_capacity: Capacity (mAh, might change occasionally)
> + * @flags: Flags, see EC_BATT_FLAG_*
> + * @desired_voltage: Charging voltage desired by battery (mV)
> + * @desired_current: Charging current desired by battery (mA)
> + */
> +struct ec_response_battery_dynamic_info {
> +	int16_t actual_voltage;
> +	int16_t actual_current;
> +	int16_t remaining_capacity;
> +	int16_t full_capacity;
> +	int16_t flags;
> +	int16_t desired_voltage;
> +	int16_t desired_current;
> +} __ec_align2;
> +
> +/*
> + * Control charger chip. Used to control charger chip on the slave.
> + */
> +#define EC_CMD_CHARGER_CONTROL 0x0602
> +
> +/**
> + * struct ec_params_charger_control - Charger control parameters
> + * @max_current: Charger current (mA). Positive to allow base to draw up=
 to
> + *     max_current and (possibly) charge battery, negative to request cu=
rrent
> + *     from base (OTG).
> + * @otg_voltage: Voltage (mV) to use in OTG mode, ignored if max_current=
 is
> + *     >=3D 0.
> + * @allow_charging: Allow base battery charging (only makes sense if
> + *     max_current > 0).
> + */
> +struct ec_params_charger_control {
> +	int16_t max_current;
> +	uint16_t otg_voltage;
> +	uint8_t allow_charging;
> +} __ec_align_size1;
> +
>  /***********************************************************************=
******/
>  /*
>   * Reserve a range of host commands for board-specific, experimental, or
> --=20
> 2.21.0.1020.gf2820cf01a-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlzTZL8ACgkQHwn1ewov
5lgliBAAi2Xkq93LTZDfzRbcO20fikTdY5Os7wvDskLQqxOhuCQegTvlsMT5H4NZ
CHowvQYqTXOJHnAVO9PdwZ52a6LXuvFf6mHrHlS1wKHVnBaWoUvY1mbPT8OMXaWf
ixJ8adShf43SdVP7IPjj5HPYv3qdCknqOGJMonUjNM2FFn5YXjYbtOFjwrOohdMT
iGoy2TOxpb8j5LK/Kgnzy5i9BcSQ1QkNggBedPoM/jRHw7IE/WKO4X1L9HLiHcVy
UuvYMSAzRVP+80HbMCAAjBvrmD3ngVyHvIjVl5jcjpw2JkpayMpCHWHAIU2hKjN5
qehGEdME9Uy8pwdab3n/7fuH+blawfCKjI73oyYly4xkbvRDlWCXRhKGMQMbBTMR
s60Bjl4TXQfyrWzivPATHaH55OXiQa6dsmcOz0c64+jMTi0AEgBTuR6g9FwEBe23
fqRO4sapql8jaq4K6jyvurM8ElrjF0ubTXHsTUD2n9bPxbk48KhwtEetzzKuAVit
I4BrnNZQV8yXfoiYRB839bGdKHgxIR19PA8xP+64I5UfKWyCzIq9flSjgFMlA35T
7AUol4jfr36gJppK1hdZW3VPEcpA/5MycUc00vRqzM5AkiqUvIeaxuvlFSWpUkl9
VDy1jzZ0pW9JlAboUear7pyrRaP3uZfrjwVCYFqC2zJXaedFmko=
=krvY
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--

--===============3755417370401129016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3755417370401129016==--
