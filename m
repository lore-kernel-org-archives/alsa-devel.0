From: "Viliam Kubis" <viliam.kubis@gmail.com>
Subject: Re: Smart 5.1 function not working on VIA VT1708S with
 *three* jacks on mainboard
Date: Fri, 09 Jul 2010 13:04:32 +0200
Message-ID: <op.vfko1ulyy9cctd@localhost>
References: <op.ve4vig0ny9cctd@localhost> <op.vff0au0jy9cctd@localhost>
	<4C35713E.1090709@ladisch.de> <op.vfi12awty9cctd@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5834A24432
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jul 2010 13:04:38 +0200 (CEST)
Received: by bwz4 with SMTP id 4so1038905bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Jul 2010 04:04:36 -0700 (PDT)
In-Reply-To: <op.vfi12awty9cctd@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello, I have patched the vt1708s_auto_fill_dac_nids function instead. I
have left values 0x11 and 0x12 for surround and cen/lfe, althrough it
might be 0x11 and 0x24 for vt1708S as originally specified in
vt1708s_auto_fill_dac_nids switch statement. The whole function looks
like this:

  static int vt1708S_auto_fill_dac_nids(struct via_spec *spec,
  				     const struct auto_pin_cfg *cfg)
  {
  	int i;
  	hda_nid_t nid;

  	spec->multiout.num_dacs = cfg->line_outs;

  	spec->multiout.dac_nids = spec->private_dac_nids;

  	for (i = 0; i < 4; i++) {
  		nid = cfg->line_out_pins[i];
  		if (nid) {
  			/* config dac list */
  			switch (i) {
  			case AUTO_SEQ_FRONT:
  				spec->multiout.dac_nids[i] = 0x10;
  				break;
  			case AUTO_SEQ_CENLFE:
  				spec->multiout.dac_nids[i] = 0x24;
  				break;
  			case AUTO_SEQ_SURROUND:
  				printk(KERN_INFO "***PATCH CREATING SURROUND DAC_NID");
  				spec->multiout.dac_nids[i] = 0x11;
  				break;
  			case AUTO_SEQ_SIDE:
  				spec->multiout.dac_nids[i] = 0x25;
  				break;
  			}
  		}
  	}
  	
  	if (cfg->line_outs == 1)
  	{
  		printk(KERN_INFO "***PATCH 08/07/10");
  		spec->multiout.num_dacs = 3;
  		spec->multiout.dac_nids[AUTO_SEQ_SURROUND] = 0x11;
  		spec->multiout.dac_nids[AUTO_SEQ_CENLFE] = 0x12;
	}

  	return 0;
  }

  The patch is in effect since the following is visible in dmesg after the
  driver is loaded:

  ***PATCH 08/07/10
  ***PATCH CREATING Surround CONTROL
  ***PATCH HDA max_channels = 6
  ***PATCH playback stream channels_max = 6
  Smart 5.1 Patch installed NEW
  ***PATCH Setting 64 mode [out=64] for pin index 0 nid 26
  ***PATCH Setting 64 mode [out=64] for pin index 1 nid 30
  ***PATCH Setting 64 mode [out=64] for pin index 2 nid 27

  printk(KERN_INFO "***PATCH CREATING SURROUND DAC_NID"); This line does
  not print since cfg->line_out_pins[AUTO_SEQ_SURROUND] is not filled at
  that time, but we fix it in the new if block.

  Surround still does not work (still the same, the rear speakers are
  soundless).

  On Thu, 08 Jul 2010 08:33:34 +0200, Clemens Ladisch <clemens@ladisch.de>
  wrote:

>> _auto_fill_dac_nids
>


-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
