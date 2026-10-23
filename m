Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5A606A31A
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=hLY7Yy52;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CtFxiMzg
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FFA2601EA;
	Fri, 23 Oct 2026 11:36:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FFA2601EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792748227;
	bh=kq7NkE2cr8Qo3l61xI3ohL2L4IDlTWv9dqF/h0S92jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hLY7Yy52bLSgkKdckzUvlh5JOUtOBjFH/V39zYKCrI6NQHRjTyQCdw3TdsQu/dmfB
	 qzmY4ZjdjIGhibpppVSMfDO/d1OMvEmpYjPBW046OLn8/8rbiwET5v2x67o/5HUAXV
	 GdE5PSY4O5Fd9vr+WoL3sdWHM1tjTdHkHyhvnUNI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E95AF80605; Fri, 23 Oct 2026 11:36:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76040F805FE;
	Fri, 23 Oct 2026 11:36:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49853F80548; Fri, 23 Oct 2026 11:36:13 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7609EF800EE
	for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2026 11:36:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7609EF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CtFxiMzg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792748167; x=1824284167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kq7NkE2cr8Qo3l61xI3ohL2L4IDlTWv9dqF/h0S92jI=;
  b=CtFxiMzgF0P0/En6iUwP+2LF0rBJlFXwRD8FBh1reqayLK/kxz+B5s5n
   NbU+s+qV6NO8MlTX8krrPeetEK+c5iT26gR0ixUI4Rw0RwdmAJfJHXiiB
   KcQqcXVCwR0ksLqquqjlxnTx13sNVdPMU8jALPupt7YGGalWLX1goIWTL
   IPHAJQSCM/DsaTT3urttawCRKGLYudRCZw64YWSHeWFd7zLF0I2MIecgm
   NC9J2NeOITb3fv0FhBOEx0zznPfrPh0o9QXs/9KrGZPKZeE94c6K6T+64
   kwiJmVWH33MwlQH9e5/9yBObhSh7kYcqnB4/gRVZJ1tfK5N9jw+jvZgh3
   g==;
X-CSE-ConnectionGUID: 5kEknWgHQu+5r+prjgjfDg==
X-CSE-MsgGUID: 17i+VG/qRdOJjmkgBsGX0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1386860"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400";
   d="scan'208";a="1386860"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:36:01 -0700
X-CSE-ConnectionGUID: MwmaD4hCQVO1BDIjcrs/jw==
X-CSE-MsgGUID: m/wNhlphSg2/f6srMEu9Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400";
   d="scan'208";a="3480953"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 23 Oct 2026 02:35:59 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xKBgq-00000000SUY-2RDC;
	Fri, 23 Oct 2026 09:35:56 +0000
Date: Fri, 23 Oct 2026 17:35:50 +0800
From: kernel test robot <lkp@intel.com>
To: Neo Chang <YLCHANG2@nuvoton.com>, broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com,
	Neo Chang <YLCHANG2@nuvoton.com>
Subject: Re: [PATCH v1 2/2] ASoC: codecs: nau8310: Add support for NAU83G10
 amplifier
