From: Wayne Tams <wayne.tams@gmail.com>
Subject: Problem trying to add ASoC ADAV801 support to my kernel
Date: Tue, 26 Jul 2011 14:31:29 +0100
Message-ID: <CAN=k24m3f0=rXKDrbK+9qNm6Qhwcm7aJf1_Fm4309+zWkF0p7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EA0A01038CB
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jul 2011 15:31:51 +0200 (CEST)
Received: by wyh21 with SMTP id 21so5894wyh.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2011 06:31:49 -0700 (PDT)
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

Hi,

I am trying to add support for the ADAV801 codec to my 2.6.35.3 kernel. I
came across this patch
http://article.gmane.org/gmane.linux.alsa.devel/86474 obviously
I had to make some modifications so it would correctly patch my source.
However when I come to build the kernel I'm getting a whole host of errors
and I am little unsure on how to proceed, could anyone maybe provide some
guidance on the possible causes of my errors or maybe there is a more update
driver available.

Many thanks

W

wa  CC      sound/soc/codecs/adav80x.o
^[sound/soc/codecs/adav80x.c: In function 'adav80x_set_sysclk':
sound/soc/codecs/adav80x.c:556:27: error: 'struct snd_soc_codec' has no
member named 'dapm'
sound/soc/codecs/adav80x.c: In function 'adav80x_set_pll':
sound/soc/codecs/adav80x.c:630:27: error: 'struct snd_soc_codec' has no
member named 'dapm'
sound/soc/codecs/adav80x.c: In function 'adav80x_set_bias_level':
sound/soc/codecs/adav80x.c:654:7: error: 'struct snd_soc_codec' has no
member named 'dapm'
sound/soc/codecs/adav80x.c: At top level:
sound/soc/codecs/adav80x.c:698:34: error: array type has incomplete element
type
sound/soc/codecs/adav80x.c:700:3: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:700:3: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:701:3: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:701:3: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:702:3: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:702:3: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:703:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:703:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:704:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:704:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:705:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:705:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:706:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:706:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:707:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:707:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:709:3: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:709:3: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:710:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:710:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:711:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:711:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:712:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:712:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:713:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:713:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:714:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:714:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:716:3: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:716:3: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:719:3: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:719:3: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:720:3: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:720:3: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:721:3: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:721:3: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:722:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:722:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:723:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:723:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:724:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:724:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:725:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:725:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:726:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:726:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:728:3: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:728:3: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:729:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:729:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:730:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:730:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:731:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:731:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:732:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:732:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:733:4: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:733:4: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c:735:3: error: field name not in record or union
initializer
sound/soc/codecs/adav80x.c:735:3: error: (near initialization for
'adav80x_dais')
sound/soc/codecs/adav80x.c: In function 'adav80x_resume':
sound/soc/codecs/adav80x.c:767:2: error: implicit declaration of function
'snd_soc_cache_sync'
sound/soc/codecs/adav80x.c: At top level:
sound/soc/codecs/adav80x.c:777:15: error: variable 'adav80x_codec_driver'
has initializer but incomplete type
sound/soc/codecs/adav80x.c:778:2: error: unknown field 'probe' specified in
initializer
sound/soc/codecs/adav80x.c:778:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:778:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:779:2: error: unknown field 'remove' specified in
initializer
sound/soc/codecs/adav80x.c:779:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:779:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:780:2: error: unknown field 'suspend' specified
in initializer
sound/soc/codecs/adav80x.c:780:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:780:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:781:2: error: unknown field 'resume' specified in
initializer
sound/soc/codecs/adav80x.c:781:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:781:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:782:2: error: unknown field 'set_bias_level'
specified in initializer
sound/soc/codecs/adav80x.c:782:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:782:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:784:2: error: unknown field 'set_pll' specified
in initializer
sound/soc/codecs/adav80x.c:784:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:784:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:785:2: error: unknown field 'set_sysclk'
specified in initializer
sound/soc/codecs/adav80x.c:785:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:785:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:787:2: error: unknown field 'reg_word_size'
specified in initializer
sound/soc/codecs/adav80x.c:787:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:787:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:788:2: error: unknown field 'reg_cache_size'
specified in initializer
sound/soc/codecs/adav80x.c:788:103: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:788:103: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:789:2: error: unknown field 'reg_cache_default'
specified in initializer
sound/soc/codecs/adav80x.c:789:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:789:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:791:2: error: unknown field 'controls' specified
in initializer
sound/soc/codecs/adav80x.c:791:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:791:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:792:2: error: unknown field 'num_controls'
specified in initializer
sound/soc/codecs/adav80x.c:792:93: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:792:93: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:793:2: error: unknown field 'dapm_widgets'
specified in initializer
sound/soc/codecs/adav80x.c:793:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:793:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:794:2: error: unknown field 'num_dapm_widgets'
specified in initializer
sound/soc/codecs/adav80x.c:794:105: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:794:105: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:795:2: error: unknown field 'dapm_routes'
specified in initializer
sound/soc/codecs/adav80x.c:795:2: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:795:2: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c:796:2: error: unknown field 'num_dapm_routes'
specified in initializer
sound/soc/codecs/adav80x.c:796:102: warning: excess elements in struct
initializer
sound/soc/codecs/adav80x.c:796:102: warning: (near initialization for
'adav80x_codec_driver')
sound/soc/codecs/adav80x.c: In function 'adav80x_bus_probe':
sound/soc/codecs/adav80x.c:813:84: warning: type defaults to 'int' in type
name
sound/soc/codecs/adav80x.c:813:84: warning: type defaults to 'int' in type
name
sound/soc/codecs/adav80x.c:813:84: error: negative width in bit-field
'<anonymous>'
sound/soc/codecs/adav80x.c:813:84: warning: passing argument 1 of
'snd_soc_register_codec' from incompatible pointer type
include/sound/soc.h:239:5: note: expected 'struct snd_soc_codec *' but
argument is of type 'struct device *'
sound/soc/codecs/adav80x.c:813:84: error: too many arguments to function
'snd_soc_register_codec'
include/sound/soc.h:239:5: note: declared here
sound/soc/codecs/adav80x.c: In function 'adav80x_bus_remove':
sound/soc/codecs/adav80x.c:822:2: warning: passing argument 1 of
'snd_soc_unregister_codec' from incompatible pointer type
include/sound/soc.h:240:6: note: expected 'struct snd_soc_codec *' but
argument is of type 'struct device *'
sound/soc/codecs/adav80x.c: At top level:
sound/soc/codecs/adav80x.c:698:34: warning: 'adav80x_dais' defined but not
used
make[4]: *** [sound/soc/codecs/adav80x.o] Error 1
make[3]: *** [sound/soc/codecs] Error 2
make[2]: *** [sound/soc] Error 2
make[1]: *** [sound] Error 2
make[1]: Leaving directory `/home/wayne/sources/k/kernel/linux-2.6.35.3-imx'
make: ***
[/home/wayne/sources/k/kernel/linux-2.6.35.3-imx/.stamp_image_built] Error 2
