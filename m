From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4] ucm: add cset-tlv
Date: Wed, 13 Apr 2016 14:27:40 +0530
Message-ID: <20160413085740.GK2274@localhost>
References: <1460528817-25598-1-git-send-email-hychao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 73F032604D6
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 10:53:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1460528817-25598-1-git-send-email-hychao@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 13, 2016 at 02:26:57PM +0800, Hsin-Yu Chao wrote:
> +	sz_read = read(fd, *res, sz);
> +	if (sz_read < 0 || (size_t)sz_read != sz) {
> +		err = -EIO;
> +		free(*res);
> +		*res = NULL;
> +	}
> +	/* Check if the tlv file specifies valid size. */
> +	tlv = (unsigned int *)(*res);
> +	if (tlv[1] + 2 * sizeof(unsigned int) != sz) {

why not use snd_ctl_tlv(), my assumption is that you are expecting a type,
length and values in the buffer

> +		uc_error("Invalid tlv size");

wouldn't it help to print the size for error

> +		err = -EINVAL;
> +		free(*res);
> +		*res = NULL;
> +	}
> +
> +      __fail:

I dont know about syntax expected in UCM but this label could be left
justfied :)

> +	close(fd);
> +	return err;
> +}
> +
>  static int binary_file_parse(snd_ctl_elem_value_t *dst,
>  			      snd_ctl_elem_info_t *info,
>  			      const char *filepath)
> @@ -226,6 +276,7 @@ static int execute_cset(snd_ctl_t *ctl, const char *cset, unsigned int type)
>  	snd_ctl_elem_id_t *id;
>  	snd_ctl_elem_value_t *value;
>  	snd_ctl_elem_info_t *info;
> +	char *res = NULL;
>  
>  	snd_ctl_elem_id_malloc(&id);
>  	snd_ctl_elem_value_malloc(&value);
> @@ -241,23 +292,36 @@ static int execute_cset(snd_ctl_t *ctl, const char *cset, unsigned int type)
>  		err = -EINVAL;
>  		goto __fail;
>  	}
> -	snd_ctl_elem_value_set_id(value, id);
>  	snd_ctl_elem_info_set_id(info, id);
> -	err = snd_ctl_elem_read(ctl, value);
> -	if (err < 0)
> -		goto __fail;
>  	err = snd_ctl_elem_info(ctl, info);
>  	if (err < 0)
>  		goto __fail;
> -	if (type == SEQUENCE_ELEMENT_TYPE_CSET_BIN_FILE)
> -		err = binary_file_parse(value, info, pos);
> -	else
> -		err = snd_ctl_ascii_value_parse(ctl, value, info, pos);
> -	if (err < 0)
> -		goto __fail;
> -	err = snd_ctl_elem_write(ctl, value);
> -	if (err < 0)
> -		goto __fail;
> +	if (type == SEQUENCE_ELEMENT_TYPE_CSET_TLV) {
> +		if (!snd_ctl_elem_info_is_tlv_writable(info)) {
> +			err = -EINVAL;
> +			goto __fail;
> +		}
> +		err = read_tlv_file(&res, pos);
> +		if (err < 0)
> +			goto __fail;
> +		err = snd_ctl_elem_tlv_write(ctl, id, (unsigned int *)res);

if tlv_write expects unsigned int then wouldn't it be better to use
read_tlv_file() with unsigned int.

-- 
~Vinod
