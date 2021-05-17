Return-Path: <SRS0=ObP5=KM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F86C433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 08:29:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB1961242
	for <alsa-devel@archiver.kernel.org>; Mon, 17 May 2021 08:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB1961242
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C2DC836;
	Mon, 17 May 2021 10:28:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C2DC836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621240186;
	bh=zt6LkNyq4ltFsg5E2ulI6o0zS2Ze1d6aSic4DkTfDUE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uOqvijOkvKEJHw3N3rpCQuM89HQBVmThKkWRPeSPKwqzsVvCl8dm8ZkNuoB6h1WhD
	 YSj/5q1RRo+e4BhayZZ6F53UiK+Rk7E2xm82+NkdrMwFSzIxW6CT4XcRd4LbdzMeCD
	 kCgwflg2IxMjs3yftVuTJu3OiPeyFqMUFgNpBRto=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFC05F80082;
	Mon, 17 May 2021 10:28:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E23CEF8020B; Mon, 17 May 2021 10:28:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C9DDDF80169
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 10:28:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9DDDF80169
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1621240088822727919-webhooks-bot@alsa-project.org>
References: <1621240088822727919-webhooks-bot@alsa-project.org>
Subject: Not building on Raspbian Buster
Message-Id: <20210517082822.E23CEF8020B@alsa1.perex.cz>
Date: Mon, 17 May 2021 10:28:22 +0200 (CEST)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-utils issue #89 was opened from riban-bw:

Make fails during linking because the object files are not created. If the compiler is run then the object file will build but the prefix added by Makefile seems to stop the copmilation from occuring. This is building v1.2.4. (Master refuses to build due to dependancy on later version of asoundlib.)

