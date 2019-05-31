From: David Howells <dhowells@redhat.com>
Subject: [PATCH] rxrpc: Fix uninitialized error code in rxrpc_send_data_packet()
Date: Fri, 31 May 2019 11:34:44 +0100
Message-ID: <15499.1559298884@warthog.procyon.org.uk>
References: <20190528142424.19626-3-geert@linux-m68k.org> <20190528142424.19626-1-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528142424.19626-3-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dhowells@redhat.com, Igor Konopko <igor.j.konopko@intel.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Eran Ben Elisha <eranbe@mellanox.com>, Matias Bjorling <mb@lightnvm.io>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>, linux-block@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Hi Geert,

Here's my take on the patch.

David
---
rxrpc: Fix uninitialized error code in rxrpc_send_data_packet()    
    
With gcc 4.1:

    net/rxrpc/output.c: In function ‘rxrpc_send_data_packet’:
    net/rxrpc/output.c:338: warning: ‘ret’ may be used uninitialized in this function

Indeed, if the first jump to the send_fragmentable label is made, and
the address family is not handled in the switch() statement, ret will be
used uninitialized.

Fix this by BUG()'ing as is done in other places in rxrpc where internal
support for future address families will need adding.  It should not be
possible to reach this normally as the address families are checked
up-front.

Fixes: 5a924b8951f835b5 ("rxrpc: Don't store the rxrpc header in the Tx queue sk_buffs")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 004c762c2e8d..6f2b4fb4b0aa 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -523,6 +523,9 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct sk_buff *skb,
 		}
 		break;
 #endif
+
+	default:
+		BUG();
 	}
 
 	if (ret < 0)
