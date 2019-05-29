From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] rxrpc: Fix uninitialized error code in rxrpc_send_data_packet()
Date: Wed, 29 May 2019 13:49:52 +0200
Message-ID: <CAK8P3a1wTED5Aet_9AjY9VFFrutkV2xK6C13vroTLd0vpcoo9w@mail.gmail.com>
References: <20190528142424.19626-1-geert@linux-m68k.org> <20190528142424.19626-3-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528142424.19626-3-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Igor Konopko <igor.j.konopko@intel.com>, David Howells <dhowells@redhat.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Eran Ben Elisha <eranbe@mellanox.com>, Matias Bjorling <mb@lightnvm.io>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-block <linux-block@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-afs@lists.infradead.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux
List-Id: alsa-devel@alsa-project.org

On Tue, May 28, 2019 at 4:24 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> With gcc 4.1:
>
>     net/rxrpc/output.c: In function ‘rxrpc_send_data_packet’:
>     net/rxrpc/output.c:338: warning: ‘ret’ may be used uninitialized in this function
>
> Indeed, if the first jump to the send_fragmentable label is made, and
> the address family is not handled in the switch() statement, ret will be
> used uninitialized.
>
> Fix this by initializing err to zero before the jump, like is already
> done for the jump to the done label.
>
> Fixes: 5a924b8951f835b5 ("rxrpc: Don't store the rxrpc header in the Tx queue sk_buffs")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> While this is not a real false-positive, I believe it cannot cause harm
> in practice, as AF_RXRPC cannot be used with other transport families
> than IPv4 and IPv6.

This looks like a variant of the infamous bug
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=18501

What I don't understand is why clang fails to warn about it with
-Wsometimes-uninitialized.
(cc clang-built-linux mailing list).

      Arnd

>  net/rxrpc/output.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
> index 004c762c2e8d063c..1473d774d67100c5 100644
> --- a/net/rxrpc/output.c
> +++ b/net/rxrpc/output.c
> @@ -403,8 +403,10 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
>
>         /* send the packet with the don't fragment bit set if we currently
>          * think it's small enough */
> -       if (iov[1].iov_len >= call->peer->maxdata)
> +       if (iov[1].iov_len >= call->peer->maxdata) {
> +               ret = 0;
>                 goto send_fragmentable;
> +       }
>
>         down_read(&conn->params.local->defrag_sem);
>
