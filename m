From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/5] topology: Change uuid value to 16
 separate characters in text conf file
Date: Wed, 13 Jul 2016 18:46:17 +0900
Message-ID: <57860DE9.2030202@sakamocchi.jp>
References: <cover.1468397702.git.mengdong.lin@linux.intel.com>
 <d3cf452fd17a9ae3b2346ad3a75c8f07e28124c4.1468397702.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id F37E5260851
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 11:46:20 +0200 (CEST)
In-Reply-To: <d3cf452fd17a9ae3b2346ad3a75c8f07e28124c4.1468397702.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@intel.com, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Jul 13 2016 17:44, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>
> Previously in text conf file, the uuid value of vendor tuples is a
> 16-characer string. Now change it to 16 characters separated by commas,
> easier for users to edit it manually.
>
> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
>
> diff --git a/include/topology.h b/include/topology.h
> index d666505..89bed6c 100644
> --- a/include/topology.h
> +++ b/include/topology.h
> @@ -273,8 +273,8 @@ extern "C" {
>    *		...
>    *	}
>    *
> - *	tuples."uuid" {
> - *		VENDOR_TOKEN_ID2 "16 character uuid"
> + *	tuples."uuid" {			# 16 characters separated by commas
> + *		VENDOR_TOKEN_ID2 "0x01,0x02,...,0x0f"
>    *		...
>    *	}
>    *
> diff --git a/src/topology/data.c b/src/topology/data.c
> index 7ff178f..65054d7 100644
> --- a/src/topology/data.c
> +++ b/src/topology/data.c
> @@ -176,6 +176,49 @@ static int get_hex_num(const char *str)
>   	return values;
>   }
>
> +/* get uuid from a string made by 16 characters separated by commas */
> +static int get_uuid(const char *str, unsigned char *uuid_le)

data.c:184:12: note: expected =91unsigned char *=92 but argument is of type =

=91char *=92
  static int get_uuid(const char *str, unsigned char *uuid_le)
             ^

> +{
> +	unsigned long int  val;
> +	char *tmp, *s =3D NULL;
> +	int values =3D 0, ret =3D 0;
> +
> +	tmp =3D strdup(str);
> +	if (tmp =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	s =3D strtok(tmp, ",");
> +
> +	while (s !=3D NULL) {
> +		errno =3D 0;
> +		val =3D strtoul(s, NULL, 0);
> +		if ((errno =3D=3D ERANGE && (val =3D=3D LONG_MAX || val =3D=3D LONG_MI=
N))

data.c: In function =91get_uuid=92:
data.c:199:51: warning: comparison between signed and unsigned integer =

expressions [-Wsign-compare]
    if ((errno =3D=3D ERANGE && (val =3D=3D LONG_MAX || val =3D=3D LONG_MIN=
))
                                                    ^

> +			|| (errno !=3D 0 && val =3D=3D 0)
> +			|| (val > UCHAR_MAX)) {
> +			SNDERR("error: invalid value for uuid\n");
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		 *(uuid_le + values) =3D (unsigned char)val;
> +
> +		values++;
> +		if (values >=3D 16)
> +			break;
> +
> +		s =3D strtok(NULL, ",");
> +	}
> +
> +	if (values < 16) {
> +		SNDERR("error: less than 16 integers for uuid\n");
> +		ret =3D -EINVAL;
> +	}
> +
> +out:
> +	free(tmp);
> +	return ret;
> +}
> +
>   static int write_hex(char *buf, char *str, int width)
>   {
>   	long val;
> @@ -536,14 +579,8 @@ static int parse_tuple_set(snd_tplg_t *tplg, snd_con=
fig_t *cfg,
>
>   		switch (type) {
>   		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
> -			len =3D strlen(value);
> -			if (len > 16 || len =3D=3D 0) {
> -				SNDERR("error: tuple %s: invalid uuid\n", id);
> +			if (get_uuid(value, tuple->uuid) < 0)
>   				goto err;
> -			}
> -
> -			memcpy(tuple->uuid, value, len);
> -			tplg_dbg("\t\t%s =3D %s\n", tuple->token, tuple->uuid);
>   			break;
>
>   		case SND_SOC_TPLG_TUPLE_TYPE_STRING:
>

Please work with compiler outputs, and pay enough attention to the =

persons to fix them...
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-July/110100.html


Regards

Takashi Sakamoto
