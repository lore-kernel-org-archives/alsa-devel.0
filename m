From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: ASoC: wm9712 / AC97 probe causes regmap oops
Date: Tue, 31 Jul 2012 10:39:11 +0200
Message-ID: <CAOLZvyFUXpnvc2YXa6BqXh7GEtD4pA52L-=i6X6-rewom=MyYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit 38cbf9598feba97de9f9b43efa9153fd7c1a2ec9
("ASoC: core: Try to use regmap if the driver doesn't set up any I/O")
causes an oops on boot when the wm9712 AC97 codec is probed.

Reverting it (or alternatively setting wm9712's codec::control_data to
a random pointer) fixes it.

Thanks,
      Manuel Lauss


DSPS A
reading from reg 128 of wm9712-codec.1
CPU 0 Unable to handle kernel paging request at virtual address
00000064, epc == 804d7190, ra == 805edabc
Oops[#1]:
Cpu 0
$ 0   : 00000000 10003c00 00000000 809c208c
$ 4   : 00000000 00000080 8fc2bbb8 00000002
$ 8   : 00000000 10003c00 00000010 000000a2
$12   : 38323120 ffffffe0 00000000 20666f20
$16   : 8fdc77e0 00000080 00000001 00000000
$20   : 00000005 00000080 808aa9b8 809932b8
$24   : 00000010 805eda20
$28   : 8fc2a000 8fc2bb88 00000000 805edabc
Hi    : 00000000
Lo    : 0000014a
epc   : 804d7190 regmap_read+0xc/0x6c
    Not tainted
ra    : 805edabc hw_read+0x9c/0xac
Status: 10003c03    KERNEL EXL IE
Cause : 00808008
BadVA : 00000064
PrId  : 800c8000 (Au1300)
Process swapper (pid: 1, threadinfo=8fc2a000, task=8fc29a48, tls=00000000)
Stack : 00000001 00000000 00000005 00000080 809918ec 8fc2bbb4 8fdc77e0 805edabc
        8fe178a0 805df5f4 80958039 00000080 8fe0d320 00000002 8fc2bbd4 8fe0a720
        8fe15b40 805e4abc 2063694d 8fe0a720 808ab1bc 00000000 00000000 8fe15b40
        8fe0a720 8fe166e0 809932d0 8fdc7878 80993158 805e5170 00000001 805e03fc
        805e04d0 805e0604 8fe1d960 8fe0f400 00000000 00000035 8fe0f400 00000000
        ...
Call Trace:
[<804d7190>] regmap_read+0xc/0x6c
[<805edabc>] hw_read+0x9c/0xac
[<805e4abc>] dapm_set_path_status+0x114/0x3c8
[<805e5170>] snd_soc_dapm_add_route+0x400/0x64c
[<805e6de8>] snd_soc_dapm_add_routes+0x68/0xcc
[<805dfe94>] soc_probe_codec+0x150/0x214
[<805e2138>] snd_soc_register_card+0xcb8/0x1614
[<804c916c>] driver_probe_device+0x8c/0x248
[<804c93e4>] __driver_attach+0xbc/0xc4
[<804c734c>] bus_for_each_dev+0x54/0xa0
[<804c7de8>] bus_add_driver+0x1ac/0x2a4
[<804c9b60>] driver_register+0x90/0x1d0
[<809f6a2c>] do_one_initcall+0xf8/0x1d0
[<809f6c4c>] kernel_init+0x148/0x1e4
[<80106f88>] kernel_thread_helper+0x10/0x18
