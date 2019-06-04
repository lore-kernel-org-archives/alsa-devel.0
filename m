From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] rxrpc: Fix uninitialized error code in
	rxrpc_send_data_packet()
Date: Tue, 04 Jun 2019 08:34:13 +0100
Message-ID: <9306.1559633653@warthog.procyon.org.uk>
References: <CAMuHMdX57DKCMpLXdtZPE-w0esUNVv9-SwYjmT5=m+u9ryAiHQ@mail.gmail.com>
 <20190528142424.19626-1-geert@linux-m68k.org>
 <20190528142424.19626-3-geert@linux-m68k.org>
 <15499.1559298884@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D18EF896CE
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2019 09:34:42 +0200 (CEST)
In-Reply-To: <CAMuHMdX57DKCMpLXdtZPE-w0esUNVv9-SwYjmT5=m+u9ryAiHQ@mail.gmail.com>
Content-ID: <9305.1559633653.1@warthog.procyon.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-block@vger.kernel.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-afs@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S . Miller" <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Clemens Ladisch <clemens@ladisch.de>, Jamal Hadi Salim <jhs@mojatatu.com>, dhowells@redhat.com, Jiri Pirko <jiri@mellanox.com>, Cong Wang <xiyou.wangcong@gmail.com>, Joe Perches <joe@perches.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Matias Bjorling <mb@lightnvm.io>, Eran Ben Elisha <eranbe@mellanox.com>, Dan Carpenter <dan.carpenter@oracle.com>, Igor Konopko <igor.j.konopko@intel.com>
List-Id: alsa-devel@alsa-project.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> I'm not such a big fan of BUG(), so I'd go for ret = -EAFNOSUPPORT, but given
> rxrpc is already full of BUG() calls, I guess it is an acceptable solution.

Okay.  Are you okay with this going through net-next?

David
