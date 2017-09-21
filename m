From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 4/4] ALSA: emu10k1: Cocci spatch
	"alloc_cast"
Date: Thu, 21 Sep 2017 18:39:15 +0100
Message-ID: <20170921173914.GK32076@ZenIV.linux.org.uk>
References: <1505975570447-826702259-0-diffsplit-thomas@m3y3r.de>
 <1505975570447-568224618-4-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D420267607
 for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2017 19:39:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1505975570447-568224618-4-diffsplit-thomas@m3y3r.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 21, 2017 at 08:33:46AM +0200, Thomas Meyer wrote:
> Remove casting the values returned by memory allocation functions like
> kmalloc, kzalloc, kmem_cache_alloc, kmem_cache_zalloc etc."
> Found by coccinelle spatch "api/alloc/alloc_cast.cocci"
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 
> diff -u -p a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
> --- a/sound/pci/emu10k1/emufx.c
> +++ b/sound/pci/emu10k1/emufx.c
> @@ -1218,7 +1218,7 @@ static int _snd_emu10k1_audigy_init_efx(
>  	if (!icode)
>  		return err;
>  
> -	icode->gpr_map = (u_int32_t __user *) kcalloc(512 + 256 + 256 + 2 * 1024,
> +	icode->gpr_map = kcalloc(512 + 256 + 256 + 2 * 1024,
>  						      sizeof(u_int32_t), GFP_KERNEL);

	And _this_ is a wonderful example of the reasons why that kind of
patches is bloody bad.  The code you've caught is very obviously smelly -
kcalloc() does *NOT* return a userland pointer.  You are whitewashing it;
a major "something weird is going on here" sign is gone (something weird
in that case is hopefully a set_fs(KERNEL_DS) somewhere nearby, and it
is asking for careful review).

	FWIW, any patches of that sort anywhere near VFS are very much not welcome.
