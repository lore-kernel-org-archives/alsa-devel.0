From: gianluca <gianlucarenzi@eurekelettronica.it>
Subject: Re: Fwd: Issue on Linux 4.12-rc7 on iMX6 based board
Date: Thu, 29 Jun 2017 18:59:35 +0200
Message-ID: <ca7f3a42-e56b-8980-da75-8ed15bfd4290@eurekelettronica.it>
References: <7ab79167-fa6c-4aea-0545-48d0522d5d77@eurekelettronica.it>
 <d7d15b1d-ac7f-4b45-b7e6-e4cdc0d5cc65@eurekelettronica.it>
 <CAOMZO5C1HSN2m4P34GQq2+SKB+kmm9WUjr37T_Q_W6LwCQQQFQ@mail.gmail.com>
 <2cb47b9c-d631-6fe0-8e5c-3f1d2604ab0d@eurekelettronica.it>
 <CAOMZO5CYw-eoOuaP6Tb3c51va9ua7gvg2mTz+kX7fYtQdhsK+w@mail.gmail.com>
 <c19fa7f1-17f3-1bd0-81a2-a916fac8c1ab@eurekelettronica.it>
 <CAOMZO5CnuSim+vXB7eTBDV_PFrNf9Hgpj6AJea9hnELjaVdsTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qmail.e-mind.com (qmail34.e-mind.com [188.94.192.34])
 by alsa0.perex.cz (Postfix) with SMTP id 70A702673D3
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 18:59:42 +0200 (CEST)
In-Reply-To: <CAOMZO5CnuSim+vXB7eTBDV_PFrNf9Hgpj6AJea9hnELjaVdsTg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06/29/2017 04:30 PM, Fabio Estevam wrote:
>
> Most of the boards use 0x130b0. You should really check with a scope
> and see if the MCLK is getting to the codec.
> I suppose it is as the driver can read its ID register correctly.
>
>> I am missing the regmap. Should I configure kernel with additional CONFIG_ ?
>
> mount -t debugfs none /sys/kernel/debug

Here we go!

> root@edelin:/sys/kernel/debug/regmap/0-000a# cat registers
> 000: a011
> 002: 0060
> 004: 0008
> 006: 0080
> 00a: 0010
> 00e: 020c
> 010: fcfc
> 014: 015f
> 020: 0000
> 022: 4000
> 024: 0022
> 026: 0068
> 028: 01f1
> 02a: 0200
> 02c: 0322
> 02e: 0d0d
> 030: 7260
> 032: 5000
> 034: 0000
> 036: 0017
> 03a: 0000
> 03c: 0000
> 100: 0000
> 102: 0000
> 104: 0040
> 106: 051f
> 108: 0000
> 10a: 0040
> 10c: 0000
> 10e: 0000
> 110: 0000
> 116: 002f
> 118: 002f
> 11a: 002f
> 11c: 002f
> 11e: 002f
> 120: 8000
> 122: 0000
> 124: 0510
> 126: 1473
> 128: 0028
> 12a: 0050
> 12c: 0000
> 12e: 0000
> 130: 0000
> 132: 0000
> 134: 0000
> 136: 0000
> 138: 0000
> 13a: 0000

now access:

