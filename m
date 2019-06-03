From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] rxrpc: Fix uninitialized error code in
 rxrpc_send_data_packet()
Date: Mon, 03 Jun 2019 14:30:54 -0700 (PDT)
Message-ID: <20190603.143054.1734848612616501920.davem@davemloft.net>
References: <20190528142424.19626-3-geert@linux-m68k.org>
 <20190528142424.19626-1-geert@linux-m68k.org>
 <15499.1559298884@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68EDEF896CE
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 23:31:03 +0200 (CEST)
In-Reply-To: <15499.1559298884@warthog.procyon.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: dhowells@redhat.com
Cc: alsa-devel@alsa-project.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, netdev@vger.kernel.org, tiwai@suse.com, clemens@ladisch.de, jhs@mojatatu.com, linux-block@vger.kernel.org, jiri@mellanox.com, geert@linux-m68k.org, xiyou.wangcong@gmail.com, joe@perches.com, tahiliani@nitk.edu.in, mb@lightnvm.io, eranbe@mellanox.com, dan.carpenter@oracle.com, igor.j.konopko@intel.com
List-Id: alsa-devel@alsa-project.org

From: David Howells <dhowells@redhat.com>
Date: Fri, 31 May 2019 11:34:44 +0100

> Here's my take on the patch.

I assume I'll see a final version of this under separate cover.
