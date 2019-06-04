From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] rxrpc: Fix uninitialized error code in rxrpc_send_data_packet()
Date: Tue, 4 Jun 2019 09:17:23 +0200
Message-ID: <CAMuHMdX57DKCMpLXdtZPE-w0esUNVv9-SwYjmT5=m+u9ryAiHQ@mail.gmail.com>
References: <20190528142424.19626-1-geert@linux-m68k.org> <20190528142424.19626-3-geert@linux-m68k.org>
 <15499.1559298884@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15499.1559298884@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Igor Konopko <igor.j.konopko@intel.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Eran Ben Elisha <eranbe@mellanox.com>, Matias Bjorling <mb@lightnvm.io>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>, linux-block@vger.kernel.org, netdev <netdev@vger.kernel.org>, linux-afs@lists.infradead.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.>
List-Id: alsa-devel@alsa-project.org

Hi David,

On Fri, May 31, 2019 at 12:35 PM David Howells <dhowells@redhat.com> wrote:
> Here's my take on the patch.
>
> David
> ---
> rxrpc: Fix uninitialized error code in rxrpc_send_data_packet()
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
> Fix this by BUG()'ing as is done in other places in rxrpc where internal
> support for future address families will need adding.  It should not be
> possible to reach this normally as the address families are checked
> up-front.
>
> Fixes: 5a924b8951f835b5 ("rxrpc: Don't store the rxrpc header in the Tx queue sk_buffs")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: David Howells <dhowells@redhat.com>

I'm not such a big fan of BUG(), so I'd go for ret = -EAFNOSUPPORT, but given
rxrpc is already full of BUG() calls, I guess it is an acceptable solution.

> ---
> diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
> index 004c762c2e8d..6f2b4fb4b0aa 100644
> --- a/net/rxrpc/output.c
> +++ b/net/rxrpc/output.c
> @@ -523,6 +523,9 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
>                 }
>                 break;
>  #endif
> +
> +       default:
> +               BUG();
>         }
>
>         if (ret < 0)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
