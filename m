From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: alsa-conf will not compile
Date: Sat, 13 Apr 2002 15:39:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CB84325.6060705@superbug.demon.co.uk>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040008080404040107020805"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040008080404040107020805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

I just got the latest alsa 0.9.x cvs (as of about 5 mins ago)
Everything compiles fine, except alsa-conf

I enclose stdout and stderr output from the ./cvscompile command.

Cheers
James


--------------040008080404040107020805
Content-Type: text/plain;
 name="stdout"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stdout"

`/usr/share/automake/install-sh' -> `./install-sh'
`/usr/share/automake/ylwrap' -> `./ylwrap'
`/usr/share/automake/mkinstalldirs' -> `./mkinstalldirs'
`/usr/share/automake/missing' -> `./missing'
loading cache ./config.cache
checking for a BSD compatible install... (cached) /usr/bin/install -c
checking whether build environment is sane... yes
checking whether make sets ${MAKE}... (cached) yes
checking for working aclocal... found
checking for working autoconf... found
checking for working automake... found
checking for working autoheader... found
checking for working makeinfo... found
checking for bison... (cached) bison -y
checking for gcc... (cached) gcc
checking whether the C compiler (gcc  ) works... yes
checking whether the C compiler (gcc  ) is a cross-compiler... no
checking whether we are using GNU C... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for c++... (cached) c++
checking whether the C++ compiler (c++  ) works... yes
checking whether the C++ compiler (c++  ) is a cross-compiler... no
checking whether we are using GNU C++... (cached) yes
checking whether c++ accepts -g... (cached) yes
checking for a BSD compatible install... /usr/bin/install -c
checking whether ln -s works... (cached) yes
checking for ranlib... (cached) ranlib
checking for SLcurrent_time_string in -lslang... (cached) yes
checking for Gpm_Close in -lgpm... (cached) no
checking how to run the C preprocessor... (cached) gcc -E
checking for ANSI C header files... (cached) yes
checking for slang/slang.h... (cached) no
checking for slang.h... (cached) yes
checking for newt.h... (cached) yes
checking for working const... (cached) yes
checking for size_t... (cached) yes
creating ./config.status
creating Makefile
creating newt/Makefile
creating config.h
config.h is unchanged
cd . && autoheader
make  all-recursive
make[1]: Entering directory `/usr/local/alsacvs/alsa-conf'
Making all in newt
make[2]: Entering directory `/usr/local/alsacvs/alsa-conf/newt'
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c newt.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c button.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c form.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c checkbox.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c entry.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c label.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c listbox.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c scrollbar.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c textbox.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c scale.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c grid.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c windows.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c buttonbar.c
gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include/slang    -g -O2 -c checkboxtree.c
rm -f libanewt.a
ar cru libanewt.a newt.o button.o form.o checkbox.o entry.o label.o listbox.o scrollbar.o textbox.o scale.o grid.o windows.o buttonbar.o checkboxtree.o 
ranlib libanewt.a
make[2]: Leaving directory `/usr/local/alsacvs/alsa-conf/newt'
make[2]: Entering directory `/usr/local/alsacvs/alsa-conf'
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Alloc.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Def.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Device.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Devices.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Expr.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Field.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Fields.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Functor.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Module.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Modules.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Param.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Params.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c ParamDef.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c ParamDefs.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c PValue.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c PValues.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c String.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c UI.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c UI_newt.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c Value.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c main.cc
c++ -DHAVE_CONFIG_H -I. -I. -I. -I./newt    -g -Wall -ftemplate-depth-20 -c param.cc
make[2]: Leaving directory `/usr/local/alsacvs/alsa-conf'
make[1]: Leaving directory `/usr/local/alsacvs/alsa-conf'

--------------040008080404040107020805
Content-Type: text/plain;
 name="stderr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stderr"

param.yy: In method `int parse::param_parse()':
param.yy:61: request for member `str' in `*yyvsp', which is of non-aggregate type `int'
param.yy:62: request for member `str' in `*yyvsp', which is of non-aggregate type `int'
param.yy:70: request for member `str' in `yyval', which is of non-aggregate type `int'
param.yy:72: request for member `str' in `yyval', which is of non-aggregate type `int'
param.yy:74: request for member `str' in `yyval', which is of non-aggregate type `int'
param.yy:76: request for member `str' in `yyval', which is of non-aggregate type `int'
param.yy:78: request for member `str' in `yyval', which is of non-aggregate type `int'
param.yy:80: request for member `str' in `yyval', which is of non-aggregate type `int'
param.yy:82: request for member `str' in `yyval', which is of non-aggregate type `int'
param.yy:84: request for member `str' in `yyval', which is of non-aggregate type `int'
param.yy:86: request for member `str' in `yyval', which is of non-aggregate type `int'
param.yy:88: request for member `str' in `yyval', which is of non-aggregate type `int'
param.yy:124: request for member `integer' in `*(yyvsp + 0ffffffec)', which is of non-aggregate type `int'
param.yy:125: request for member `integer' in `*(yyvsp + 0fffffffc)', which is of non-aggregate type `int'
param.yy:133: request for member `str' in `*yyvsp', which is of non-aggregate type `int'
param.yy: In function `int param_lex()':
param.yy:157: `param_lval' undeclared (first use this function)
param.yy:157: (Each undeclared identifier is reported only once
param.yy:157: for each function it appears in.)
param.yy:163: `_ERROR' undeclared (first use this function)
param.yy:168: `_STR' undeclared (first use this function)
param.yy:173: `_NUM' undeclared (first use this function)
param.yy:194: `_CHAR' undeclared (first use this function)
param.yy:196: `_BYTE' undeclared (first use this function)
param.yy:198: `_SHORT' undeclared (first use this function)
param.yy:200: `_INT' undeclared (first use this function)
param.yy:202: `_LONG' undeclared (first use this function)
param.yy:204: `_STRING' undeclared (first use this function)
param.yy:206: `_ARRAY' undeclared (first use this function)
param.yy:208: `_MIN' undeclared (first use this function)
param.yy:210: `_MAX' undeclared (first use this function)
param.yy:212: `_DESCRIPTION' undeclared (first use this function)
param.yy:215: `_ID' undeclared (first use this function)
param.yy:223: warning: control reaches end of non-void function `param_lex()'
Param.hh: At top level:
param.yy:28: `int param_parse()' used but never defined
param.yy:226: warning: `void param_error(const char *)' defined but not used
param.yy:143: warning: `int param_lex()' defined but not used
make[2]: *** [param.o] Error 1
make[1]: *** [all-recursive] Error 1
make: *** [all-recursive-am] Error 2

--------------040008080404040107020805--
