Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6827DC07E9A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 07:47:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9C560FDB
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 07:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9C560FDB
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 421E8167E;
	Wed, 14 Jul 2021 09:46:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 421E8167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626248826;
	bh=aQGsDMzQ5pNrcudTU7o4WPVIFAdnFxQX65CJ3slWAhA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=alULH2xxqZF8JOYueKCCXmSbhksBqEs9assNlO78EBZ1K0J2IcQmHiVFalNxfBjjW
	 CO2cnsvk0mTanQLyyVTJp1oIAHbVqCJYjxTRid3vnFVN3uGlFc5tb4lctrn2ERweB7
	 YJm9P37iHC+7DL0Mp/GGGmdEqBiH2M7BR8kLYFs0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE437F8013C;
	Wed, 14 Jul 2021 09:46:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 640E5F80254; Wed, 14 Jul 2021 09:46:14 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B38FBF8013C
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 09:46:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B38FBF8013C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1626248766594938993-webhooks-bot@alsa-project.org>
References: <1626248766594938993-webhooks-bot@alsa-project.org>
Subject: Missing macro 'AM_PATH_LD10K1' not found in library
Message-Id: <20210714074614.640E5F80254@alsa1.perex.cz>
Date: Wed, 14 Jul 2021 09:46:14 +0200 (CEST)
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

alsa-project/alsa-tools issue #7 was opened from ronohara:

New Linux Mint 20.0 install (Ubuntu 20.04 based) on HP X360 with TigerLake hardware.

This distro only has lib-alsa-1.2.2   ... so I need to compile/install the latest alsa stuff from source

I have the kernel working at seeing the hardware - in the mainline 5.13 kernel it is already available. Installed the firmware and UCM2 stuff.  'speaker-test' works ... lots of details in this closed bug: https://github.com/thesofproject/linux/issues/2700#issuecomment-854033711

Installed alsa-lib from source, and alsa-utils .... but compiling alsa-tools (gitcompile) fails.  This macro needs to be installed, but I am wondering what the best way is ...?



make[3]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/src'
make[3]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1'
sed -e 's,[@]sbindir[@],/usr/local/sbin,g' -e 's,[@]binarydir[@],/usr/local/bin,g' -e 's,[@]sysconfdir[@],/usr/local/etc,g' ./ld10k1d.in > ld10k1d
make[3]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1'
make[2]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1'
make[1]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1'
make[1]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1'
make  all-recursive
make[2]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1'
Making all in setup
make[3]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/setup'
Making all in effects
make[4]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/setup/effects'
make[4]: Nothing to be done for 'all'.
make[4]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/setup/effects'
make[4]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/setup'
make[4]: Nothing to be done for 'all-am'.
make[4]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/setup'
make[3]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/setup'
Making all in doc
make[3]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/doc'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/doc'
Making all in patch
make[3]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/patch'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/patch'
Making all in dump
make[3]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/dump'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/dump'
Making all in contrib
make[3]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/contrib'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/contrib'
Making all in include
make[3]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/include'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/include'
Making all in src
make[3]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/src'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1/src'
make[3]: Entering directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1'
make[3]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1'
make[2]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1'
make[1]: Leaving directory '/root/alsa-1.2.5/alsa-tools-1.2.5/ld10k1'
./qlo10k1
configure.ac:21: warning: macro 'AM_PATH_LD10K1' not found in library
libtoolize: putting auxiliary files in '.'.
libtoolize: copying file './ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIRS, 'm4'.
libtoolize: copying file 'm4/libtool.m4'
libtoolize: copying file 'm4/ltoptions.m4'
libtoolize: copying file 'm4/ltsugar.m4'
libtoolize: copying file 'm4/ltversion.m4'
libtoolize: copying file 'm4/lt~obsolete.m4'
libtoolize: Consider adding '-I m4' to ACLOCAL_AMFLAGS in Makefile.am.
configure.ac:21: warning: macro 'AM_PATH_LD10K1' not found in library
configure.ac:21: error: possibly undefined macro: AM_PATH_LD10K1
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
autoreconf: /usr/bin/autoconf failed with exit status: 1
make: *** [Makefile:9: all] Error 1

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/7
Repository URL: https://github.com/alsa-project/alsa-tools
