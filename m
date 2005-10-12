From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: 1.0.10rc2 alsa-lib build warnings under gcc 4.0.2
Date: Wed, 12 Oct 2005 13:53:16 +0200
Message-ID: <434CF92C.70400@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailservice.tudelft.nl (mailservice.tudelft.nl [130.161.131.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C19E016B
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 13:53:16 +0200 (MEST)
Received: from localhost (localhost [127.0.0.1])
	by rav.antivirus (Postfix) with ESMTP id 55E0480070
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 13:53:14 +0200 (CEST)
Received: from aglu.demon.nl (x104.decis.nl [130.161.177.104])
	by mx4.tudelft.nl (Postfix) with ESMTP id 772EC8003A
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 13:53:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by aglu.demon.nl (Postfix) with ESMTP id BBBC23FF52
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 13:53:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

FYI

$ grep rror alsa-lib_1.0.9+1.0.10rc2-1~1_i386.build
$ grep warning alsa-lib_1.0.9+1.0.10rc2-1~1_i386.build
dpkg-source: warning: ignoring deletion of file config.guess
dpkg-source: warning: ignoring deletion of file config.sub
simple.c:116: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
simple.c:116: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
simple.c:116: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
simple.c:116: warning: pointer targets in passing argument 2 of '__builtin_strcmp' differ in signedness
simple.c:116: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
simple.c:116: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
simple.c:116: warning: pointer targets in passing argument 2 of '__builtin_strcmp' differ in signedness
simple.c:116: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
simple.c:116: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
simple.c:116: warning: pointer targets in passing argument 2 of '__builtin_strcmp' differ in signedness
simple.c:116: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
simple.c:116: warning: pointer targets in passing argument 2 of '__builtin_strcmp' differ in signedness
simple.c:141: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
simple.c:141: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
simple.c:141: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
simple.c:141: warning: pointer targets in passing argument 2 of '__builtin_strcmp' differ in signedness
simple.c:141: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
simple.c:141: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
simple.c:141: warning: pointer targets in passing argument 2 of '__builtin_strcmp' differ in signedness
simple.c:141: warning: pointer targets in passing argument 1 of 'strlen' differ in signedness
simple.c:141: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
simple.c:141: warning: pointer targets in passing argument 2 of '__builtin_strcmp' differ in signedness
simple.c:141: warning: pointer targets in passing argument 1 of '__builtin_strcmp' differ in signedness
simple.c:141: warning: pointer targets in passing argument 2 of '__builtin_strcmp' differ in signedness
simple.c:172: warning: pointer targets in return differ in signedness
simple.c:960: warning: pointer targets in return differ in signedness
simple.c:982: warning: pointer targets in passing argument 1 of '__builtin_strncpy' differ in signedness
simple_none.c:1271: warning: 'type' may be used uninitialized in this function
pcm_route.c:348: warning: 'src' may be used uninitialized in this function
pcm_direct.c:879: warning: pointer targets in passing argument 3 of '__snd_pcm_hw_params_set_periods_near' differ in signedness
seq.c:4438: warning: assignment from incompatible pointer type
sbase.c:206: warning: unused variable 's'
sbase.c:203: warning: unused parameter 'dir'
sbase.c:204: warning: unused parameter 'channel'
sbase.c:214: warning: unused variable 's'
sbase.c:211: warning: unused parameter 'dir'
sbase.c:212: warning: unused parameter 'channel'
sbase.c:212: warning: unused parameter 'value'
sbase.c:231: warning: unused variable 'changed'
sbase.c:230: warning: unused variable 's'
sbase.c:227: warning: unused parameter 'dir'
sbase.c:228: warning: unused parameter 'channel'
sbase.c:228: warning: unused parameter 'value'
sbase.c:239: warning: unused variable 's'
sbase.c:236: warning: unused parameter 'item'
sbase.c:237: warning: unused parameter 'maxlen'
sbase.c:237: warning: unused parameter 'buf'
sbase.c:247: warning: unused variable 's'
sbase.c:244: warning: unused parameter 'channel'
sbase.c:245: warning: unused parameter 'itemp'
sbase.c:255: warning: unused variable 's'
sbase.c:252: warning: unused parameter 'channel'
sbase.c:253: warning: unused parameter 'item'
sbase.c:286: warning: unused parameter 'melem'
sbase.c:312: warning: unused variable 'count'
sbase.c:54: warning: 'to_user' defined but not used
sbase.c:63: warning: 'from_user' defined but not used
libtool: install: warning: remember to run `libtool --finish /usr/lib'
libtool: install: warning: relinking `smixer-sbase.la'
libtool: install: warning: remember to run `libtool --finish /usr/lib/alsa-lib/smixer'
libtool: install: warning: relinking `smixer-ac97.la'
libtool: install: warning: remember to run `libtool --finish /usr/lib/alsa-lib/smixer'
libtool: install: warning: relinking `smixer-hda.la'
libtool: install: warning: remember to run `libtool --finish /usr/lib/alsa-lib/smixer'
libtool: install: warning: remember to run `libtool --finish /usr/lib'
libtool: install: warning: relinking `smixer-sbase.la'
libtool: install: warning: remember to run `libtool --finish /usr/lib/alsa-lib/smixer'
libtool: install: warning: relinking `smixer-ac97.la'
libtool: install: warning: remember to run `libtool --finish /usr/lib/alsa-lib/smixer'
libtool: install: warning: relinking `smixer-hda.la'
libtool: install: warning: remember to run `libtool --finish /usr/lib/alsa-lib/smixer'


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