> root@edelin:/sys/kernel/debug/regmap/0-000a# cat access
> 000: y y y n
> 002: y y n n
> 004: y y n n
> 006: y y n n
> 008: n y n n
> 00a: y y n n
> 00c: n y n n
> 00e: y y y n
> 010: y y n n
> 012: n y n n
> 014: y y n n
> 016: n y n n
> 018: n y n n
> 01a: n y n n
> 01c: n y n n
> 01e: n y n n
> 020: y y n n
> 022: y y n n
> 024: y y n n
> 026: y y n n
> 028: y y n n
> 02a: y y n n
> 02c: y y n n
> 02e: y y n n
> 030: y y n n
> 032: y y n n
> 034: y y n n
> 036: y y y n
> 038: n y n n
> 03a: y y n n
> 03c: y y n n
> 03e: n y n n
> 040: n y n n
> 042: n y n n
> 044: n y n n
> 046: n y n n
> 048: n y n n
> 04a: n y n n
> 04c: n y n n
> 04e: n y n n
> 050: n y n n
> 052: n y n n
> 054: n y n n
> 056: n y n n
> 058: n y n n
> 05a: n y n n
> 05c: n y n n
> 05e: n y n n
> 060: n y n n
> 062: n y n n
> 064: n y n n
> 066: n y n n
> 068: n y n n
> 06a: n y n n
> 06c: n y n n
> 06e: n y n n
> 070: n y n n
> 072: n y n n
> 074: n y n n
> 076: n y n n
> 078: n y n n
> 07a: n y n n
> 07c: n y n n
> 07e: n y n n
> 080: n y n n
> 082: n y n n
> 084: n y n n
> 086: n y n n
> 088: n y n n
> 08a: n y n n
> 08c: n y n n
> 08e: n y n n
> 090: n y n n
> 092: n y n n
> 094: n y n n
> 096: n y n n
> 098: n y n n
> 09a: n y n n
> 09c: n y n n
> 09e: n y n n
> 0a0: n y n n
> 0a2: n y n n
> 0a4: n y n n
> 0a6: n y n n
> 0a8: n y n n
> 0aa: n y n n
> 0ac: n y n n
> 0ae: n y n n
> 0b0: n y n n
> 0b2: n y n n
> 0b4: n y n n
> 0b6: n y n n
> 0b8: n y n n
> 0ba: n y n n
> 0bc: n y n n
> 0be: n y n n
> 0c0: n y n n
> 0c2: n y n n
> 0c4: n y n n
> 0c6: n y n n
> 0c8: n y n n
> 0ca: n y n n
> 0cc: n y n n
> 0ce: n y n n
> 0d0: n y n n
> 0d2: n y n n
> 0d4: n y n n
> 0d6: n y n n
> 0d8: n y n n
> 0da: n y n n
> 0dc: n y n n
> 0de: n y n n
> 0e0: n y n n
> 0e2: n y n n
> 0e4: n y n n
> 0e6: n y n n
> 0e8: n y n n
> 0ea: n y n n
> 0ec: n y n n
> 0ee: n y n n
> 0f0: n y n n
> 0f2: n y n n
> 0f4: n y n n
> 0f6: n y n n
> 0f8: n y n n
> 0fa: n y n n
> 0fc: n y n n
> 0fe: n y n n
> 100: y y n n
> 102: y y n n
> 104: y y n n
> 106: y y n n
> 108: y y n n
> 10a: y y n n
> 10c: y y n n
> 10e: y y n n
> 110: y y n n
> 112: n y n n
> 114: n y n n
> 116: y y n n
> 118: y y n n
> 11a: y y n n
> 11c: y y n n
> 11e: y y n n
> 120: y y n n
> 122: y y n n
> 124: y y n n
> 126: y y n n
> 128: y y n n
> 12a: y y n n
> 12c: y y n n
> 12e: y y n n
> 130: y y n n
> 132: y y n n
> 134: y y n n
> 136: y y n n
> 138: y y n n
> 13a: y y n n


cache-bypass
> root@edelin:/sys/kernel/debug/regmap/0-000a# cat cache_bypass
> N

cache-dirty
> root@edelin:/sys/kernel/debug/regmap/0-000a# cat cache_dirty
> N

cache-only
> root@edelin:/sys/kernel/debug/regmap/0-000a# cat cache_only
> N

name
> root@edelin:/sys/kernel/debug/regmap/0-000a# cat name
> sgtl5000

range
> root@edelin:/sys/kernel/debug/regmap/0-000a# cat range
> 0-6
> a-a
> e-10
> 14-14
> 20-36
> 3a-3c
> 100-110
> 116-13a

rbtree
> root@edelin:/sys/kernel/debug/regmap/0-000a# cat rbtree
> 2-3c (30)
> 100-13a (30)
> 2 nodes, 60 registers, average 30 registers, used 192 bytes


and now the ssi node:

> root@edelin:/sys/kernel/debug/regmap/2028000.ssi# ll
> total 0
> -r-------- 1 root root 0 Jan  1 00:00 access
> -rw------- 1 root root 0 Jan  1 00:00 cache_bypass
> -r-------- 1 root root 0 Jan  1 00:00 cache_dirty
> -rw------- 1 root root 0 Jan  1 00:00 cache_only
> -r-------- 1 root root 0 Jan  1 00:00 name
> -r-------- 1 root root 0 Jan  1 00:00 range
> -r-------- 1 root root 0 Jan  1 00:00 registers

