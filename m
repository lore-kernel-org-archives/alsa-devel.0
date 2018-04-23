From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] patch_ca0132.c: Handle SBZ and R3Di sound
 cards
Date: Mon, 23 Apr 2018 14:57:04 +0800
Message-ID: <201804231418.DVXEwFfP%fengguang.wu@intel.com>
References: <1524445866-3586-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A624D2675D0
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 08:57:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1524445866-3586-1-git-send-email-conmanx360@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org, Connor McAdams <conmanx360@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Connor,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sound/for-next]
[also build test WARNING on v4.17-rc2 next-20180423]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Connor-McAdams/patch_ca0132-c-Handle-SBZ-and-R3Di-sound-cards/20180423-131708
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/pci/hda/patch_ca0132.c:1809:23: sparse: expression using sizeof(void)
   sound/pci/hda/patch_ca0132.c:2462:43: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned int [unsigned] format @@    got restricted snd_unsigned int [unsigned] format @@
   sound/pci/hda/patch_ca0132.c:2462:43:    expected unsigned int [unsigned] format
   sound/pci/hda/patch_ca0132.c:2462:43:    got restricted snd_pcm_format_t [usertype] <noident>
   sound/pci/hda/patch_ca0132.c:2715:29: sparse: expression using sizeof(void)
   sound/pci/hda/patch_ca0132.c:2715:29: sparse: expression using sizeof(void)
   sound/pci/hda/patch_ca0132.c:2739:34: sparse: expression using sizeof(void)
   sound/pci/hda/patch_ca0132.c:2739:34: sparse: expression using sizeof(void)
>> sound/pci/hda/patch_ca0132.c:3927:22: sparse: Using plain integer as NULL pointer
   sound/pci/hda/patch_ca0132.c:3928:22: sparse: Using plain integer as NULL pointer
>> sound/pci/hda/patch_ca0132.c:5687:33: sparse: symbol 'ca0132_alt_chmaps' was not declared. Should it be static?
   sound/pci/hda/patch_ca0132.c:6532:25: sparse: incorrect type in argument 3 (different base types) @@    expected unsigned int [unsigned] format @@    got restricted snd_unsigned int [unsigned] format @@
   sound/pci/hda/patch_ca0132.c:6532:25:    expected unsigned int [unsigned] format
   sound/pci/hda/patch_ca0132.c:6532:25:    got restricted snd_pcm_format_t [usertype] <noident>

Please review and possibly fold the followup patch.

vim +3927 sound/pci/hda/patch_ca0132.c

  3915	
  3916	static int ca0132_alt_add_effect_slider(struct hda_codec *codec, hda_nid_t nid,
  3917						const char *pfx, int dir)
  3918	{
  3919		char *fx = "FX:";
  3920		char namestr[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
  3921		int type = dir ? HDA_INPUT : HDA_OUTPUT;
  3922		struct snd_kcontrol_new knew =
  3923			HDA_CODEC_VOLUME_MONO(namestr, nid, 1, 0, type);
  3924	
  3925		sprintf(namestr, "%s %s %s Volume", fx, pfx, dirstr[dir]);
  3926	
> 3927		knew.tlv.c = 0;
  3928		knew.tlv.p = 0;
  3929	
  3930		switch (nid) {
  3931		case XBASS_XOVER:
  3932			knew.info = ca0132_alt_xbass_xover_slider_info;
  3933			knew.get = ca0132_alt_xbass_xover_slider_ctl_get;
  3934			knew.put = ca0132_alt_xbass_xover_slider_put;
  3935			break;
  3936		default:
  3937			knew.info = ca0132_alt_effect_slider_info;
  3938			knew.get = ca0132_alt_slider_ctl_get;
  3939			knew.put = ca0132_alt_effect_slider_put;
  3940			knew.private_value =
  3941				HDA_COMPOSE_AMP_VAL(nid, 1, 0, type);
  3942			break;
  3943		}
  3944	
  3945		return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
  3946	}
  3947	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
