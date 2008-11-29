From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: 1.0.18-tools : ac3dec won't compile
Date: Sat, 29 Nov 2008 15:30:39 +0100
Message-ID: <d9690f190811290630n7ddf7263rf55217dafe309e4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D7BB24133
	for <alsa-devel@alsa-project.org>; Sat, 29 Nov 2008 15:30:42 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so710395yxh.2
	for <alsa-devel@alsa-project.org>; Sat, 29 Nov 2008 06:30:41 -0800 (PST)
Content-Disposition: inline
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

Hi there.

Just tried to get the tools 1.0.18 compiled.


Following error message was printed when I tried to make ac3dec:


gcc -DHAVE_CONFIG_H -I. -I..     -Wall -Werror -O3 -g  -MT extract_ac3.o -MD
-MP -MF .deps/extract_ac3.Tpo -c -o extract_ac3.o extract_ac3.c
cc1: warnings being treated as errors
extract_ac3.c: In function 'read_write_next_bytes':
extract_ac3.c:163: error: ignoring return value of 'write', declared with
attribute warn_unused_result
extract_ac3.c:174: error: ignoring return value of 'write', declared with
attribute warn_unused_result
make[2]: *** [extract_ac3.o] Error 1
make[2]: Leaving directory
`/usr/src/Alsa-1.0.18a/alsa-tools-1.0.18/ac3dec/tools'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/src/Alsa-1.0.18a/alsa-tools-1.0.18/ac3dec'
make: *** [all] Error 2


Any ideas?

THX
