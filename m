From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] rawmidi: virtual: fix reading into a small
	buffer
Date: Sun, 19 Mar 2017 15:23:11 +0900
Message-ID: <f1a2ca77-78d6-538c-bc06-6c770a99a8e8@sakamocchi.jp>
References: <b91aca79-8808-0cc4-ff3b-ad7ea16dec4b@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 3CD682665D5
 for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2017 07:23:16 +0100 (CET)
In-Reply-To: <b91aca79-8808-0cc4-ff3b-ad7ea16dec4b@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 19 2017 07:10, Clemens Ladisch wrote:
> In the special case for handling partial messages, the pointer
> calculations were wrong, which would result in data corruption.
>
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> --- alsa-lib/src/rawmidi/rawmidi_virt.c
> +++ alsa-lib/src/rawmidi/rawmidi_virt.c
> @@ -263,8 +263,8 @@ static ssize_t snd_rawmidi_virtual_read(snd_rawmidi_t *rmidi, void *buffer, size
>  		}
>  		size1 = virt->in_buf_size - virt->in_buf_ofs;
>  		if ((size_t)size1 > size) {
> -			virt->in_buf_ofs += size1 - size;
> -			memcpy(buffer, virt->in_buf_ptr, size);
> +			memcpy(buffer, virt->in_buf_ptr + virt->in_buf_ofs, size);
> +			virt->in_buf_ofs += size;
>  			result += size;
>  			break;
>  		}


Regards

Takashi Sakamoto
