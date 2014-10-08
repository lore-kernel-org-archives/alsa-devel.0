From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: hda/realtek - Allow NULL bus->pci
Date: Wed, 8 Oct 2014 12:32:46 +0300
Message-ID: <20141008093246.GA4690@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id EBB32260432
 for <alsa-devel@alsa-project.org>; Wed,  8 Oct 2014 11:33:10 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi Iwai,

The patch 5100cd07d43a: "ALSA: hda/realtek - Allow NULL bus->pci"
from Feb 15, 2014, leads to the following static checker warning:

	sound/pci/hda/patch_realtek.c:5371 patch_alc269()
	warn: variable dereferenced before check 'codec->bus->pci' (see line 5364)

sound/pci/hda/patch_realtek.c
  5363          if (has_cdefine_beep(codec))
                                     ^^^^^
We actually dereference "codec->bus->pci" inside the call to
has_cdefine_beep().

  5364                  spec->gen.beep_nid = 0x01;
  5365  
  5366          switch (codec->vendor_id) {
  5367          case 0x10ec0269:
  5368                  spec->codec_variant = ALC269_TYPE_ALC269VA;
  5369                  switch (alc_get_coef0(codec) & 0x00f0) {
  5370                  case 0x0010:
  5371                          if (codec->bus->pci &&
                                    ^^^^^^^^^^^^^^^
This new check is too late.

  5372                              codec->bus->pci->subsystem_vendor == 0x1025 &&
  5373                              spec->cdefine.platform_type == 1)
  5374                                  err = alc_codec_rename(codec, "ALC271X");
  5375                          spec->codec_variant = ALC269_TYPE_ALC269VB;
  5376                          break;

There is another related warning:

sound/pci/hda/patch_realtek.c:6270 patch_alc662() warn: variable dereferenced before check 'codec->bus->pci' (see line 6267)

regards,
dan carpenter
