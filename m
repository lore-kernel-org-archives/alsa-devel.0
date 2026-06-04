Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84DFCD6E4A
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:19:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AECE46025E;
	Thu,  4 Jun 2026 17:19:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AECE46025E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780586374;
	bh=H8D7iVJ/YN5Ig7PX2OqZSnSfM5zhnJuIydjS+/E/iBw=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=PdK0sEcJqdz3E2Lde0hJlw18fJ9qFGfoEBk+Ize3DVyvSNYAjwHFSO1EejVINBftG
	 Y+HllSVzFTxm8j7A1oavsMzETbmdVMRKPtrpCwLi4hUNLE4L5/hFMBFqmNEYTdSSZf
	 Ugvufyj/EQia3ZIlzqp8/QsQkNtgsFQ4dEcRHrhA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 432EFF805FF; Thu,  4 Jun 2026 17:19:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D0E35F805F7;
	Thu,  4 Jun 2026 17:18:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4FBC1F804CC; Thu,  4 Jun 2026 17:18:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780586330;
	b=Brj3h6rSgGQKLCPMmXF/LmpRxvalXDHodHjHGAUqvobeTvkMAm2KHFTRE0qjWJ/7zj2s
	 ytvn+Hj3lzaSKZ1tohbHlfvmbd99Tx9xW3nDiAJtQ9r4XGhIhQ3nvnAA5ETITVs0ZPAp4
	 4p7RNzE0N7cdBrGkqqq1aTLAZ0984QCTqVDfr9X8+g4IHfAbVLMStPNbi/9qHZNEl/uSo
	 COBJt8mfQ7KSrXoOtaYLS54kAD3gIAwnCFwDPC97HqHRJmU4Q0gMcah6zI36Ik3vpKAmm
	 XDeu3Kh5VVqAx1pVCO2ySR2nHJTw7B70ywgStg6lxdCPBkI2CjEDnaQ28teuDBG4RCg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780586330;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=H8D7iVJ/YN5Ig7PX2OqZSnSfM5zhnJuIydjS+/E/iBw=;
	b=mPbmyXbeRwWZx0GXChDYUpWBO6xhyANmYJSogFjiZZ4ivjOlAHMRxOBLd/6znso2FnEA
	 1q4JwnvSB2WDFnIFGOU3t/1eoUyuZbnfr9GjQvgM69xD3gNUH+UD9fOxwwzc9pLG60O9I
	 DUjzJxtlTe9ugtXYNpYMDk+gDWVPOi2VTKe6pU/3iQW6/ptO27fUJ3OPfG951VSKQpdhR
	 f1mD0vtlnRn4xOLKEaN2ZXWHmQ08zUfxpwr5sLWknQzoAtkjKbClWQuQLISIUtuJ8XtWq
	 Aq6bf8+V8bBj227KxwfJKaSU87BbKY7r04iHrrmf2YXmy8BD9szBLisXrK7bzkE+0Mw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JZsdIcP+;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8B5BFF800B0
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 17:18:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B5BFF800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JZsdIcP+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780586330; x=1812122330;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=H8D7iVJ/YN5Ig7PX2OqZSnSfM5zhnJuIydjS+/E/iBw=;
  b=JZsdIcP+zNWFhpsVkG+ONuYNInPgreFikfezZqlGjFQ3TvKmxWfeqsIw
   4YIKbj73QWr93qqSN9a1dPainHhmxol9ENbWxBR1ho6dKh1zFDfyg9ffl
   VaQ11Q9Xyp6NMhzWckn4FauRsvnNz0oYfvS23zS1ax8X1kGfFbWybnJYC
   00YyKp46JJbiAQ+K4FrbLsgPWbbXQlhgMGSMulcASWlGRTTC/cee3rR4v
   +2e0PACQS4tnqZVloxrIamocoSPeOZI/DhtF5Om3nNnGQf5aRszltGP6Z
   X5LJvrfQDqsCzewBVD4ZmmgmLnrfWE3RnLbRq6rHjTYBgX2NZ+kYIsJeK
   Q==;
