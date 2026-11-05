Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06868606A31B
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=M9ah4N1k;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HuZcZLPb
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA508601DA;
	Fri,  6 Nov 2026 00:13:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA508601DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793920445;
	bh=3m5YJxT45jJsMZgi6fCN2NOxcn8tnw5gTGWZtaex9JE=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=M9ah4N1k8BjMISJXKJVFiw1qudMKjxvhNejn68FWeJKnOQs6LzP2+wHCKK7hg2AHC
	 anjUzW5//Oo1GHMsWmUmmHub/LLtUBhuIfwplfK25UsvT0xeeen9N1E8cl3KORoSe6
	 mgz+lUEZFXT+BjJoR6zOIRrg2B15vM5wUBzktR/Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CB64F805EE; Fri,  6 Nov 2026 00:13:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1500F80600;
	Fri,  6 Nov 2026 00:13:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AAD6CF80510; Fri,  6 Nov 2026 00:13:25 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793920403;
	b=ej+4Z8uMyaWR+4lryC3ByYLfwEBceRR2jm4Y16t7UJv4UWQeQ0750RowlWpaf2rqI7i1
	 9Dmp5ZAEM9lCN3R6lDaC/CBKuqhZTH4KdXfGp5UpPXwtBjvWsreO7kMzccxh3LK9Hwv91
	 jw6hKAzE3XSiaQIXEU436cf3H/dl6ciAXw43/HprThpONRrNebjAycbEtRvS2ozEj5xFG
	 NemY4oLpYEG7Vefc5b4s7qGRSlX2MSR7ZQSxpYtUBu8Dxd0N1SnCv3nb8hirpezZ+pmrz
	 3jXvxsGxa/SWbq5iZwulrrC/88T//MophzEqUBf6iV3zzsF3uq5ahAmo/ZcSQdCC2Rw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793920403;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID;
	bh=3m5YJxT45jJsMZgi6fCN2NOxcn8tnw5gTGWZtaex9JE=;
	b=mYQ3oKyX0uouCCCzY8WjPAnbvQTMbf2wuxvmBRL6WNxSKEdmTMSXid6e/mVrCKe5FcvS
	 Us5btDBFzhIP7b3Kcp4LK23Rjwntd5yLbid7WxM1vfV2TSVh5L23hUaSwpy5Rv0FCq+vQ
	 16d6favy6QZZEVt5Xk4vXtRUaYAo9PrFCqPGfOOrqDRNSNBWMriKGgJShFguv46xfmKwP
	 bXLvOxFACwdj0QOQY2CfCH6Ae2e34OkglOBftShkCApQlpXc67dQKi5/0zIr3zRlNw8Rn
	 HKLwfxfd4QiQiKpwBiZ3qFvTfZMztj9rK0YkHWPBp7Q79TKyFoKA7bkQbbmqzEriwug==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HuZcZLPb;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5C247F8024C
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 00:13:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C247F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HuZcZLPb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793920403; x=1825456403;
  h=date:from:to:cc:subject:message-id;
  bh=3m5YJxT45jJsMZgi6fCN2NOxcn8tnw5gTGWZtaex9JE=;
  b=HuZcZLPbaJepvRSnx+R8dPnAIZaWrjs9NoYoqihnFWDUDETQHkzDAVyT
   ekCtdInCH2Yv1EUvgYfaquCyAa5rawA5/QRV2+1SalUL5L3ZZjkqVSCpy
   phF7kmanqrIh/0elzcr8QpPTQteYvFYqN+gGN9kF6Hb0+BkpIBhj7RPpU
   IS4/ef6Gjc0MwVr0k5QvZlg5e5427+2rTrEDZwozeSBQM+u845zMGFP2Y
   k7mQZJVRBiEWO7YK2KqMz+XqLye2GtFQ4F0yVcljLqBf6iKAhpo5YETMm
   GoEdV8VmCkJ6zkCNfKvdi9MaJ1OoM03zBG36rpXvlaXIpUMEEsppGmjxY
   A==;
