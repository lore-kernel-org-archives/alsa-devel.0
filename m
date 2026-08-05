Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA6CC55174
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 22:45:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E979E6021E;
	Thu,  6 Aug 2026 00:45:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E979E6021E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785969939;
	bh=OYmHsyMIoZ8e1Utz+0y7ood/VOLz41ZkgVg9yefQFUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=avJxTKWKvr9cGRTLbly3ZbAwwZwxxuoTMedD3hNTRdh3OXS+634TnCP7a+7h6+76j
	 B5HhKyR3Ak+6pC1W4E3YjgbTsYIj+hWT/JvEXnoSu8d+611UKi40DeBy5U7dBTjZlE
	 R6JVDHh5bNfnoxdrba4YS+CKE4gLB4p/+zlL+o2o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A121DF805FF; Thu,  6 Aug 2026 00:45:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42F89F80600;
	Thu,  6 Aug 2026 00:45:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 460A0F8055A; Thu,  6 Aug 2026 00:44:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785969892;
	b=AO9Wx8xkmS4hVXVKXzVzOPW9jwg3qrKB9BjBDlvpk8ssZSobhcm/uOkQZ0/jq1YK8Ec8
	 ZiX75FSIYY5vD7q2vkKWjfvX5rhDMtFicn44tDX6nLG3s4oWTWOdrbkDI5Xns6XHchLd6
	 sfzg9PKs7wQea/UlSW1SgSkXY/qH/NF5v7SqgJGJq6SFpDY+91pCTYzm5lAApp2Y1vwo2
	 Ftb877AitU6BJNkWqPK7cqEwKiLG2cWpCmlGzT6uxg+R+8EBfaAJ1zeu3vG0SW9rNE+K3
	 C7DJlKTWGRlaH5kEl8JSEKzYncFN8kdMhA1ElGVTJ51zwwiEs17Twccn0CQCrj0XZTg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785969892;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=OYmHsyMIoZ8e1Utz+0y7ood/VOLz41ZkgVg9yefQFUc=;
	b=O9bpTNiSpYAuV/TpmiIdj4q5Rd+PGqjAEZPrZyp+t6YhIVGMsUqp7BXfiloLqrLlQGXk
	 xb3xRKFwc9nHMmpJBNKTIOKC12sTKHX4RfidCHJUCl8cBicexoQ6WHxWR26yFErNi4oO0
	 Dy2VzHurD2tr4hwEDxnuY5vK484juMNhnYMRkWGyx6TssYYqC9puQK4PIbX0ZklcQXFxx
	 767cFfQ4AJiEmK3wSJcOVGl/2CYtg9qCUCKMcA+0i1NQejItOhR8/70x9CAtcTJyHcac2
	 sVpzSLpIMzL+cEM2qh217UL5kCmmWOuIK2ovJ9/ZBpwsKEiY4p5dUZxH1US6OBKo+aA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RNygB0nb;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0ECC7F800BA
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 00:44:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0ECC7F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RNygB0nb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785969892; x=1817505892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OYmHsyMIoZ8e1Utz+0y7ood/VOLz41ZkgVg9yefQFUc=;
  b=RNygB0nbBfZ6C3Q8RSpJjkR2SsXs3gT7+W4eIe3WEtKmydWKvkJcyxPV
   YdZ3yetaX4e7UUv0XDBs5Ddawet7XWOzVPGDRbylii0+GNJkUCQNYy0VW
   /iBHQCRukA+nGYRgXniVnbrn/IBSeCeAs+Xnl7qoWvvotDJnY5XcrVVGK
   IdFq6PVmNjU+trpeprHDDTHhIDrwYIC8F0f0kgMuR7jvBhzykXxbNQLxp
   ljbIh3CMY2X6KgRy1mBJzb08AYtM+z2GQ4Iwk/pSQVj7Y7Wiov7+MLQsi
   ZUm9nyTPGjUZ1poN5sUHbFUvwEgMW5Ny1x6zeZTbwvFR0/CvfT/1Gl1PR
   Q==;
X-CSE-ConnectionGUID: z2tDrRIlQPyx25M77QJu4w==
X-CSE-MsgGUID: 61jCORJcSqacXhsaDC8k+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90440220"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000";
   d="scan'208";a="90440220"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 15:44:46 -0700
