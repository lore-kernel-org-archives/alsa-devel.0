From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 4/4] ALSA: usb-audio: UAC3 Add support for connector
 insertion.
Date: Mon, 23 Apr 2018 04:55:12 +0800
Message-ID: <201804230459.2dXlPwHY%fengguang.wu@intel.com>
References: <20180420170327.31569-5-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180420170327.31569-5-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, tiwai@suse.com, alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Jorge,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sound/for-next]
[also build test WARNING on v4.17-rc1 next-20180420]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jorge-Sanjuan/ALSA-usb-UAC3-new-features/20180423-015726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/usb/mixer.c:899:59: sparse: cast to restricted __le16
   sound/usb/mixer.c:1923:33: sparse: cast to restricted __le16
>> sound/usb/mixer.c:1975:24: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] bmctls @@    got restrunsigned int [unsigned] bmctls @@
   sound/usb/mixer.c:1975:24:    expected unsigned int [unsigned] bmctls
   sound/usb/mixer.c:1975:24:    got restricted __le16 [usertype] bmControls
   sound/usb/mixer.c:1981:24: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] bmctls @@    got restrunsigned int [unsigned] bmctls @@
   sound/usb/mixer.c:1981:24:    expected unsigned int [unsigned] bmctls
   sound/usb/mixer.c:1981:24:    got restricted __le32 [usertype] bmControls
   sound/usb/mixer.c:2008:33: sparse: cast to restricted __le16
   sound/usb/mixer.c:2697:62: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [unsigned] [usertype] bmControls @@    got ed int [unsigned] [usertype] bmControls @@
   sound/usb/mixer.c:2697:62:    expected unsigned int [unsigned] [usertype] bmControls
   sound/usb/mixer.c:2697:62:    got restricted __le16 [usertype] bmControls
   sound/usb/mixer.c:2724:62: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [unsigned] [usertype] bmControls @@    got ed int [unsigned] [usertype] bmControls @@
   sound/usb/mixer.c:2724:62:    expected unsigned int [unsigned] [usertype] bmControls
   sound/usb/mixer.c:2724:62:    got restricted __le32 [usertype] bmControls
   include/linux/usb.h:1676:28: sparse: expression using sizeof(void)
   include/linux/usb.h:1676:28: sparse: expression using sizeof(void)
   include/linux/usb.h:1676:28: sparse: expression using sizeof(void)
   include/linux/usb.h:1676:28: sparse: expression using sizeof(void)
   include/linux/usb.h:1676:28: sparse: expression using sizeof(void)
   include/linux/usb.h:1676:28: sparse: expression using sizeof(void)
   include/linux/usb.h:1676:28: sparse: expression using sizeof(void)

vim +1975 sound/usb/mixer.c

  1964	
  1965	static int parse_audio_input_terminal(struct mixer_build *state, int unitid,
  1966					      void *raw_desc)
  1967	{
  1968		struct usb_audio_term iterm;
  1969		unsigned int control, bmctls, term_id;
  1970	
  1971		if (state->mixer->protocol == UAC_VERSION_2) {
  1972			struct uac2_input_terminal_descriptor *d_v2 = raw_desc;
  1973			control = UAC2_TE_CONNECTOR;
  1974			term_id = d_v2->bTerminalID;
> 1975			bmctls = d_v2->bmControls;
  1976		}
  1977		else if (state->mixer->protocol == UAC_VERSION_3) {
  1978			struct uac3_input_terminal_descriptor *d_v3 = raw_desc;
  1979			control = UAC3_TE_INSERTION;
  1980			term_id = d_v3->bTerminalID;
  1981			bmctls = d_v3->bmControls;
  1982		}
  1983		else /* UAC1. No Insertion control */
  1984			return 0;
  1985	
  1986		check_input_term(state, term_id, &iterm);
  1987	
  1988		/* Check for jack detection. */
  1989		if (uac_v2v3_control_is_readable(bmctls, control))
  1990			build_connector_control(state, &iterm, true);
  1991	
  1992		return 0;
  1993	}
  1994	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
