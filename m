From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/5] rxrpc: Fix uninitialized error code in rxrpc_send_data_packet()
Date: Tue, 28 May 2019 17:30:19 +0100
Message-ID: <4654.1559061019@warthog.procyon.org.uk>
References: <20190528142424.19626-3-geert@linux-m68k.org> <20190528142424.19626-1-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528142424.19626-3-geert@linux-m68k.org>
Content-ID: <4653.1559061019.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dhowells@redhat.com, Igor Konopko <igor.j.konopko@intel.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Eran Ben Elisha <eranbe@mellanox.com>, Matias Bjorling <mb@lightnvm.io>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>, linux-block@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> While this is not a real false-positive, I believe it cannot cause harm
> in practice, as AF_RXRPC cannot be used with other transport families
> than IPv4 and IPv6.

Agreed.

> ---
>  net/rxrpc/output.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
> index 004c762c2e8d063c..1473d774d67100c5 100644
> --- a/net/rxrpc/output.c
> +++ b/net/rxrpc/output.c
> @@ -403,8 +403,10 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
>  
>  	/* send the packet with the don't fragment bit set if we currently
>  	 * think it's small enough */
> -	if (iov[1].iov_len >= call->peer->maxdata)
> +	if (iov[1].iov_len >= call->peer->maxdata) {
> +		ret = 0;
>  		goto send_fragmentable;
> +	}
>  
>  	down_read(&conn->params.local->defrag_sem);
>  

Simply setting 0 is wrong.  That would give the impression that the thing
worked if support for a new transport address family was added and came
through this function without full modification (say AF_INET7 becomes a
thing).

A better way to do things would be to add a default case into the
send_fragmentable switch statement that either BUG's or sets -EAFNOSUPPORT.

David
