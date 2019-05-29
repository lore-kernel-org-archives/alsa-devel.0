From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Subject: Re: [PATCH 1/5] lightnvm: Fix uninitialized pointer in
 nvm_remove_tgt()
Date: Wed, 29 May 2019 10:08:24 +0200
Message-ID: <4b666e32-04b6-228a-691d-0745fa48a57f@lightnvm.io>
References: <20190528142424.19626-1-geert@linux-m68k.org>
 <20190528142424.19626-2-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190528142424.19626-2-geert@linux-m68k.org>
Content-Language: en-GB
Sender: netdev-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Igor Konopko <igor.j.konopko@intel.com>, David Howells <dhowells@redhat.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Eran Ben Elisha <eranbe@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-block@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 5/28/19 4:24 PM, Geert Uytterhoeven wrote:
> With gcc 4.1:
> 
>      drivers/lightnvm/core.c: In function ‘nvm_remove_tgt’:
>      drivers/lightnvm/core.c:510: warning: ‘t’ is used uninitialized in this function
> 
> Indeed, if no NVM devices have been registered, t will be an
> uninitialized pointer, and may be dereferenced later.  A call to
> nvm_remove_tgt() can be triggered from userspace by issuing the
> NVM_DEV_REMOVE ioctl on the lightnvm control device.
> 
> Fix this by preinitializing t to NULL.
> 
> Fixes: 843f2edbdde085b4 ("lightnvm: do not remove instance under global lock")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   drivers/lightnvm/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 0df7454832efe082..aa017f48eb8c588c 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -492,7 +492,7 @@ static void __nvm_remove_target(struct nvm_target *t, bool graceful)
>    */
>   static int nvm_remove_tgt(struct nvm_ioctl_remove *remove)
>   {
> -	struct nvm_target *t;
> +	struct nvm_target *t = NULL;
>   	struct nvm_dev *dev;
>   
>   	down_read(&nvm_lock);
> 

Thanks Geert. Would you like me to carry the patch?
