From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ALSA: usb-audio: More validations of
	descriptor units
Date: Mon, 26 Aug 2019 14:48:46 +0300
Message-ID: <20190826114846.GA16466@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D482FF80143
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2019 13:49:03 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi Iwai,

This is a semi-automatic email about new static checker warnings.

The patch 57f8770620e9: "ALSA: usb-audio: More validations of
descriptor units" from Aug 20, 2019, leads to the following Smatch
complaint:

    sound/usb/quirks.c:254 create_yamaha_midi_quirk()
    warn: variable dereferenced before check 'injd' (see line 251)

sound/usb/quirks.c
   244          /* must have some valid jack descriptors */
   245          injd = snd_usb_find_csint_desc(alts->extra, alts->extralen,
   246                                         NULL, USB_MS_MIDI_IN_JACK);
   247          outjd = snd_usb_find_csint_desc(alts->extra, alts->extralen,
   248                                          NULL, USB_MS_MIDI_OUT_JACK);
   249          if (!injd && !outjd)
                     ^^^^^^^^^^^^^
At least one must be valid.

   250                  return -ENODEV;
   250			return -ENODEV;
   251		if (!snd_usb_validate_midi_desc(injd) ||
   252		    !snd_usb_validate_midi_desc(outjd))

So this should return true/valid if the pointer is NULL?

   253			return -ENODEV;
   254		if (injd && (injd->bLength < 5 ||
   255			     (injd->bJackType != USB_MS_EMBEDDED &&
   256			      injd->bJackType != USB_MS_EXTERNAL)))

regards,
dan carpenter
