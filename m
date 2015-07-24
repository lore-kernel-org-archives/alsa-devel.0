From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: hda - Use generic parser for Cirrus codec
	driver
Date: Fri, 24 Jul 2015 19:12:28 +0300
Message-ID: <20150724161227.GA12423@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 41D7F2605C3
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 18:12:42 +0200 (CEST)
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

The patch 1077a024812d: "ALSA: hda - Use generic parser for Cirrus
codec driver" from Dec 19, 2012, leads to the following static
checker warning:

	sound/pci/hda/patch_cirrus.c:1004 cs4210_spdif_automute()
	warn: we tested 'spdif_present' before and it was 'true'

sound/pci/hda/patch_cirrus.c
   984  static void cs4210_spdif_automute(struct hda_codec *codec,
   985                                    struct hda_jack_callback *tbl)
   986  {
   987          struct cs_spec *spec = codec->spec;
   988          bool spdif_present = false;
   989          hda_nid_t spdif_pin = spec->gen.autocfg.dig_out_pins[0];
   990  
   991          /* detect on spdif is specific to CS4210 */
   992          if (!spec->spdif_detect ||
   993              spec->vendor_nid != CS4210_VENDOR_NID)
   994                  return;
   995  
   996          spdif_present = snd_hda_jack_detect(codec, spdif_pin);
   997          if (spdif_present == spec->spdif_present)
   998                  return;
   999  
  1000          spec->spdif_present = spdif_present;
  1001          /* SPDIF TX on/off */
  1002          if (spdif_present)
                    ^^^^^^^^^^^^^
  1003                  snd_hda_set_pin_ctl(codec, spdif_pin,
  1004                                      spdif_present ? PIN_OUT : 0);
                                            ^^^^^^^^^^^^^

I'm not positive but I think this is buggy.  We should remove the if
statement.

  1005  
  1006          cs_automute(codec);
  1007  }

regards,
dan carpenter
