From: Matt <matt@embeddedalley.com>
Subject: [PATCH] hda: use amp capabilities from afg if amp override not set
Date: Sun, 20 Mar 2005 17:36:05 -0700
Message-ID: <20050320173605.D10431@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some HDA codec nodes contain an amp, but do not provide local amp
capabilities.  In these cases, AC_WCAP_AMP_OVRD is not set so we
should query the AFG nid in order to get the general amp capabilities.

Index: alsa-kernel/pci/hda/hda_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_codec.c,v
retrieving revision 1.8
diff -u -r1.8 hda_codec.c
--- alsa-kernel/pci/hda/hda_codec.c	18 Mar 2005 16:21:56 -0000	1.8
+++ alsa-kernel/pci/hda/hda_codec.c	21 Mar 2005 00:20:40 -0000
@@ -611,6 +611,8 @@
 	if (! info)
 		return 0;
 	if (! (info->status & INFO_AMP_CAPS)) {
+		if (!(snd_hda_param_read(codec, nid, AC_PAR_AUDIO_WIDGET_CAP) & AC_WCAP_AMP_OVRD))
+			nid = codec->afg;
 		info->amp_caps = snd_hda_param_read(codec, nid, direction == HDA_OUTPUT ?
 						    AC_PAR_AMP_OUT_CAP : AC_PAR_AMP_IN_CAP);
 		info->status |= INFO_AMP_CAPS;


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
