From: Marcelo Utikawa da Fonseca <marcelo.fonseca@tecnequip.com.br>
Subject: Problem compiling soc - imx31 and wm8753
Date: Wed, 11 Mar 2009 11:47:25 -0300
Message-ID: <49B7CEFD.1080006@tecnequip.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hm1480-11.locaweb.com.br (hm1480-43.locaweb.com.br
	[201.76.49.174])
	by alsa0.perex.cz (Postfix) with ESMTP id EFD34103886
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 15:47:29 +0100 (CET)
Received: from hm574.locaweb.com.br (10.1.10.44) by hm1480-11.locaweb.com.br
	(PowerMTA(TM) v3.5r11) id hmv7g40nva4d for
	<alsa-devel@alsa-project.org>;
	Wed, 11 Mar 2009 11:47:26 -0300 (envelope-from
	<marcelo.fonseca@tecnequip.com.br>)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!
I am new here and do not know if I am posting correctly, please =

understand! :-)
I knew about this list in the wolfsonmicro website and I hope someone =

can help me...

I am facing a problem while compiling the sound support for imx31ads board.
I got the kernel from wolfsonmicro using the following command:

git clone git://opensource.wolfsonmicro.com/linux-2.6-asoc linux-2.6-asoc

After this I just copy the arch/arm/configs/mx31ads_defconfig to .config =

and run:

make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- menuconfig

I selected Alsa support, SoC, Support for i.MX CPU and Support for =

i.MX31 - WM8753.
After this I run:

make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- zImage

and I receive this error message:

  CC      sound/soc/imx/imx-ssi.o
In file included from sound/soc/imx/imx-ssi.c:29:
include/sound/driver.h:1:2: warning: #warning "This file is deprecated"
sound/soc/imx/imx-ssi.c:34:26: error: asm/arch/dma.h: No such file or =

directory
sound/soc/imx/imx-ssi.c:35:28: error: asm/arch/clock.h: No such file or =

directory
sound/soc/imx/imx-ssi.c:37:26: error: asm/hardware.h: No such file or =

directory
In file included from sound/soc/imx/imx-ssi.c:39:
sound/soc/imx/imx-ssi.h:10:31: error: asm/arch/hardware.h: No such file =

or directory
In file included from sound/soc/imx/imx-ssi.c:39:
sound/soc/imx/imx-ssi.h:213: error: array type has incomplete element type
In file included from sound/soc/imx/imx-ssi.c:40:
sound/soc/imx/imx31-pcm.h:62: error: expected specifier-qualifier-list =

before 'dma_channel_params'
sound/soc/imx/imx31-pcm.h:65: error: array type has incomplete element type
sound/soc/imx/imx-ssi.c:72: error: unknown field 'params' specified in =

initializer
sound/soc/imx/imx-ssi.c:72: error: extra brace group at end of initializer
sound/soc/imx/imx-ssi.c:72: error: (near initialization for =

'imx_ssi1_pcm_stereo_out0')
sound/soc/imx/imx-ssi.c:74: error: 'emi_2_per' undeclared here (not in a =

function)
sound/soc/imx/imx-ssi.c:76: error: 'SSI1_BASE_ADDR' undeclared here (not =

in a function)
sound/soc/imx/imx-ssi.c:77: error: 'DMA_REQ_SSI1_TX1' undeclared here =

(not in a function)
sound/soc/imx/imx-ssi.c:78: error: 'SSI' undeclared here (not in a function)
sound/soc/imx/imx-ssi.c:79: warning: excess elements in struct initializer
sound/soc/imx/imx-ssi.c:79: warning: (near initialization for =

'imx_ssi1_pcm_stereo_out0')
sound/soc/imx/imx-ssi.c:84: error: unknown field 'params' specified in =

initializer
sound/soc/imx/imx-ssi.c:84: error: extra brace group at end of initializer
sound/soc/imx/imx-ssi.c:84: error: (near initialization for =

'imx_ssi1_pcm_stereo_out1')
...
...
...
sound/soc/imx/imx-ssi.c:836: error: field name not in record or union =

initializer
sound/soc/imx/imx-ssi.c:836: error: (near initialization for =

'imx_ssi_pcm_dai')
sound/soc/imx/imx-ssi.c:837: error: field name not in record or union =

initializer
sound/soc/imx/imx-ssi.c:837: error: (near initialization for =

'imx_ssi_pcm_dai')
sound/soc/imx/imx-ssi.c:838: error: field name not in record or union =

initializer
sound/soc/imx/imx-ssi.c:838: error: (near initialization for =

'imx_ssi_pcm_dai')
sound/soc/imx/imx-ssi.c:841: warning: type defaults to 'int' in =

declaration of 'imx_ssi_pcm_dai'
make[3]: *** [sound/soc/imx/imx-ssi.o] Error 1
make[2]: *** [sound/soc/imx] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2


I did not change nothing, just configure and compile...
My gcc version is 4.1.2 from Freescale.
What can be wrong? Could be this version of gcc a problem?
I already tried to correct the missing include files but the other =

errors are still there after the corrections...

Thanks in advance,
Marcelo Utikawa da Fonseca



---------------------------------------------
Tecnequip Tecnologia em Equipamentos
Endere=E7o/Address: Rua Juno, 527
Cidade/City: S=E3o Paulo
Estado/State: SP
Pa=EDs/Country: Brasil
CEP/Postal Code: 03445-000
Fone/Phone: 55-11-20937199
FAX: 55-11-29412289
