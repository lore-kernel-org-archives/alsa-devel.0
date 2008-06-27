From: "Caloro Maurizio" <mauric@gmx.ch>
Subject: Re: Building trouble - redefinition of struct timeval
Date: Fri, 27 Jun 2008 15:58:15 +0200
Message-ID: <20080627135815.163870@gmx.net>
References: <20080625135409.236240@gmx.net> <s5hy74t7btp.wl%tiwai@suse.de>
	<20080626084032.261430@gmx.net> <s5h1w2kqkrz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 1099324466
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jun 2008 15:58:16 +0200 (CEST)
In-Reply-To: <s5h1w2kqkrz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>
>>Basically removing the block ifdef POSIX_C_SOURCE should suffice.
>>You need the typedefs below.
>>
>>Takashi
>>


Hello Takashi

Thanks for your fast and professional feedback, so i have to many changes n=
ow =

that this script run on me Netbsd machine.....so now i  think i need your h=
elp =


Please ... what do you think offer this error block....
thanks for your answer =

MC

....run.....run....run.....run....run.....run
gmake[2]: Nothing to be done for `all-am'.
gmake[2]: Leaving directory `/usr/source/alsa-lib-1.0.17rc2/src'
gmake[1]: Leaving directory `/usr/source/alsa-lib-1.0.17rc2/src'
Making all in modules
gmake[1]: Entering directory `/usr/source/alsa-lib-1.0.17rc2/modules'
Making all in mixer
gmake[2]: Entering directory `/usr/source/alsa-lib-1.0.17rc2/modules/mixer'
Making all in simple
gmake[3]: Entering directory `/usr/source/alsa-lib-1.0.17rc2/modules/mixer/=
simple'
gmake[3]: Nothing to be done for `all'.
gmake[3]: Leaving directory `/usr/source/alsa-lib-1.0.17rc2/modules/mixer/s=
imple'
gmake[3]: Entering directory `/usr/source/alsa-lib-1.0.17rc2/modules/mixer'
gmake[3]: Nothing to be done for `all-am'.
gmake[3]: Leaving directory `/usr/source/alsa-lib-1.0.17rc2/modules/mixer'
gmake[2]: Leaving directory `/usr/source/alsa-lib-1.0.17rc2/modules/mixer'
gmake[2]: Entering directory `/usr/source/alsa-lib-1.0.17rc2/modules'
gmake[2]: Nothing to be done for `all-am'.
gmake[2]: Leaving directory `/usr/source/alsa-lib-1.0.17rc2/modules'
gmake[1]: Leaving directory `/usr/source/alsa-lib-1.0.17rc2/modules'
Making all in aserver
gmake[1]: Entering directory `/usr/source/alsa-lib-1.0.17rc2/aserver'
/bin/ksh ../libtool --tag=3DCC --mode=3Dlink gcc  -g -O2   -o aserver  aser=
ver.o ../src/libasound.la =

gcc -g -O2 -o aserver aserver.o  ../src/.libs/libasound.a -lm -lpthread -lrt
../src/.libs/libasound.a(pcm_linear.o): In function `snd1_pcm_linear_conver=
t':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:307: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:337: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:261: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:263: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:265: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:333: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:335: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:302: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:304: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:309: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:311: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:315: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:317: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:319: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:294: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:324: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:326: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:328: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:330: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:270: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:272: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:281: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:283: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:279: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:289: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:291: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:296: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:298: undefined referenc=
e to `__swab32'
../src/.libs/libasound.a(pcm_linear.o): In function `snd1_pcm_linear_getput=
':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:500: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:504: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:507: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:508: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:575: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:576: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:579: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:580: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:583: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:584: undefined referenc=
e to `__swab32'
../src/.libs/libasound.a(pcm_route.o): In function `snd_pcm_route_convert1_=
one':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:307: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:302: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:298: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:296: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:294: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:291: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:289: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:283: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:281: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:279: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:272: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:270: undefined referenc=
e to `__swab16'
../src/.libs/libasound.a(pcm_route.o):/usr/source/alsa-lib-1.0.17rc2/src/pc=
m/plugin_ops.h:265: more undefined references to `__swab16' follow
../src/.libs/libasound.a(pcm_route.o): In function `snd_pcm_route_convert1_=
one':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:337: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:335: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:333: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:330: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:328: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:326: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:324: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:319: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:317: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:315: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:311: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:309: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:304: undefined referenc=
e to `__swab32'
../src/.libs/libasound.a(pcm_route.o): In function `snd_pcm_route_convert1_=
one_getput':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:500: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:504: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:507: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:508: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:575: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:576: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:579: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:580: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:583: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:584: undefined referenc=
e to `__swab32'
../src/.libs/libasound.a(pcm_route.o): In function `snd_pcm_route_convert1_=
many':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:678: undefined referenc=
e to `__swab32'
../src/.libs/libasound.a(pcm_route.o):/usr/source/alsa-lib-1.0.17rc2/src/pc=
m/plugin_ops.h:679: more undefined references to `__swab32' follow
../src/.libs/libasound.a(pcm_route.o): In function `snd_pcm_route_convert1_=
many':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:674: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:675: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:575: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:576: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:579: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:583: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:584: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:580: undefined referenc=
e to `__swab32'
../src/.libs/libasound.a(pcm_mulaw.o): In function `snd1_pcm_mulaw_encode':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:383: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:384: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:387: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:388: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:391: undefined referenc=
e to `__swab16'
../src/.libs/libasound.a(pcm_mulaw.o):/usr/source/alsa-lib-1.0.17rc2/src/pc=
m/plugin_ops.h:392: more undefined references to `__swab16' follow
../src/.libs/libasound.a(pcm_lfloat.o): In function `snd_pcm_lfloat_convert=
_integer_float':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:504: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:507: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:508: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:740: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:743: undefined referenc=
e to `__swab64'
../src/.libs/libasound.a(pcm_lfloat.o): In function `snd_pcm_lfloat_convert=
_float_integer':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:765: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:781: undefined referenc=
e to `__swab64'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:579: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:580: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:583: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:584: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:575: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:576: undefined referenc=
e to `__swab16'
../src/.libs/libasound.a(pcm_dmix.o): In function `generic_remix_areas_32_s=
wap':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_dmix_generic.c:380: undefined re=
ference to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_dmix_generic.c:368: undefined re=
ference to `__swab32'
../src/.libs/libasound.a(pcm_dmix.o): In function `generic_mix_areas_32_swa=
p':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_dmix_generic.c:334: undefined re=
ference to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_dmix_generic.c:347: undefined re=
ference to `__swab32'
../src/.libs/libasound.a(pcm_dmix.o): In function `generic_remix_areas_16_s=
wap':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_dmix_generic.c:313: undefined re=
ference to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_dmix_generic.c:303: undefined re=
ference to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_dmix_generic.c:313: undefined re=
ference to `__swab16'
../src/.libs/libasound.a(pcm_dmix.o): In function `generic_mix_areas_16_swa=
p':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_dmix_generic.c:271: undefined re=
ference to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_dmix_generic.c:282: undefined re=
ference to `__swab16'
../src/.libs/libasound.a(pcm_iec958.o): In function `iec958_to_s32':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_iec958.c:137: undefined referenc=
e to `__swab32'
../src/.libs/libasound.a(pcm_iec958.o): In function `snd_pcm_iec958_decode':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:575: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:576: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:579: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:580: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:584: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:583: undefined referenc=
e to `__swab32'
../src/.libs/libasound.a(pcm_iec958.o): In function `snd_pcm_iec958_encode':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:500: undefined referenc=
e to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:504: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:507: undefined referenc=
e to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/plugin_ops.h:508: undefined referenc=
e to `__swab32'
../src/.libs/libasound.a(pcm_iec958.o): In function `iec958_subframe':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_iec958.c:129: undefined referenc=
e to `__swab32'
../src/.libs/libasound.a(pcm_softvol.o): In function `MULTI_DIV_int':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_softvol.c:135: undefined referen=
ce to `__swab32'
../src/.libs/libasound.a(pcm_softvol.o):/usr/source/alsa-lib-1.0.17rc2/src/=
pcm/pcm_softvol.c:125: more undefined references to `__swab32' follow
../src/.libs/libasound.a(pcm_softvol.o): In function `MULTI_DIV_short':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_softvol.c:142: undefined referen=
ce to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_softvol.c:148: undefined referen=
ce to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_softvol.c:150: undefined referen=
ce to `__swab16'
../src/.libs/libasound.a(pcm_softvol.o): In function `MULTI_DIV_int':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_softvol.c:133: undefined referen=
ce to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_softvol.c:135: undefined referen=
ce to `__swab32'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_softvol.c:125: undefined referen=
ce to `__swab32'
../src/.libs/libasound.a(pcm_softvol.o): In function `MULTI_DIV_short':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_softvol.c:142: undefined referen=
ce to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_softvol.c:148: undefined referen=
ce to `__swab16'
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_softvol.c:150: undefined referen=
ce to `__swab16'
../src/.libs/libasound.a(pcm_softvol.o): In function `MULTI_DIV_int':
/usr/source/alsa-lib-1.0.17rc2/src/pcm/pcm_softvol.c:133: undefined referen=
ce to `__swab32'
gmake[1]: *** [aserver] Error 1
gmake[1]: Leaving directory `/usr/source/alsa-lib-1.0.17rc2/aserver'
gmake: *** [all-recursive] Error 1


-- =

-----------------------------------------------------------
--- say NO to Html in mail -------------- Maurizio   Caloro=A0=A0=A0=A0=A0
-----------------------------------------  <mauric@gmx.ch> =



GMX startet ShortView.de. Hier findest Du Leute mit Deinen Interessen!
Jetzt dabei sein: http://www.shortview.de/wasistshortview.php?mc=3Dsv_ext_m=
f@gmx
