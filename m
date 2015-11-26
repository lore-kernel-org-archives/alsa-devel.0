From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: hdac-hdmi: Add hdmi driver
Date: Thu, 26 Nov 2015 14:40:48 +0300
Message-ID: <20151126114048.GA10556@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 0082D2619FB
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 12:40:59 +0100 (CET)
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
To: subhransu.s.prusty@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Subhransu S. Prusty,

The patch 18382ead3640: "ASoC: hdac-hdmi: Add hdmi driver" from Nov
10, 2015, leads to the following static checker warning:

	sound/soc/codecs/hdac_hdmi.c:416 hdac_hdmi_parse_and_map_nid()
	warn: unsigned 'hdac->num_nodes' is never less than zero.

sound/soc/codecs/hdac_hdmi.c
   409  static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
   410  {
   411          hda_nid_t nid;
   412          int i;
   413          struct hdac_device *hdac = &edev->hdac;
   414          struct hdac_hdmi_priv *hdmi = edev->private_data;
   415          int cvt_nid = 0, pin_nid = 0;
   416  
   417          hdac->num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
   418          if (!nid || hdac->num_nodes < 0) {
                            ^^^^^^^^^^^^^^^^^^^
snd_hdac_get_sub_nodes() never returns negatives.  (We can't create a
static checker warning for this because it's impossible to know if the
author is planning to add error returns later).  It returns zero if
not found so maybe that was intended intsead?

   419                  dev_warn(&hdac->dev, "HDMI: failed to get afg sub nodes\n");
   420                  return -EINVAL;
   421          }

regards,
dan carpenter