X-CSE-ConnectionGUID: +5wbzIy0T0WCAvP8AkWrHQ==
X-CSE-MsgGUID: 6Kgzx6X8SUOhBmHwjfn2PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000";
   d="scan'208";a="260154829"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 05 Aug 2026 15:44:44 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrkLo-00000000Dbh-48K7;
	Wed, 05 Aug 2026 22:44:40 +0000
Date: Thu, 6 Aug 2026 06:44:27 +0800
From: kernel test robot <lkp@intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andriy.shevchenko@linux.intel.com, tiwai@suse.de,
	13916275206@139.com, krzk@kernel.org, alsa-devel@alsa-project.org,
	baojun.xu@ti.com, riyo@ti.com, Shenghao Ding <shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Add calibration kcontrols for TAS2573
Message-ID: <202608060659.Lp45DCOl-lkp@intel.com>
References: <20260717073927.181-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717073927.181-1-shenghao-ding@ti.com>
Message-ID-Hash: CKNW6JV2VN47NJ4G7QJ2OI2WXVEJ3QQV
X-Message-ID-Hash: CKNW6JV2VN47NJ4G7QJ2OI2WXVEJ3QQV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CKNW6JV2VN47NJ4G7QJ2OI2WXVEJ3QQV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Shenghao,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.2-rc4]
[also build test ERROR on linus/master next-20260805]
[cannot apply to broonie-sound/for-next tiwai-sound/for-next tiwai-sound/for-linus v7.2-rc6 v7.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Ding/ASoC-tas2781-Add-calibration-kcontrols-for-TAS2573/20260805-132520
base:   v7.2-rc4
patch link:    https://lore.kernel.org/r/20260717073927.181-1-shenghao-ding%40ti.com
patch subject: [PATCH v1] ASoC: tas2781: Add calibration kcontrols for TAS2573
config: s390-randconfig-002-20260806 (https://download.01.org/0day-ci/archive/20260806/202608060659.Lp45DCOl-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project bacfe2950f8218268fcc0a8765644ea0c15f0360)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260806/202608060659.Lp45DCOl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608060659.Lp45DCOl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/soc/codecs/tas2781-i2c.c:1774:3: error: cannot jump from this goto statement to its label
    1774 |                 goto exit;
         |                 ^
   sound/soc/codecs/tas2781-i2c.c:1779:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1779 |         guard(mutex)(&priv->codec_lock);
         |         ^
   include/linux/cleanup.h:423:2: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:102:1: note: expanded from here
     102 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:108:1: note: expanded from here
     108 | __UNIQUE_ID_unlock_565
         | ^
   sound/soc/codecs/tas2781-i2c.c:1779:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:423:15: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:165:2: note: expanded from macro '__UNIQUE_ID'
     165 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:96:1: note: expanded from here
      96 | __UNIQUE_ID_guard_564
         | ^
   sound/soc/codecs/tas2781-i2c.c:1763:3: error: cannot jump from this goto statement to its label
    1763 |                 goto exit;
         |                 ^
   sound/soc/codecs/tas2781-i2c.c:1779:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1779 |         guard(mutex)(&priv->codec_lock);
         |         ^
   include/linux/cleanup.h:423:2: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:102:1: note: expanded from here
     102 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:108:1: note: expanded from here
     108 | __UNIQUE_ID_unlock_565
         | ^
   sound/soc/codecs/tas2781-i2c.c:1779:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:423:15: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:165:2: note: expanded from macro '__UNIQUE_ID'
     165 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:96:1: note: expanded from here
      96 | __UNIQUE_ID_guard_564
         | ^
   sound/soc/codecs/tas2781-i2c.c:1757:3: error: cannot jump from this goto statement to its label
    1757 |                 goto exit;
         |                 ^
   sound/soc/codecs/tas2781-i2c.c:1779:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1779 |         guard(mutex)(&priv->codec_lock);
         |         ^
   include/linux/cleanup.h:423:2: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:102:1: note: expanded from here
     102 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^


vim +1774 sound/soc/codecs/tas2781-i2c.c

d75d38dc460452c Shenghao Ding  2025-05-07  1715  
d75d38dc460452c Shenghao Ding  2025-05-07  1716  static ssize_t acoustic_ctl_write(struct file *file,
d75d38dc460452c Shenghao Ding  2025-05-07  1717  	const char __user *from, size_t count, loff_t *ppos)
d75d38dc460452c Shenghao Ding  2025-05-07  1718  {
d75d38dc460452c Shenghao Ding  2025-05-07  1719  	struct snd_soc_component *comp = file->private_data;
d75d38dc460452c Shenghao Ding  2025-05-07  1720  	struct tasdevice_priv *priv = snd_soc_component_get_drvdata(comp);
d75d38dc460452c Shenghao Ding  2025-05-07  1721  	struct acoustic_data *p = &priv->acou_data;
d75d38dc460452c Shenghao Ding  2025-05-07  1722  	unsigned int max_pkg_len = sizeof(*p);
d75d38dc460452c Shenghao Ding  2025-05-07  1723  	unsigned char *src;
d75d38dc460452c Shenghao Ding  2025-05-07  1724  	int j, len, reg, val;
d75d38dc460452c Shenghao Ding  2025-05-07  1725  	unsigned short chn;
d75d38dc460452c Shenghao Ding  2025-05-07  1726  	int ret = -1;
d75d38dc460452c Shenghao Ding  2025-05-07  1727  
d75d38dc460452c Shenghao Ding  2025-05-07  1728  	if (count > sizeof(*p)) {
d75d38dc460452c Shenghao Ding  2025-05-07  1729  		dev_err(priv->dev, "count(%u) is larger than max(%u).\n",
d75d38dc460452c Shenghao Ding  2025-05-07  1730  			(unsigned int)count, max_pkg_len);
d75d38dc460452c Shenghao Ding  2025-05-07  1731  		return ret;
d75d38dc460452c Shenghao Ding  2025-05-07  1732  	}
d75d38dc460452c Shenghao Ding  2025-05-07  1733  
d75d38dc460452c Shenghao Ding  2025-05-07  1734  	src = memdup_user(from, count);
d75d38dc460452c Shenghao Ding  2025-05-07  1735  	if (IS_ERR(src))
d75d38dc460452c Shenghao Ding  2025-05-07  1736  		return PTR_ERR(src);
d75d38dc460452c Shenghao Ding  2025-05-07  1737  
d75d38dc460452c Shenghao Ding  2025-05-07  1738  	if (src[0] > max_pkg_len && src[0] != count) {
b11f2a9745401d9 Colin Ian King 2025-08-08  1739  		dev_err(priv->dev, "pkg(%u), max(%u), count(%u) mismatch.\n",
d75d38dc460452c Shenghao Ding  2025-05-07  1740  			src[0], max_pkg_len, (unsigned int)count);
d75d38dc460452c Shenghao Ding  2025-05-07  1741  		ret = 0;
d75d38dc460452c Shenghao Ding  2025-05-07  1742  		goto exit;
d75d38dc460452c Shenghao Ding  2025-05-07  1743  	}
d75d38dc460452c Shenghao Ding  2025-05-07  1744  
d75d38dc460452c Shenghao Ding  2025-05-07  1745  	switch (src[1]) {
d75d38dc460452c Shenghao Ding  2025-05-07  1746  	case 'r':
d75d38dc460452c Shenghao Ding  2025-05-07  1747  		/* length of data to read */
d75d38dc460452c Shenghao Ding  2025-05-07  1748  		len = src[6];
d75d38dc460452c Shenghao Ding  2025-05-07  1749  		break;
d75d38dc460452c Shenghao Ding  2025-05-07  1750  	case 'w':
d75d38dc460452c Shenghao Ding  2025-05-07  1751  		/* Skip 6 bytes for package type and register address */
d75d38dc460452c Shenghao Ding  2025-05-07  1752  		len = src[0] - 6;
d75d38dc460452c Shenghao Ding  2025-05-07  1753  		break;
d75d38dc460452c Shenghao Ding  2025-05-07  1754  	default:
d75d38dc460452c Shenghao Ding  2025-05-07  1755  		dev_err(priv->dev, "%s Wrong code %02x.\n", __func__, src[1]);
d75d38dc460452c Shenghao Ding  2025-05-07  1756  		ret = 0;
d75d38dc460452c Shenghao Ding  2025-05-07  1757  		goto exit;
d75d38dc460452c Shenghao Ding  2025-05-07  1758  	}
d75d38dc460452c Shenghao Ding  2025-05-07  1759  
d75d38dc460452c Shenghao Ding  2025-05-07  1760  	if (len < 1) {
d75d38dc460452c Shenghao Ding  2025-05-07  1761  		dev_err(priv->dev, "pkg fmt invalid %02x.\n", len);
d75d38dc460452c Shenghao Ding  2025-05-07  1762  		ret = 0;
d75d38dc460452c Shenghao Ding  2025-05-07  1763  		goto exit;
d75d38dc460452c Shenghao Ding  2025-05-07  1764  	}
d75d38dc460452c Shenghao Ding  2025-05-07  1765  
d75d38dc460452c Shenghao Ding  2025-05-07  1766  	for (j = 0; j < priv->ndev; j++)
d75d38dc460452c Shenghao Ding  2025-05-07  1767  		if (src[2] == priv->tasdevice[j].dev_addr) {
d75d38dc460452c Shenghao Ding  2025-05-07  1768  			chn = j;
d75d38dc460452c Shenghao Ding  2025-05-07  1769  			break;
d75d38dc460452c Shenghao Ding  2025-05-07  1770  		}
d75d38dc460452c Shenghao Ding  2025-05-07  1771  	if (j >= priv->ndev) {
d75d38dc460452c Shenghao Ding  2025-05-07  1772  		dev_err(priv->dev, "no such device 0x%02x.\n", src[2]);
d75d38dc460452c Shenghao Ding  2025-05-07  1773  		ret = 0;
d75d38dc460452c Shenghao Ding  2025-05-07 @1774  		goto exit;
d75d38dc460452c Shenghao Ding  2025-05-07  1775  	}
d75d38dc460452c Shenghao Ding  2025-05-07  1776  
d75d38dc460452c Shenghao Ding  2025-05-07  1777  	reg = TASDEVICE_REG(src[3], src[4], src[5]);
d75d38dc460452c Shenghao Ding  2025-05-07  1778  
d75d38dc460452c Shenghao Ding  2025-05-07  1779  	guard(mutex)(&priv->codec_lock);
d75d38dc460452c Shenghao Ding  2025-05-07  1780  
d75d38dc460452c Shenghao Ding  2025-05-07  1781  	if (src[1] == 'w') {
d75d38dc460452c Shenghao Ding  2025-05-07  1782  		if (len > 1)
d75d38dc460452c Shenghao Ding  2025-05-07  1783  			ret = tasdevice_dev_bulk_write(priv, chn, reg,
d75d38dc460452c Shenghao Ding  2025-05-07  1784  				 &src[6], len);
d75d38dc460452c Shenghao Ding  2025-05-07  1785  		else
d75d38dc460452c Shenghao Ding  2025-05-07  1786  			ret = tasdevice_dev_write(priv, chn, reg, src[6]);
d75d38dc460452c Shenghao Ding  2025-05-07  1787  	} else {
d75d38dc460452c Shenghao Ding  2025-05-07  1788  		struct acoustic_data *p = &priv->acou_data;
d75d38dc460452c Shenghao Ding  2025-05-07  1789  
d75d38dc460452c Shenghao Ding  2025-05-07  1790  		memcpy(p, src, 6);
d75d38dc460452c Shenghao Ding  2025-05-07  1791  		if (len > 1) {
d75d38dc460452c Shenghao Ding  2025-05-07  1792  			ret = tasdevice_dev_bulk_read(priv, chn, reg,
d75d38dc460452c Shenghao Ding  2025-05-07  1793  				p->data, len);
d75d38dc460452c Shenghao Ding  2025-05-07  1794  		} else {
d75d38dc460452c Shenghao Ding  2025-05-07  1795  			ret = tasdevice_dev_read(priv, chn, reg, &val);
d75d38dc460452c Shenghao Ding  2025-05-07  1796  			p->data[0] = val;
d75d38dc460452c Shenghao Ding  2025-05-07  1797  		}
d75d38dc460452c Shenghao Ding  2025-05-07  1798  		p->len = len + 6;
d75d38dc460452c Shenghao Ding  2025-05-07  1799  	}
d75d38dc460452c Shenghao Ding  2025-05-07  1800  
d75d38dc460452c Shenghao Ding  2025-05-07  1801  	if (ret)
d75d38dc460452c Shenghao Ding  2025-05-07  1802  		dev_err(priv->dev, "i2c communication error.\n");
d75d38dc460452c Shenghao Ding  2025-05-07  1803  	else
d75d38dc460452c Shenghao Ding  2025-05-07  1804  		ret = count;
d75d38dc460452c Shenghao Ding  2025-05-07  1805  exit:
d75d38dc460452c Shenghao Ding  2025-05-07  1806  	kfree(src);
d75d38dc460452c Shenghao Ding  2025-05-07  1807  	return ret;
d75d38dc460452c Shenghao Ding  2025-05-07  1808  }
d75d38dc460452c Shenghao Ding  2025-05-07  1809  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