> root@edelin:/sys/kernel/debug/regmap/2028000.ssi# cat name
> fsl-ssi-dai

> root@edelin:/sys/kernel/debug/regmap/2028000.ssi# cat registers
> 00: 00000000
> 04: 00000000
> 10: 00001058
> 18: 00003003
> 1c: 0000020d
> 20: 0000020d
> 24: 00040100
> 28: 00040100
> 2c: 00880088
> 30: 00000000
> 34: 00000000
> 38: 00000000
> 48: 00000000
> 4c: 00000000
> 50: 00000000
> 54: 00000000
> 58: 00000000

> root@edelin:/sys/kernel/debug/regmap/2028000.ssi# cat cache_bypass
> N

> root@edelin:/sys/kernel/debug/regmap/2028000.ssi# cat cache_dirty
> N

> root@edelin:/sys/kernel/debug/regmap/2028000.ssi# cat cache_only
> N

> root@edelin:/sys/kernel/debug/regmap/2028000.ssi# cat range
> 0-4
> 10-10
> 18-38
> 48-58

> root@edelin:/sys/kernel/debug/regmap/2028000.ssi# cat access
> 00: y y y n
> 04: y y y n
> 08: y n y y
> 0c: y n y y
> 10: y y n n
> 14: y y y y
> 18: y y n n
> 1c: y y n n
> 20: y y n n
> 24: y y n n
> 28: y y n n
> 2c: y y y n
> 30: y y n n
> 34: y y y n
> 38: y y y n
> 3c: y y y y
> 40: y y y y
> 44: y y y y
> 48: y y n n
> 4c: y y n n
> 50: y n y n
> 54: n y n n
> 58: n y n n

Now the pinmux

> device 21d8000.audmux
> state default
> type MUX_GROUP (2)
> controlling device 20e0000.iomuxc
> group audmuxgrp
> function imx6qp-ek360
>
> device 21d8000.audmux
> state default
> type CONFIGS_PIN (3)
> controlling device 20e0000.iomuxc
> pin MX6Q_PAD_CSI0_DAT7
> config 000130b0
>
> device 21d8000.audmux
> state default
> type CONFIGS_PIN (3)
> controlling device 20e0000.iomuxc
> pin MX6Q_PAD_CSI0_DAT4
> config 000130b0
>
> device 21d8000.audmux
> state default
> type CONFIGS_PIN (3)
> controlling device 20e0000.iomuxc
> pin MX6Q_PAD_CSI0_DAT5
> config 000110b0
>
> device 21d8000.audmux
> state default
> type CONFIGS_PIN (3)
> controlling device 20e0000.iomuxc
> pin MX6Q_PAD_CSI0_DAT6
> config 000130b0

>
> Pinctrl maps:
> device 20e0000.iomuxc
> state default
> type MUX_GROUP (2)
> controlling device 20e0000.iomuxc
> group hoggrp
> function imx6qp-ek360
>
> device 20e0000.iomuxc
> state default
> type CONFIGS_PIN (3)
> controlling device 20e0000.iomuxc
> pin MX6Q_PAD_GPIO_0
> config 000030b0

Now the Audio System On Chip (ASOC)
>
> root@edelin:/sys/kernel/debug/asoc# ls
> codecs  dais  imx6-ek360-sgtl5000  platforms
> root@edelin:/sys/kernel/debug/asoc# cat codecs
> sgtl5000.0-000a
> snd-soc-dummy
> root@edelin:/sys/kernel/debug/asoc# cat dais
> 2034000.asrc
> 2028000.ssi
> sgtl5000
> snd-soc-dummy-dai
> root@edelin:/sys/kernel/debug/asoc# cat platforms
> 2034000.asrc
> 2028000.ssi
> snd-soc-dummy

Any other value? :-/

> You should check in this scope if your getting SSI clock/data when
> playing audio.
>

The biggest problem is to solder into the pins of the sgtl5000. I have a 
signal analyzer (Saleae) but it need some wires to get the job done.

I would like to solve the problem by software first. I cannot believe a 
hardware problem...

Regards,
-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