X-CSE-ConnectionGUID: LeGDn5qMQJqwwhHpEEiWRg==
X-CSE-MsgGUID: QWAMQo6JT+eL81GBfzXksQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2758539"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="2758539"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 15:13:17 -0800
X-CSE-ConnectionGUID: hfaxpErAS5iVQi4d/QHaFA==
X-CSE-MsgGUID: swb4HPHJRj20A6gpDcas7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400";
   d="scan'208";a="7120511"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 05 Nov 2026 15:13:14 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP6dr-000000009s3-2u4e;
	Thu, 05 Nov 2026 23:13:11 +0000
Date: Fri, 06 Nov 2026 00:12:21 +0100
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org
Subject: [tiwai-sound:test/sound-rust-v7.3 20/56]
 include/sound/memalloc.h:110:undefined reference to
 `snd_devm_alloc_dir_pages'
Message-ID: <202611060005.eBnLKlRD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Message-ID-Hash: EY4CS33SAIXWLQDNRXPPYAPKVWJN73VR
X-Message-ID-Hash: EY4CS33SAIXWLQDNRXPPYAPKVWJN73VR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EY4CS33SAIXWLQDNRXPPYAPKVWJN73VR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git test/sound-rust-v7.3
head:   070444a8abf14da700680a5331d0a95cd11e578b
commit: fe14e02c46f52dd6e08b7e070f82849d8ae1a500 [20/56] ALSA: rust: pcm: Add DmaBuffer wrapper for snd_devm_alloc_pages
config: um-randconfig-2200-20261105 (https://download.01.org/0day-ci/archive/20261106/202611060005.eBnLKlRD-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611060005.eBnLKlRD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611060005.eBnLKlRD-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/lib/gcc/i686-linux-gnu/14/../../../../i686-linux-gnu/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
   /usr/lib/gcc/i686-linux-gnu/14/../../../../i686-linux-gnu/bin/ld: rust/helpers/helpers.o: in function `snd_devm_alloc_pages':
>> include/sound/memalloc.h:110:(.text+0x9212): undefined reference to `snd_devm_alloc_dir_pages'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)


vim +110 include/sound/memalloc.h

a25684a956468e Takashi Iwai 2021-10-17   96  
37af81c5998f4b Takashi Iwai 2021-06-09   97  dma_addr_t snd_sgbuf_get_addr(struct snd_dma_buffer *dmab, size_t offset);
37af81c5998f4b Takashi Iwai 2021-06-09   98  struct page *snd_sgbuf_get_page(struct snd_dma_buffer *dmab, size_t offset);
37af81c5998f4b Takashi Iwai 2021-06-09   99  unsigned int snd_sgbuf_get_chunk_size(struct snd_dma_buffer *dmab,
37af81c5998f4b Takashi Iwai 2021-06-09  100  				      unsigned int ofs, unsigned int size);
37af81c5998f4b Takashi Iwai 2021-06-09  101  
427ae2689db0fb Takashi Iwai 2021-07-15  102  /* device-managed memory allocator */
a25684a956468e Takashi Iwai 2021-10-17  103  struct snd_dma_buffer *snd_devm_alloc_dir_pages(struct device *dev, int type,
a25684a956468e Takashi Iwai 2021-10-17  104  						enum dma_data_direction dir,
427ae2689db0fb Takashi Iwai 2021-07-15  105  						size_t size);
427ae2689db0fb Takashi Iwai 2021-07-15  106  
a25684a956468e Takashi Iwai 2021-10-17  107  static inline struct snd_dma_buffer *
a25684a956468e Takashi Iwai 2021-10-17  108  snd_devm_alloc_pages(struct device *dev, int type, size_t size)
a25684a956468e Takashi Iwai 2021-10-17  109  {
a25684a956468e Takashi Iwai 2021-10-17 @110  	return snd_devm_alloc_dir_pages(dev, type, DMA_BIDIRECTIONAL, size);
a25684a956468e Takashi Iwai 2021-10-17  111  }
a25684a956468e Takashi Iwai 2021-10-17  112  

:::::: The code at line 110 was first introduced by commit
:::::: a25684a956468ee8bbbee44649e41e5d447e5adc ALSA: memalloc: Support for non-contiguous page allocation

:::::: TO: Takashi Iwai <tiwai@suse.de>
:::::: CC: Takashi Iwai <tiwai@suse.de>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
