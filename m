From: Ivan Sorokin <vanyacpp@gmail.com>
Subject: Re: valgrind error in snd_tlv_get_dB_range
Date: Sun, 19 Jan 2014 16:22:47 +0400
Message-ID: <52DBC397.5020704@gmail.com>
References: <52DBA5EB.3070104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id CE369261692
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2014 13:14:40 +0100 (CET)
Received: by mail-lb0-f169.google.com with SMTP id q8so4269944lbi.0
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2014 04:14:40 -0800 (PST)
Received: from [10.77.16.222] ([83.243.72.90])
 by mx.google.com with ESMTPSA id mv9sm11258687lbc.0.2014.01.19.04.14.39
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 19 Jan 2014 04:14:39 -0800 (PST)
In-Reply-To: <52DBA5EB.3070104@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19.01.2014 14:16, Ivan Sorokin wrote:

> I tried to trace problem in snd_hctl_elem_tlv_read, but I failed to do
> so due to lack of experience with alsa-lib.
>
> Could someone more experienced with alsa-lib look at the problem?

After a bit more investigation I've found that tlv is initialized in 
snd_ctl_hw_elem_tlv with memcpy in line 245. This initialization looks 
perfectly correct. So perhaps this is a error in valgrind (unimplemented 
ioctl).

P.S. I believe I found a memory leak:

> 	switch (op_flag) {
> 	case -1: inum = SNDRV_CTL_IOCTL_TLV_COMMAND; break;
>  	case 0:	inum = SNDRV_CTL_IOCTL_TLV_READ; break;
> 	case 1:	inum = SNDRV_CTL_IOCTL_TLV_WRITE; break;
> 	default: return -EINVAL;
> 	}
> 	xtlv = malloc(sizeof(struct snd_ctl_tlv) + tlv_size);
> 	if (xtlv == NULL)
> 		return -ENOMEM;
> 	xtlv->numid = numid;
> 	xtlv->length = tlv_size;
> 	memcpy(xtlv->tlv, tlv, tlv_size);
> 	if (ioctl(hw->fd, inum, xtlv) < 0) {
> 		free(xtlv);
> 		return -errno;
> 	}
> 	if (op_flag == 0) {
> 		if (xtlv->tlv[1] + 2 * sizeof(unsigned int) > tlv_size)

missing free(xtlv) here

> 			return -EFAULT;
> 		memcpy(tlv, xtlv->tlv, xtlv->tlv[1] + 2 * sizeof(unsigned int));
> 	}
> 	free(xtlv);
> 	return 0;
