From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [bug report] ALSA: firewire-motu: add support for
 MOTU 828mk3 (FireWire/Hybrid) as a model with protocol version 3
Date: Fri, 31 Mar 2017 22:29:52 +0900
Message-ID: <821f7035-9f0d-ad48-f124-534b14ccae8f@sakamocchi.jp>
References: <20170331123859.GA30666@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id A357C26691F
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:29:57 +0200 (CEST)
In-Reply-To: <20170331123859.GA30666@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Dan,

On Mar 31 2017 21:50, Dan Carpenter wrote:
> Hello Takashi Sakamoto,
>
> The patch 5992e30034c4: "ALSA: firewire-motu: add support for MOTU
> 828mk3 (FireWire/Hybrid) as a model with protocol version 3" from Mar
> 22, 2017, leads to the following static checker warning:
>
> 	sound/firewire/motu/motu-protocol-v3.c:104 v3_get_clock_source()
> 	warn: mask and shift to zero
>
> sound/firewire/motu/motu-protocol-v3.c
>     90  static int v3_get_clock_source(struct snd_motu *motu,
>     91                                 enum snd_motu_clock_source *src)
>     92  {
>     93          __be32 reg;
>     94          u32 data;
>     95          unsigned int val;
>     96          int err;
>     97
>     98          err = snd_motu_transaction_read(motu, V3_CLOCK_STATUS_OFFSET, &reg,
>     99                                          sizeof(reg));
>    100          if (err < 0)
>    101                  return err;
>    102          data = be32_to_cpu(reg);
>    103
>    104          val = (data & V3_CLOCK_SOURCE_MASK) >> V3_CLOCK_SOURCE_SHIFT;
>                               0xff >> 8
>
> val is always zero.  These are the only places we use
> V3_CLOCK_SOURCE_MASK and V3_CLOCK_SOURCE_SHIFT so I have no idea what
> it should be.
>
>    105          if (val == 0x00) {
>    106                  *src = SND_MOTU_CLOCK_SOURCE_INTERNAL;
>    107          } else if (val == 0x01) {
>    108                  *src = SND_MOTU_CLOCK_SOURCE_WORD_ON_BNC;
>    109          } else if (val == 0x10) {
>    110                  *src = SND_MOTU_CLOCK_SOURCE_SPDIF_ON_COAX;
>    111          } else if (val == 0x18 || val == 0x19) {
>    112                  err = snd_motu_transaction_read(motu, V3_OPT_IFACE_MODE_OFFSET,
>    113                                                  &reg, sizeof(reg));
>    114                  if (err < 0)
>    115                          return err;

Indeed. It's my mistake.

LSB of the register represents current source of clock, thus no need to 
shift. I'll post fix this weekend.


Thanks

Takashi Sakamoto
