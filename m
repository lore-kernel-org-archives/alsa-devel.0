From: moxian <aleftmail@inbox.ru>
Subject: [bug] alsa-tools-1.1.3 compilation fails with clang
 due to wrong inline declaration.
Date: Thu, 13 Jul 2017 22:32:42 +0000
Message-ID: <27d38f5c-a50f-f679-7739-8bf140336041@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp46.i.mail.ru (smtp46.i.mail.ru [94.100.177.106])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E92826727D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 23:32:51 +0200 (CEST)
Received: by smtp46.i.mail.ru with esmtpa (envelope-from <aleftmail@inbox.ru>)
 id 1dVlj9-0007aA-6j
 for alsa-devel@alsa-project.org; Fri, 14 Jul 2017 00:32:51 +0300
Content-Language: en-US
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

I've tried compiling alsa-tools-1.3.0 with clang, and the compilation
fails with the following:

$ CC=clang CXX=clang++ make
./as10k1
<...snip...>
clang -fno-strict-aliasing -O2 -Wall -pipe -g   -o as10k1 as10k1.o
parse.o assemble.o macro.o 
as10k1.o: In function `header':
/home/moxian/work/alsa-tools/alsa-tools-1.1.3/as10k1/as10k1.c:524:
undefined reference to `output_tram_line'
/home/moxian/work/alsa-tools/alsa-tools-1.1.3/as10k1/as10k1.c:527:
undefined reference to `output_tram_line'
/home/moxian/work/alsa-tools/alsa-tools-1.1.3/as10k1/as10k1.c:539:
undefined reference to `output_tram_line'
/home/moxian/work/alsa-tools/alsa-tools-1.1.3/as10k1/as10k1.c:543:
undefined reference to `output_tram_line'
clang-3.9: error: linker command failed with exit code 1 (use -v to see
invocation)
make[2]: *** [Makefile:320: as10k1] Error 1
make[2]: Leaving directory
'/home/moxian/work/alsa-tools/alsa-tools-1.1.3/as10k1'
make[1]: *** [Makefile:354: all-recursive] Error 1
make[1]: Leaving directory
'/home/moxian/work/alsa-tools/alsa-tools-1.1.3/as10k1'
make: *** [Makefile:9: all] Error 1

Clang devs claim that it is not a bug in clang (as I thought
originally), but rather invalid code, which happens to compile with gcc
by accident. This is due to `output_tram_line` function being declared
as `inline void output_tram_line`. The intent was probably to declare it
as `static inline void output_tram_line`.
Please see https://bugs.llvm.org/show_bug.cgi?id=33768 for more details.

Adding `static` to the function definition makes everything compile (at
least everything that compiles with gcc already).
