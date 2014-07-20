From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH -next] ALSA: bebob: Fix missing unlock on
	error in special_clk_ctl_put()
Date: Sun, 20 Jul 2014 16:51:52 +0900
Message-ID: <53CB7518.9080502@sakamocchi.jp>
References: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DEA5262626
 for <alsa-devel@alsa-project.org>; Sun, 20 Jul 2014 09:51:59 +0200 (CEST)
In-Reply-To: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: weiyj_lk@163.com, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Wei,

Thanks for this patch, while I found the other issues in this file. I
would like to post new patches instead of yours, later.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp

(Jul 20 2014 13:50), weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing unlock before return from function
> special_clk_ctl_put() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn> --- 
> sound/firewire/bebob/bebob_maudio.c | 4 +++- 1 file changed, 3
> insertions(+), 1 deletion(-)
> 
> diff --git a/sound/firewire/bebob/bebob_maudio.c
> b/sound/firewire/bebob/bebob_maudio.c index 6af50eb..6748515
> 100644 --- a/sound/firewire/bebob/bebob_maudio.c +++
> b/sound/firewire/bebob/bebob_maudio.c @@ -382,8 +382,10 @@ static
> int special_clk_ctl_put(struct snd_kcontrol *kctl, 
> mutex_lock(&bebob->mutex);
> 
> id = uval->value.enumerated.item[0]; -	if (id >=
> ARRAY_SIZE(special_clk_labels)) +	if (id >=
> ARRAY_SIZE(special_clk_labels)) { +		mutex_unlock(&bebob->mutex); 
> return 0; +	}
> 
> err = avc_maudio_set_special_clk(bebob, id, params->dig_in_fmt,
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTy3UIAAoJENbkvsBXhK8as9AH+wYN2lxFlzBdMhPgRigp/bkv
mw770Hpyb50TE3ILkIcGpgec1TFrK/QwQjUmunmJLQnvXPBNVNGiVaKsOhhHwmqG
7hDWp8swTSdxZQeSFWjjxAc+AntjEoUkOdiwclzT+1M1tO1vjZdRoXAos4o3G6Od
xKSl0xO4Qi+Wv6ib1p5yneOKEGZLmEZTLJY2PXXKhHQjybzYS1cRRlK9+afJYLhT
sEHPknz00OCbvFRAXIK0GMuaQzncZOFYA2Ovczei7Y+ugJuGJbvNfxhxYO6j7Zc6
j1dE79iBY0hhH32zdUn7zcWR8Zbxbpfv8oA0dkeQRisV3RB9F2P7bSKHtNj0cOw=
=Or5u
-----END PGP SIGNATURE-----