X-CSE-ConnectionGUID: Hk1RJPzYS9eWk9NwJentNA==
X-CSE-MsgGUID: hXhYgFj7T8C+jursk6/Idw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="98985777"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600";
   d="scan'208";a="98985777"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 08:18:44 -0700
X-CSE-ConnectionGUID: Rk18kJRERaWJVlvBvFyupg==
X-CSE-MsgGUID: Pq55uzfcSDOLpD//gpiXgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600";
   d="scan'208";a="249493369"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 Jun 2026 08:18:42 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wV9qB-00000000Ero-47IE;
	Thu, 04 Jun 2026 15:18:39 +0000
Date: Thu, 04 Jun 2026 23:18:30 +0800
From: kernel test robot <lkp@intel.com>
To: wangdicheng <wangdicheng@kylinos.cn>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>
Subject: [tiwai-sound:for-next 25/29]
 sound/usb/qcom/qc_audio_offload.c:1046:13: warning: unused variable 'mult'
Message-ID: <202606042334.LA2i87XG-lkp@intel.com>
User-Agent: s-nail v14.9.25
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: QSZGWHE74FJTI24V4YJVUVJ72O7EDFVH
X-Message-ID-Hash: QSZGWHE74FJTI24V4YJVUVJ72O7EDFVH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QSZGWHE74FJTI24V4YJVUVJ72O7EDFVH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for=
-next
head:   64917f839d373df2573eb47f271df98f1daef7fa
commit: f1f16e1809c8f9e4a3c39f165efe114e0e292d8e [25/29] ALSA: usb-audio: q=
com: Use PAGE_ALIGN macro for buffer size calculation
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260604=
/202606042334.LA2i87XG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20260604/202606042334.LA2i87XG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606042334.LA2i87XG-lkp@i=
ntel.com/

All warnings (new ones prefixed by >>):

   sound/usb/qcom/qc_audio_offload.c: In function 'uaudio_transfer_buffer_s=
etup':
>> sound/usb/qcom/qc_audio_offload.c:1046:13: warning: unused variable 'mul=
t' [-Wunused-variable]
    1046 |         u32 mult;
         |             ^~~~
>> sound/usb/qcom/qc_audio_offload.c:1045:13: warning: unused variable 'rem=
ainder' [-Wunused-variable]
    1045 |         u32 remainder;
         |             ^~~~~~~~~


vim +/mult +1046 sound/usb/qcom/qc_audio_offload.c