```
Making all in include
make[1]: Entering directory '/root/alsa-utils/include'
(CDPATH="${ZSH_VERSION+.}:" && cd .. && /bin/bash /root/alsa-utils/missing autoheader)
rm -f stamp-h1
touch aconfig.h.in
cd .. && /bin/bash ./config.status include/aconfig.h
config.status: creating include/aconfig.h
config.status: include/aconfig.h is unchanged
make  all-am
make[2]: Entering directory '/root/alsa-utils/include'
Updating version.h
make[2]: Leaving directory '/root/alsa-utils/include'
make[1]: Leaving directory '/root/alsa-utils/include'
Making all in alsactl
make[1]: Entering directory '/root/alsa-utils/alsactl'
Making all in init
make[2]: Entering directory '/root/alsa-utils/alsactl/init'
make[2]: Nothing to be done for 'all'.
make[2]: Leaving directory '/root/alsa-utils/alsactl/init'
make[2]: Entering directory '/root/alsa-utils/alsactl'
source='alsactl.c' object='alsactl-alsactl.o' libtool=no \
DEPDIR=.deps depmode=none /bin/bash ../depcomp \
gcc -DHAVE_CONFIG_H -I. -I../include    -D_GNU_SOURCE -D__USE_GNU -DSYS_ASOUNDRC=\"/var/lib/alsa/asound.state\" -DSYS_LOCKFILE=\"/var/lock/asound.state.lock\" -DSYS_PIDFILE=\"/var/run/alsactl.pid\" -O2 -Wall -pipe -g -c -o alsactl-alsactl.o `test -f 'alsactl.c' || echo './'`alsactl.c
source='state.c' object='alsactl-state.o' libtool=no \
DEPDIR=.deps depmode=none /bin/bash ../depcomp \
gcc -DHAVE_CONFIG_H -I. -I../include    -D_GNU_SOURCE -D__USE_GNU -DSYS_ASOUNDRC=\"/var/lib/alsa/asound.state\" -DSYS_LOCKFILE=\"/var/lock/asound.state.lock\" -DSYS_PIDFILE=\"/var/run/alsactl.pid\" -O2 -Wall -pipe -g -c -o alsactl-state.o `test -f 'state.c' || echo './'`state.c
source='lock.c' object='alsactl-lock.o' libtool=no \
DEPDIR=.deps depmode=none /bin/bash ../depcomp \
gcc -DHAVE_CONFIG_H -I. -I../include    -D_GNU_SOURCE -D__USE_GNU -DSYS_ASOUNDRC=\"/var/lib/alsa/asound.state\" -DSYS_LOCKFILE=\"/var/lock/asound.state.lock\" -DSYS_PIDFILE=\"/var/run/alsactl.pid\" -O2 -Wall -pipe -g -c -o alsactl-lock.o `test -f 'lock.c' || echo './'`lock.c
source='utils.c' object='alsactl-utils.o' libtool=no \
DEPDIR=.deps depmode=none /bin/bash ../depcomp \
gcc -DHAVE_CONFIG_H -I. -I../include    -D_GNU_SOURCE -D__USE_GNU -DSYS_ASOUNDRC=\"/var/lib/alsa/asound.state\" -DSYS_LOCKFILE=\"/var/lock/asound.state.lock\" -DSYS_PIDFILE=\"/var/run/alsactl.pid\" -O2 -Wall -pipe -g -c -o alsactl-utils.o `test -f 'utils.c' || echo './'`utils.c
source='init_parse.c' object='alsactl-init_parse.o' libtool=no \
DEPDIR=.deps depmode=none /bin/bash ../depcomp \
gcc -DHAVE_CONFIG_H -I. -I../include    -D_GNU_SOURCE -D__USE_GNU -DSYS_ASOUNDRC=\"/var/lib/alsa/asound.state\" -DSYS_LOCKFILE=\"/var/lock/asound.state.lock\" -DSYS_PIDFILE=\"/var/run/alsactl.pid\" -O2 -Wall -pipe -g -c -o alsactl-init_parse.o `test -f 'init_parse.c' || echo './'`init_parse.c
source='init_ucm.c' object='alsactl-init_ucm.o' libtool=no \
DEPDIR=.deps depmode=none /bin/bash ../depcomp \
gcc -DHAVE_CONFIG_H -I. -I../include    -D_GNU_SOURCE -D__USE_GNU -DSYS_ASOUNDRC=\"/var/lib/alsa/asound.state\" -DSYS_LOCKFILE=\"/var/lock/asound.state.lock\" -DSYS_PIDFILE=\"/var/run/alsactl.pid\" -O2 -Wall -pipe -g -c -o alsactl-init_ucm.o `test -f 'init_ucm.c' || echo './'`init_ucm.c
source='daemon.c' object='alsactl-daemon.o' libtool=no \
DEPDIR=.deps depmode=none /bin/bash ../depcomp \
gcc -DHAVE_CONFIG_H -I. -I../include    -D_GNU_SOURCE -D__USE_GNU -DSYS_ASOUNDRC=\"/var/lib/alsa/asound.state\" -DSYS_LOCKFILE=\"/var/lock/asound.state.lock\" -DSYS_PIDFILE=\"/var/run/alsactl.pid\" -O2 -Wall -pipe -g -c -o alsactl-daemon.o `test -f 'daemon.c' || echo './'`daemon.c
source='monitor.c' object='alsactl-monitor.o' libtool=no \
DEPDIR=.deps depmode=none /bin/bash ../depcomp \
gcc -DHAVE_CONFIG_H -I. -I../include    -D_GNU_SOURCE -D__USE_GNU -DSYS_ASOUNDRC=\"/var/lib/alsa/asound.state\" -DSYS_LOCKFILE=\"/var/lock/asound.state.lock\" -DSYS_PIDFILE=\"/var/run/alsactl.pid\" -O2 -Wall -pipe -g -c -o alsactl-monitor.o `test -f 'monitor.c' || echo './'`monitor.c
gcc -D_GNU_SOURCE -D__USE_GNU -DSYS_ASOUNDRC=\"/var/lib/alsa/asound.state\" -DSYS_LOCKFILE=\"/var/lock/asound.state.lock\" -DSYS_PIDFILE=\"/var/run/alsactl.pid\" -O2 -Wall -pipe -g   -o alsactl alsactl-alsactl.o alsactl-state.o alsactl-lock.o alsactl-utils.o alsactl-init_parse.o alsactl-init_ucm.o alsactl-daemon.o alsactl-monitor.o  -lasound -lm -ldl -lpthread
gcc: error: alsactl-alsactl.o: No such file or directory
gcc: error: alsactl-state.o: No such file or directory
gcc: error: alsactl-lock.o: No such file or directory
gcc: error: alsactl-utils.o: No such file or directory
gcc: error: alsactl-init_parse.o: No such file or directory
gcc: error: alsactl-init_ucm.o: No such file or directory
gcc: error: alsactl-daemon.o: No such file or directory
gcc: error: alsactl-monitor.o: No such file or directory
make[2]: *** [Makefile:527: alsactl] Error 1
make[2]: Leaving directory '/root/alsa-utils/alsactl'
make[1]: *** [Makefile:811: all-recursive] Error 1
make[1]: Leaving directory '/root/alsa-utils/alsactl'
make: *** [Makefile:429: all-recursive] Error 1
```

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/89
Repository URL: https://github.com/alsa-project/alsa-utils
