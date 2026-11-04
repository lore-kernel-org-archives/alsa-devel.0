Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD46606A329
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=G1tIwepQ;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VDXaW9F8
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC8C26022B;
	Wed,  4 Nov 2026 06:47:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC8C26022B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793771249;
	bh=qhahMrQYHLJ+Qp5l4x02iu2RBmtmF/q7vKTTQcducQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=G1tIwepQb1h8IBAIkfzhqzOPrzjHiWaEgH0+rW6chgx4J+U9tt3hF2D9hoiYm5G1y
	 ZIb7Bg2vsNDkR8+aaQWd7S2UfHspjOhompXaTmgbKxEPg3X8J5VRU471CTFq7Ohjpo
	 DBqr0YiHpujjIuWd4x4JH+CJbqugIkH8R6YLp5nw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1896DF805FC; Wed,  4 Nov 2026 06:46:55 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D64EF8055B;
	Wed,  4 Nov 2026 06:46:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4FBE3F805AA; Wed,  4 Nov 2026 06:46:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793771203;
	b=G6ACzUmi1MKibhONpjaF8H5VTAscrVeXJufpGAoMmqlzL4aC2WdBqCVxFpWHB++r+xwI
	 h+j9Zxk5vIMghwde49atkHF8eNnkeeiUgFpihClpwxQI4npkTEKMqy/yNmnCPcqA7vp5q
	 qQ9m/n/RBgxbcaf1dMB6wDRMMIvU4e7iOvJLDoLqa7i5mrTfvKk5EckWbkbv0sIIet4Mu
	 y1I925FFI9TFhEUl+KBVciY9Vt3XOnnThZEuf/i86z9EFlAC+lnkrM1FiL+QVsfo4Cfp6
	 xgpMH3wDT2AtF60ddFLLWM+TQznyg/cjDF2ssk1j7MeYYwvUDb0pI1SmfXBSEPglnrw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793771203;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=qhahMrQYHLJ+Qp5l4x02iu2RBmtmF/q7vKTTQcducQ4=;
	b=R0I614NtzrL7bKtaeDcLaBDsUCQ+OFbkadxxNwVNcCSXqoYTtcdiATDZjhRqiJSQmTW7
	 3jfmXc4BhEB5Rtn30EdDhr2768ZfJwlWeY0usYx86gSj/q+P8vN84rMRUeDjx0kLcE17E
	 4GS4r6Pl/FeY1dA1LeSdBLCutn0jX6wQPAnphUN/ogF4mwMKzWVrJ9NXbqGTBpjXEpkJv
	 vjiXKq8JqHFae6Oy/q6SN8h8PXk0LJz9OAorNe1MDmEomAcfgPWUiTwrkjBTHvm8zXV6b
	 tLFsH4YfPlDhWVsk+WZoelPvOEGBrp2Ykm2QlW2M3Pdfzp0NSy4jfJ8Xjbfit/3JcMw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VDXaW9F8;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3781EF800E4
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2026 06:46:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3781EF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VDXaW9F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793771203; x=1825307203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qhahMrQYHLJ+Qp5l4x02iu2RBmtmF/q7vKTTQcducQ4=;
  b=VDXaW9F87swlU5JX9iDp/9Dwh7nY9Tnnxg7YYq23XIgSryk867o98yq8
   wyDJo++11oCICmmWGz1qK+8DnKKkBKC0XdDNDo7ubjjiiNNyjYiHVKUQk
   D9ixsh0IfT7gILv6rtlxKHBifUuYA+EKhNelgv27f7nz52bFaLxEeZysc
   3ow68RJ0d5DqmRyG5yvyRfKFn2lW06dfgUfOZcEjwgZyqsUx9OPrgXpfh
   nwjJtqQzJ923hhxddRdq6FtRSogZMP96zMkotn4caVUwVtzw+joGBKwgD
   uS8Vtw/NAWGetl7qGx8sK3+WhK9IzP1hj6S1wTsgKixu1tJxhHtwpG5s+
   Q==;
X-CSE-ConnectionGUID: fM8o+simShCtw01gHozn3A==
X-CSE-MsgGUID: h07drHVES9WmLWiMJVMwXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2608632"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400";
   d="scan'208";a="2608632"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 21:46:36 -0800