Message-ID: <202610231724.YNiXxf9w-lkp@intel.com>
References: <20261022084037.259983-3-YLCHANG2@nuvoton.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022084037.259983-3-YLCHANG2@nuvoton.com>
Message-ID-Hash: XOAFSG4IWHHE4UFOMZPVLQJ3SNMDTT7D
X-Message-ID-Hash: XOAFSG4IWHHE4UFOMZPVLQJ3SNMDTT7D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XOAFSG4IWHHE4UFOMZPVLQJ3SNMDTT7D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Hi Neo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on next-20261022]
[cannot apply to linus/master v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neo-Chang/ASoC-dt-bindings-nuvoton-nau8310-Add-NAU83G10/20261022-164036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20261022084037.259983-3-YLCHANG2%40nuvoton.com
patch subject: [PATCH v1 2/2] ASoC: codecs: nau8310: Add support for NAU83G10 amplifier
config: powerpc-randconfig-1000-20261023 (https://download.01.org/0day-ci/archive/20261023/202610231724.YNiXxf9w-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261023/202610231724.YNiXxf9w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610231724.YNiXxf9w-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'nau8310_send_dsp_command',
       inlined from 'nau8310_dsp_set_kcs_setup' at sound/soc/codecs/nau8310-dsp.c:603:8:
>> sound/soc/codecs/nau8310-dsp.c:419:15: warning: 'kcs_setup_comp.set_kcs_offset' is used uninitialized [-Wuninitialized]
     419 |         ret = nau8310_message_to_dsp(cp, cmd_info, frag_len,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     420 |                 kcs_setup->set_kcs_offset, kcs_setup->set_len,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     421 |                 kcs_setup->set_kcs_data);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/nau8310-dsp.c: In function 'nau8310_dsp_set_kcs_setup':
   sound/soc/codecs/nau8310-dsp.c:592:34: note: 'kcs_setup_comp' declared here
     592 |         struct nau8310_kcs_setup kcs_setup_comp, *kcs_setup = &kcs_setup_comp;
         |                                  ^~~~~~~~~~~~~~
   In function 'nau8310_send_dsp_command',
       inlined from 'nau8310_dsp_set_kcs_setup' at sound/soc/codecs/nau8310-dsp.c:603:8:
>> sound/soc/codecs/nau8310-dsp.c:419:15: warning: 'kcs_setup_comp.set_kcs_data' is used uninitialized [-Wuninitialized]
     419 |         ret = nau8310_message_to_dsp(cp, cmd_info, frag_len,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     420 |                 kcs_setup->set_kcs_offset, kcs_setup->set_len,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     421 |                 kcs_setup->set_kcs_data);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/nau8310-dsp.c: In function 'nau8310_dsp_set_kcs_setup':
   sound/soc/codecs/nau8310-dsp.c:592:34: note: 'kcs_setup_comp' declared here
     592 |         struct nau8310_kcs_setup kcs_setup_comp, *kcs_setup = &kcs_setup_comp;
         |                                  ^~~~~~~~~~~~~~


vim +419 sound/soc/codecs/nau8310-dsp.c

   370	
   371	/*
   372	 * nau8310_send_dsp_command - Send command to DSP
   373	 *
   374	 * @cp:  component to register
   375	 * @cmd_id:  DSP supported command ID
   376	 * @kcs_setup: KCS setup structure
   377	 *
   378	 * The communication protocol is a Master-Slave type protocol
   379	 * where the host processor is the master and DSP is the slave.
   380	 * The Master initiates the communication and can either write or
   381	 * read back from the slave.
   382	 * Transactions from the Master are called "Messages",
   383	 * and read-back data from the Slave is called a "Reply".
   384	 *
   385	 * The function sends command to DSP according to the command ID.
   386	 * These commands include getting the information of DSP,
   387	 * getting or setting KCS configuration, or making DSP control.
   388	 */
   389	static int nau8310_send_dsp_command(struct snd_soc_component *cp, int cmd_id,
   390		struct nau8310_kcs_setup *kcs_setup)
   391	{
   392		const struct nau8310_cmd_info *cmd_info;
   393		int ret = 0, frag_len = 0;
   394	
   395		cmd_info = &nau8310_dsp_cmd_table[cmd_id];
   396		if ((cmd_info->msg_param && !kcs_setup->set_len) ||
   397			(cmd_info->setup_data && !kcs_setup->set_kcs_data) ||
   398			(cmd_info->reply_data && !kcs_setup->get_data))
   399			return -EFAULT;
   400	
   401		/* Read up to 1kB data because the LEN field to request data is 10-bits
   402		 * long; and not beyond 3kB offset.
   403		 */
   404		if (cmd_id == NAU8310_DSP_CMD_GET_KCS_SETUP &&
   405			(kcs_setup->set_len > NAU8310_DSP_KCS_DAT_LEN_MAX ||
   406			kcs_setup->set_kcs_offset > NAU8310_DSP_KCS_OFFSET_MAX))
   407			return -ERANGE;
   408	
   409		/* one fragment for offset and size parameters
   410		 * one fragment for a postamble fragment
   411		 */
   412		if (cmd_info->msg_param)
   413			frag_len += 2;
   414	
   415		/* fragments for KCS setup writen */
   416		if (cmd_info->setup_data)
   417			frag_len += DIV_ROUND_UP(kcs_setup->set_len, NAU8310_DSP_DATA_BYTE);
   418	
 > 419		ret = nau8310_message_to_dsp(cp, cmd_info, frag_len,
   420			kcs_setup->set_kcs_offset, kcs_setup->set_len,
   421			kcs_setup->set_kcs_data);
   422		if (ret)
   423			return ret;
   424	
   425		return nau8310_reply_from_dsp(cp, cmd_info, kcs_setup->get_len,
   426			kcs_setup->get_data);
   427	}
   428	
   429	static inline int nau8310_dsp_exec_command(struct snd_soc_component *cp, int cmd_id,
   430		int offset, int set_len, void *set_data, int get_len, void *get_data)
   431	{
   432		struct nau8310_kcs_setup kcs_setup = {
   433			.set_kcs_offset = offset,
   434			.set_len = set_len,
   435			.set_kcs_data = set_data,
   436			.get_len = get_len,
   437			.get_data = get_data,
   438		};
   439	
   440		return nau8310_send_dsp_command(cp, cmd_id, &kcs_setup);
   441	}
   442	
   443	/*
   444	 * nau8310_dsp_kcs_setup - Send KCS setup command to DSP
   445	 *
   446	 * @cp:  component to register
   447	 * @offset: address offset relative to KCS start
   448	 * @size: size of data writen to KCS
   449	 * @data: data writen to KCS setup
   450	 *
   451	 * The function sends KCS setup command to DSP for
   452	 * setting KCS configuration. The maximum size that you can transfer into
   453	 * the DSP is 96 bytes. Therefore, the driver has to split the data into
   454	 * 96 bytes chucks, if the setup configuration over the threshold.
   455	 */
   456	static int nau8310_dsp_kcs_setup(struct snd_soc_component *cp, int offset, int size,
   457		const void *data)
   458	{
   459		u8 *data_buf = (u8 *)data;
   460		unsigned int kcs_rst;
   461		int retries = 0, ret, data_len, data_rem, addr_offset;
   462	
   463		/* Limit full load of KCS_SETUP data and not beyond 3kB offset. */
   464		if (!data || size > NAU8310_DSP_KCS_DAT_LEN_MAX ||
   465			offset > NAU8310_DSP_KCS_OFFSET_MAX)
   466			return -EINVAL;
   467	
   468		/* sending fragments for KCS setup */
   469		addr_offset = offset;
   470		data_rem = size;
   471	
   472		while (data_rem) {
   473			data_len = min(data_rem, NAU8310_DSP_KCS_TX_MAX);
   474	
   475			ret = nau8310_dsp_exec_command(cp, NAU8310_DSP_CMD_SET_KCS_SETUP,
   476				addr_offset, data_len, (void *)data_buf, 0, &kcs_rst);
   477			if (ret) {
   478				if (retries++ < NAU8310_DSP_RETRY_MAX)
   479					continue;
   480				return ret;
   481			}
   482	
   483			data_buf += (u8)data_len;
   484			addr_offset += data_len;
   485			data_rem -= data_len;
   486	
   487			/* checking KCS result */
   488			ret = nau8310_dsp_exec_command(cp, NAU8310_DSP_CMD_GET_KCS_RSLTS,
   489				0, NAU8310_DSP_DATA_BYTE, NULL, NAU8310_DSP_DATA_BYTE, &kcs_rst);
   490			if (ret)
   491				return ret;
   492			if (kcs_rst != NAU8310_DSP_KCS_RSLTS_SUCCESS)
   493				return -EINVAL;
   494		}
   495	
   496		return 0;
   497	}
   498	
   499	static int nau8310_dsp_snd_soc_dapm_put(struct snd_kcontrol *kcontrol,
   500		struct snd_ctl_elem_value *ucontrol)
   501	{
   502		struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
   503		struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
   504		struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
   505		struct soc_mixer_control *mc =
   506			(struct soc_mixer_control *)kcontrol->private_value;
   507		unsigned int mask = (1 << fls(mc->max)) - 1;
   508		unsigned int val;
   509		int ret;
   510	
   511		if (snd_soc_dapm_get_bias_level(dapm) > SND_SOC_BIAS_STANDBY) {
   512			dev_warn_ratelimited(nau8310->dev, "changing path is not allowed during playback");
   513			return -EBUSY;
   514		}
   515	
   516		val = (ucontrol->value.integer.value[0] & mask);
   517	
   518		mutex_lock(&nau8310->lock);
   519		if (val == NAU8310_DAC_SRC_DSP && !nau8310->load_fw_done) {
   520			dev_warn_ratelimited(nau8310->dev, "Cannot enable DSP: Firmware not ready or disabled");
   521			mutex_unlock(&nau8310->lock);
   522			return -EBUSY;
   523		}
   524	
   525		ret = snd_soc_dapm_put_volsw(kcontrol, ucontrol);
   526	
   527		if (val == NAU8310_DAC_SRC_BYPASS) {
   528			/* Switch the clock source of DSP to MCLK. */
   529			regmap_update_bits(nau8310->regmap, NAU8310_R04_ENA_CTRL,
   530				NAU8310_DSP_SEL_OSC, 0);
   531		}
   532		mutex_unlock(&nau8310->lock);
   533	
   534		return ret;
   535	}
   536	
   537	#define NAU8310_DSP_SOC_DAPM_SINGLE(xname, reg, shift, mask, invert) \
   538		SOC_SINGLE_EXT(xname, reg, shift, mask, invert, \
   539			snd_soc_dapm_get_volsw, nau8310_dsp_snd_soc_dapm_put)
   540	
   541	static const struct snd_kcontrol_new nau8310_dacdat_select_dsp =
   542		NAU8310_DSP_SOC_DAPM_SINGLE("Switch", NAU8310_R1A_DSP_CORE_CTRL2,
   543			NAU8310_DAC_SEL_DSP_SFT, 1, 0);
   544	
   545	static int nau8310_dsp_clock_event(struct snd_soc_dapm_widget *w,
   546		struct snd_kcontrol *kcontrol, int event)
   547	{
   548		struct snd_soc_component *cp = snd_soc_dapm_to_component(w->dapm);
   549		struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
   550		int ret = 0;
   551	
   552		if (SND_SOC_DAPM_EVENT_ON(event)) {
   553			ret = nau8310_dsp_exec_command(cp, NAU8310_DSP_CMD_CLK_RESTART,
   554				0, 0, NULL, 0, NULL);
   555			if (ret)
   556				dev_err(cp->dev, "Send DSP command %s fail (%d)",
   557					dsp_cmd_table[NAU8310_DSP_CMD_CLK_RESTART], ret);
   558	
   559			/* Switch the clock source of DSP to MCLK. */
   560			regmap_update_bits(nau8310->regmap, NAU8310_R04_ENA_CTRL,
   561				NAU8310_DSP_SEL_OSC, 0);
   562		} else if (SND_SOC_DAPM_EVENT_OFF(event)) {
   563			ret = nau8310_dsp_exec_command(cp, NAU8310_DSP_CMD_CLK_STOP,
   564				0, 0, NULL, 0, NULL);
   565			if (ret)
   566				dev_err(cp->dev, "Send DSP command %s fail (%d)",
   567					dsp_cmd_table[NAU8310_DSP_CMD_CLK_STOP], ret);
   568		}
   569	
   570		return ret;
   571	}
   572	
   573	static const struct snd_soc_dapm_widget nau8310_dsp_dapm_widgets[] = {
   574		SND_SOC_DAPM_PGA("DSP", SND_SOC_NOPM, 0, 0, NULL, 0),
   575		SND_SOC_DAPM_SWITCH("DAC data from DSP", SND_SOC_NOPM,
   576			0, 0, &nau8310_dacdat_select_dsp),
   577		SND_SOC_DAPM_SUPPLY("DSP Clock", SND_SOC_NOPM, 0, 0,
   578			nau8310_dsp_clock_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
   579	};
   580	
   581	static const struct snd_soc_dapm_route nau8310_dsp_dapm_routes[] = {
   582		{ "DSP", NULL, "Capture Sense" },
   583		{ "DAC data from DSP", "Switch", "DSP" },
   584		{ "DAC", NULL, "DAC data from DSP" },
   585		{ "DSP", NULL, "DSP Clock" },
   586	};
   587	
   588	static int nau8310_dsp_set_kcs_setup(struct snd_soc_component *cp)
   589	{
   590		struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
   591		struct regmap *regmap = nau8310->regmap;
 > 592		struct nau8310_kcs_setup kcs_setup_comp, *kcs_setup = &kcs_setup_comp;
   593		struct device *dev = cp->dev;
   594		const struct firmware *fw;
   595		int ret, status = 0, buf_off, buf_len;
   596	
   597		dev_dbg(dev, "Send DSP command %s",
   598			dsp_cmd_table[NAU8310_DSP_CMD_GET_FRAME_STATUS]);
   599	
   600		kcs_setup->get_len = kcs_setup->set_len = sizeof(status);
   601		kcs_setup->get_data = (void *)&status;
   602	
 > 603		ret = nau8310_send_dsp_command(cp, NAU8310_DSP_CMD_GET_FRAME_STATUS, kcs_setup);
   604		if (ret) {
   605			dev_err(dev, "Send DSP command %s fail (%d)",
   606				dsp_cmd_table[NAU8310_DSP_CMD_GET_FRAME_STATUS], ret);
   607			goto err;
   608		}
   609	
   610		if (!(status & NAU8310_DSP_ALGO_OK)) {
   611			dev_err(dev, "Algorithm of DSP is not ready, status %x", status);
   612			ret = -EIO;
   613			goto err;
   614		}
   615	
   616		dev_info(dev, "Algorithm of DSP is ready, status %x", status);
   617	
   618		dev_dbg(dev, "Request firmware and wait until finish.");
   619		ret = request_firmware(&fw, NAU8310_DSP_FIRMWARE, dev);
   620		if (ret) {
   621			dev_err(dev, "Failed to load firmware (%d)", ret);
   622			goto err;
   623		}
   624	
   625		buf_off = 0;
   626		buf_len = nau8310->kcs_setup_size = fw->size;
   627		dev_dbg(dev, "Send DSP command %s (OFF %d, LEN %d)",
   628			dsp_cmd_table[NAU8310_DSP_CMD_SET_KCS_SETUP], buf_off, buf_len);
   629		ret = nau8310_dsp_kcs_setup(cp, buf_off, buf_len, fw->data);
   630		if (ret) {
   631			dev_err(dev, "Send DSP command %s fail (%d)",
   632				dsp_cmd_table[NAU8310_DSP_CMD_SET_KCS_SETUP], ret);
   633			goto err_loaded;
   634		}
   635	
   636		release_firmware(fw);
   637		nau8310->load_fw_done = true;
   638	
   639		return 0;
   640	
   641	err_loaded:
   642		regmap_update_bits(regmap, NAU8310_R13_MUTE_CTRL, NAU8310_SOFT_MUTE, 0);
   643		if (fw)
   644			release_firmware(fw);
   645	err:
   646		nau8310->load_fw_done = false;
   647		return ret;
   648	}
   649	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
