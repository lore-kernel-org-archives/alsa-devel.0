From: Peter Niemayer <niemayer@isg.de>
Subject: spdif/iec958 outputs at VT1708S not recognized
Date: Wed, 29 Apr 2009 14:25:28 +0200
Message-ID: <gt9gvo$ocq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id BE08524429
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 15:45:04 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LzA5u-00073l-9K
	for alsa-devel@alsa-project.org; Wed, 29 Apr 2009 13:45:02 +0000
Received: from barriere.frankfurter-softwarefabrik.de ([217.11.197.1])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2009 13:45:02 +0000
Received: from niemayer by barriere.frankfurter-softwarefabrik.de with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2009 13:45:02 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I recently installed an Asus M4N78 mainboard, that uses a
nVidia GeForce 8300 chipset and a VT1708S soundchip.

Alas, the code in pci/hda/patch_via.c did not recognize
the 3 existing iec958/spdif outputs, and presented only
the analog devices.

I had to short circuit the pin definition
in vt1708S_parse_auto_config() to get the digital outputs
to work:

         spec->multiout.max_channels = spec->multiout.num_dacs * 2;

-       if (spec->autocfg.dig_out_pin)
+       // test fails for Asus M4N78 if (spec->autocfg.dig_out_pin)
                 spec->multiout.dig_out_nid = VT1708S_DIGOUT_NID;

         spec->extra_dig_out_nid = 0x15;

The digital sound output works just fine for me with this change,
but I guess there should be a cleaner way to make this work?

Several people in forums on the InterNet reported similar problems
with getting their digital outputs on VT1708S to work under Linux.

Regards,

Peter Niemayer