X-CSE-ConnectionGUID: S2thmX75Qq211O7/p4MTlw==
X-CSE-MsgGUID: BV6HQmkQTH+rilKIKIhjKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400";
   d="scan'208";a="6448714"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Nov 2026 21:46:30 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOTpL-00000000jpl-1Agm;
	Wed, 04 Nov 2026 05:46:27 +0000
Date: Wed, 4 Nov 2026 13:45:43 +0800
From: kernel test robot <lkp@intel.com>
To: Baojun Xu <baojun.xu@ti.com>, broonie@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, tiwai@suse.de,
	andriy.shevchenko@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com, baojun.xu@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com,
	pin-hao.huang@hp.com, Syed.SabaKareem@amd.com
Subject: Re: [PATCH v1] ASoC: tas2783-sdw: Add basic BPT support
Message-ID: <202611041243.Bn9AJATC-lkp@intel.com>
References: <20261103133853.1612-1-baojun.xu@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103133853.1612-1-baojun.xu@ti.com>
Message-ID-Hash: PUZRD3NCVBNCQU2VZY6JLX6TYRN2DUCM
X-Message-ID-Hash: PUZRD3NCVBNCQU2VZY6JLX6TYRN2DUCM
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PUZRD3NCVBNCQU2VZY6JLX6TYRN2DUCM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Hi Baojun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master next-20261030]
[cannot apply to v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baojun-Xu/ASoC-tas2783-sdw-Add-basic-BPT-support/20261103-213853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20261103133853.1612-1-baojun.xu%40ti.com
patch subject: [PATCH v1] ASoC: tas2783-sdw: Add basic BPT support
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20261104/202611041243.Bn9AJATC-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 65303e81f481bbfe386b8596423f94c43198ba94)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261104/202611041243.Bn9AJATC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611041243.Bn9AJATC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/tas2783-sdw.c:1369:6: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
    1369 |         if (ret) {
         |             ^~~
   sound/soc/codecs/tas2783-sdw.c:1362:9: note: initialize the variable 'ret' to silence this warning
    1362 |         s32 ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +/ret +1369 sound/soc/codecs/tas2783-sdw.c

  1357	
  1358	static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
  1359	{
  1360		struct tas2783_prv *tas_dev = dev_get_drvdata(dev);
  1361		uint val;
  1362		s32 ret;
  1363	
  1364		if (tas_dev->hw_init)
  1365			return 0;
  1366	
  1367		regmap_read(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), &val);
  1368		dev_dbg(dev, "Got B0P0R7 = %02X with %d.", val, ret);
> 1369		if (ret) {
  1370			dev_err(dev, "Get FW download status failed, err=%d", ret);
  1371			return ret;
  1372		}
  1373		if (val != 0x22) {
  1374			tas_dev->fw_dl_success = false;
  1375			ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
  1376			if (ret) {
  1377				dev_err(dev, "sw reset failed, err=%d", ret);
  1378				return ret;
  1379			}
  1380			usleep_range(2000, 2200);
  1381			regcache_cache_only(tas_dev->regmap, false);
  1382			tas_dev->fw_use_fallback = false;
  1383			ret = tas_fw_load(tas_dev, slave);
  1384			if (!ret && tas_dev->fw_use_fallback)
  1385				ret = tas_fw_load(tas_dev, slave);
  1386		}
  1387		if (!ret) {
  1388			if (tas_dev->sa_func_data)
  1389				ret = sdca_regmap_write_init(dev, tas_dev->regmap,
  1390							     tas_dev->sa_func_data);
  1391			else
  1392				ret = regmap_multi_reg_write(tas_dev->regmap, tas2783_init_seq,
  1393							     ARRAY_SIZE(tas2783_init_seq));
  1394	
  1395			/* Re-active AMP after resume. */
  1396			regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 2), 0);
  1397			if (ret)
  1398				dev_err(tas_dev->dev,
  1399					"init writes failed, err=%d", ret);
  1400			else
  1401				tas_dev->hw_init = true;
  1402		}
  1403	
  1404		return ret;
  1405	}
  1406	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
