From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] rxrpc: Fix uninitialized error code in rxrpc_send_data_packet()
Date: Tue, 4 Jun 2019 09:35:16 +0200
Message-ID: <CAMuHMdXOikfh56DAHGpNUoRefbhYSbh=VK3J8EzZCXVLqZtEVw@mail.gmail.com>
References: <20190528142424.19626-1-geert@linux-m68k.org> <20190528142424.19626-3-geert@linux-m68k.org>
 <15499.1559298884@warthog.procyon.org.uk> <CAMuHMdX57DKCMpLXdtZPE-w0esUNVv9-SwYjmT5=m+u9ryAiHQ@mail.gmail.com>
 <9306.1559633653@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <9306.1559633653@warthog.procyon.org.uk>
Sender: netdev-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Igor Konopko <igor.j.konopko@intel.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Eran Ben Elisha <eranbe@mellanox.com>, Matias Bjorling <mb@lightnvm.io>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>, linux-block@vger.kernel.org, netdev <netdev@vger.kernel.org>, linux-afs@lists.infradead.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.>
List-Id: alsa-devel@alsa-project.org

Hi David,

On Tue, Jun 4, 2019 at 9:34 AM David Howells <dhowells@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > I'm not such a big fan of BUG(), so I'd go for ret = -EAFNOSUPPORT, but given
> > rxrpc is already full of BUG() calls, I guess it is an acceptable solution.
>
> Okay.  Are you okay with this going through net-next?

Yes, I am.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
