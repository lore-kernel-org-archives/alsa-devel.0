From: Laurence Darby <ldarby@tuffmail.com>
Subject: setup_dig_out_stream() resets the SPDIF steam causing
	clicks
Date: Fri, 28 Sep 2012 01:53:54 +0100
Message-ID: <20120928015354.30b9b5c5.ldarby@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout-07.mxes.net (mxout-07.mxes.net [216.86.168.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 7262E260792
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 02:53:58 +0200 (CEST)
Received: from home (unknown [81.187.127.120])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by smtp.mxes.net (Postfix) with ESMTPSA id EE59022E256
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 20:53:56 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm playing audio via SPDIF, with a Realtek codec, and there's a
problem that whenever audio is started, or seeking in every music
player I tried, the DAC lost sync briefly, which made it 'click' when
it muted and unmuted itself.

I recently upgraded the DAC, and this problem only happened with the
new DAC, but not the old one, I don't know (or really care) why - the
old DAC had much worse problems.

Here's what I did to fix this:

diff -up linux-3.5.4/sound/pci/hda/hda_codec.c.orig linux-3.5.4/sound/pci/hda/hda_codec.c
--- linux-3.5.4/sound/pci/hda/hda_codec.c.orig  2012-09-28 00:13:25.000000000 +0100
+++ linux-3.5.4/sound/pci/hda/hda_codec.c       2012-09-28 00:39:31.000000000 +0100
@@ -4693,9 +4693,11 @@ static void setup_dig_out_stream(struct
                                                   format);
        }
        /* turn on again (if needed) */
-       if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE))
+       if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE)) {
                set_dig_out_convert(codec, nid,
                                    spdif->ctls & 0xff, -1);
+               codec->spdif_status_reset=0;
+       }
 }
 
 static void cleanup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid)


That makes SPDIF turn off and on just once when sound is first played
(i.e. it clicks once then, then no more).  In patch_realtek.c it's got
this:

	/* FIXME: do we need this for all Realtek codec models? */ 
	codec->spdif_status_reset = 1;


If I set that to 0, then the left channel doesn't initialize and is
silent, so the reset really does need to happen once (for my realtek
model anyway, I don't know how to find out what that would be?)

So, is the above an acceptable fix? 

Regards,
Laurence