326bbc348298ab0 Wesley Cheng   2025-04-09  1022 =20
326bbc348298ab0 Wesley Cheng   2025-04-09  1023  /**
326bbc348298ab0 Wesley Cheng   2025-04-09  1024   * uaudio_transfer_buffer_=
setup() - fetch and populate xfer buffer params
326bbc348298ab0 Wesley Cheng   2025-04-09  1025   * @subs: usb substream
1d6452a0ce78cd3 Takashi Iwai   2026-02-26  1026   * @xfer_buf_cpu: xfer buf=
 to be allocated
326bbc348298ab0 Wesley Cheng   2025-04-09  1027   * @xfer_buf_len: size of =
allocation
326bbc348298ab0 Wesley Cheng   2025-04-09  1028   * @mem_info: QMI response=
 info
326bbc348298ab0 Wesley Cheng   2025-04-09  1029   *
326bbc348298ab0 Wesley Cheng   2025-04-09  1030   * Allocates and maps the =
transfer buffers that will be utilized by the
326bbc348298ab0 Wesley Cheng   2025-04-09  1031   * audio DSP.  Will popula=
te the information in the QMI response that is
326bbc348298ab0 Wesley Cheng   2025-04-09  1032   * sent back to the stream=
 enable request.
326bbc348298ab0 Wesley Cheng   2025-04-09  1033   *
326bbc348298ab0 Wesley Cheng   2025-04-09  1034   */
326bbc348298ab0 Wesley Cheng   2025-04-09  1035  static int uaudio_transfer=
_buffer_setup(struct snd_usb_substream *subs,
5c7ef5001292d70 Arnd Bergmann  2025-05-13  1036  					void **xfer_buf_cpu, =
u32 xfer_buf_len,
326bbc348298ab0 Wesley Cheng   2025-04-09  1037  					struct mem_info_v01 *=
mem_info)
326bbc348298ab0 Wesley Cheng   2025-04-09  1038  {
326bbc348298ab0 Wesley Cheng   2025-04-09  1039  	struct sg_table xfer_buf_=
sgt;
3335a1bbd62417f Arnd Bergmann  2025-05-13  1040  	dma_addr_t xfer_buf_dma;
5c7ef5001292d70 Arnd Bergmann  2025-05-13  1041  	void *xfer_buf;
326bbc348298ab0 Wesley Cheng   2025-04-09  1042  	u32 len =3D xfer_buf_len;
326bbc348298ab0 Wesley Cheng   2025-04-09  1043  	bool dma_coherent;
3335a1bbd62417f Arnd Bergmann  2025-05-13  1044  	dma_addr_t xfer_buf_dma_s=
ysdev;
326bbc348298ab0 Wesley Cheng   2025-04-09 @1045  	u32 remainder;
326bbc348298ab0 Wesley Cheng   2025-04-09 @1046  	u32 mult;
326bbc348298ab0 Wesley Cheng   2025-04-09  1047  	int ret;
326bbc348298ab0 Wesley Cheng   2025-04-09  1048 =20
326bbc348298ab0 Wesley Cheng   2025-04-09  1049  	dma_coherent =3D dev_is_d=
ma_coherent(subs->dev->bus->sysdev);
326bbc348298ab0 Wesley Cheng   2025-04-09  1050 =20
326bbc348298ab0 Wesley Cheng   2025-04-09  1051  	/* xfer buffer, multiple =
of 4K only */
326bbc348298ab0 Wesley Cheng   2025-04-09  1052  	if (!len)
326bbc348298ab0 Wesley Cheng   2025-04-09  1053  		len =3D PAGE_SIZE;
326bbc348298ab0 Wesley Cheng   2025-04-09  1054 =20
f1f16e1809c8f9e wangdicheng    2026-06-03  1055  	len =3D PAGE_ALIGN(len);
326bbc348298ab0 Wesley Cheng   2025-04-09  1056 =20
326bbc348298ab0 Wesley Cheng   2025-04-09  1057  	if (len > MAX_XFER_BUFF_L=
EN) {
326bbc348298ab0 Wesley Cheng   2025-04-09  1058  		dev_err(uaudio_qdev->dat=
a->dev,
326bbc348298ab0 Wesley Cheng   2025-04-09  1059  			"req buf len %d > max b=
uf len %lu, setting %lu\n",
326bbc348298ab0 Wesley Cheng   2025-04-09  1060  			len, MAX_XFER_BUFF_LEN,=
 MAX_XFER_BUFF_LEN);
326bbc348298ab0 Wesley Cheng   2025-04-09  1061  		len =3D MAX_XFER_BUFF_LE=
N;
326bbc348298ab0 Wesley Cheng   2025-04-09  1062  	}
326bbc348298ab0 Wesley Cheng   2025-04-09  1063 =20
3335a1bbd62417f Arnd Bergmann  2025-05-13  1064  	/* get buffer mapped into=
 subs->dev */
3335a1bbd62417f Arnd Bergmann  2025-05-13  1065  	xfer_buf =3D usb_alloc_co=
herent(subs->dev, len, GFP_KERNEL, &xfer_buf_dma);
326bbc348298ab0 Wesley Cheng   2025-04-09  1066  	if (!xfer_buf)
326bbc348298ab0 Wesley Cheng   2025-04-09  1067  		return -ENOMEM;
326bbc348298ab0 Wesley Cheng   2025-04-09  1068 =20
814b2c9b30e5607 C=C3=A1ssio Gabriel 2026-05-11  1069  	ret =3D dma_get_sgta=
ble(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf,
3335a1bbd62417f Arnd Bergmann  2025-05-13  1070  			      xfer_buf_dma, len=
);
814b2c9b30e5607 C=C3=A1ssio Gabriel 2026-05-11  1071  	if (ret)
814b2c9b30e5607 C=C3=A1ssio Gabriel 2026-05-11  1072  		goto free_xfer_buf;
3335a1bbd62417f Arnd Bergmann  2025-05-13  1073 =20
3335a1bbd62417f Arnd Bergmann  2025-05-13  1074  	/* map the physical buffe=
r into sysdev as well */
44499ecb4f28177 Takashi Iwai   2025-09-17  1075  	xfer_buf_dma_sysdev =3D u=
audio_iommu_map_xfer_buf(dma_coherent,
44499ecb4f28177 Takashi Iwai   2025-09-17  1076  							len, &xfer_buf_sgt);
3335a1bbd62417f Arnd Bergmann  2025-05-13  1077  	if (!xfer_buf_dma_sysdev)=
 {
326bbc348298ab0 Wesley Cheng   2025-04-09  1078  		ret =3D -ENOMEM;
814b2c9b30e5607 C=C3=A1ssio Gabriel 2026-05-11  1079  		goto free_sgt;
326bbc348298ab0 Wesley Cheng   2025-04-09  1080  	}
326bbc348298ab0 Wesley Cheng   2025-04-09  1081 =20
3335a1bbd62417f Arnd Bergmann  2025-05-13  1082  	mem_info->dma =3D xfer_bu=
f_dma;
326bbc348298ab0 Wesley Cheng   2025-04-09  1083  	mem_info->size =3D len;
3335a1bbd62417f Arnd Bergmann  2025-05-13  1084  	mem_info->iova =3D PREPEN=
D_SID_TO_IOVA(xfer_buf_dma_sysdev, uaudio_qdev->data->sid);
5c7ef5001292d70 Arnd Bergmann  2025-05-13  1085  	*xfer_buf_cpu =3D xfer_bu=
f;
326bbc348298ab0 Wesley Cheng   2025-04-09  1086  	sg_free_table(&xfer_buf_s=
gt);
326bbc348298ab0 Wesley Cheng   2025-04-09  1087 =20
326bbc348298ab0 Wesley Cheng   2025-04-09  1088  	return 0;
326bbc348298ab0 Wesley Cheng   2025-04-09  1089 =20
814b2c9b30e5607 C=C3=A1ssio Gabriel 2026-05-11  1090  free_sgt:
814b2c9b30e5607 C=C3=A1ssio Gabriel 2026-05-11  1091  	sg_free_table(&xfer_=
buf_sgt);
814b2c9b30e5607 C=C3=A1ssio Gabriel 2026-05-11  1092  free_xfer_buf:
3335a1bbd62417f Arnd Bergmann  2025-05-13  1093  	usb_free_coherent(subs->d=
ev, len, xfer_buf, xfer_buf_dma);
326bbc348298ab0 Wesley Cheng   2025-04-09  1094 =20
326bbc348298ab0 Wesley Cheng   2025-04-09  1095  	return ret;
326bbc348298ab0 Wesley Cheng   2025-04-09  1096  }
326bbc348298ab0 Wesley Cheng   2025-04-09  1097 =20

:::::: The code at line 1046 was first introduced by commit
:::::: 326bbc348298ab0946c5560defe024a5f6ef28bb ALSA: usb-audio: qcom: Intr=
oduce QC USB SND offloading support

:::::: TO: Wesley Cheng <quic_wcheng@quicinc.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
