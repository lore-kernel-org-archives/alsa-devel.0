From: Tom Watson <sdc695@yahoo.com>
Subject: Version 1.0.1 compile problems??
Date: Thu, 8 Jan 2004 18:05:14 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040109020514.26725.qmail@web60807.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Well, there was a new version, and while attempting to compile it,
there were problems with alsa-oss:  (sorry about possible line wraps)

[alsa-oss-1.0.1]$ make
if /bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"\"
-DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\"
-DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"alsa-oss\" -DVERSION=\"1.0.1\"
-DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1
-DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1
-DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1
-DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DHAVE_LIBASOUND=1  -I. -I.     -g
-O2 -MT alsa-oss.lo -MD -MP -MF ".deps/alsa-oss.Tpo" \
  -c -o alsa-oss.lo `test -f 'alsa-oss.c' || echo './'`alsa-oss.c; \
then mv -f ".deps/alsa-oss.Tpo" ".deps/alsa-oss.Plo"; \
else rm -f ".deps/alsa-oss.Tpo"; exit 1; \
fi
mkdir .libs
gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\"
-DPACKAGE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"alsa-oss\"
-DVERSION=\"1.0.1\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1
-DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1
-DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1
-DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DHAVE_LIBASOUND=1
-I. -I. -g -O2 -MT alsa-oss.lo -MD -MP -MF .deps/alsa-oss.Tpo -c
alsa-oss.c  -fPIC -DPIC -o .libs/alsa-oss.lo
alsa-oss.c: In function `oss_dsp_hw_params':
alsa-oss.c:221: warning: passing arg 3 of
`snd_pcm_hw_params_set_rate_near' makes integer from pointer without a
cast
alsa-oss.c:261: warning: passing arg 3 of
`snd_pcm_hw_params_set_period_size_near' makes integer from pointer
without a cast
alsa-oss.c:266: warning: passing arg 3 of
`snd_pcm_hw_params_set_period_size_near' makes integer from pointer
without a cast
alsa-oss.c:277: too many arguments to function
`snd_pcm_hw_params_get_rate'
alsa-oss.c:281: warning: passing arg 2 of
`snd_pcm_hw_params_get_period_size' from incompatible pointer type
alsa-oss.c:281: too many arguments to function
`snd_pcm_hw_params_get_period_size'
alsa-oss.c:284: too many arguments to function
`snd_pcm_hw_params_get_periods'
make: *** [alsa-oss.lo] Error 1


=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
