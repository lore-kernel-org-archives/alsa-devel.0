From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [RFC] hda - is_jack_detectable()
Date: Tue, 25 Oct 2011 11:02:34 +0800
Message-ID: <CAN8cciZ4z5Jx9oHxoSt2K=NoOsOVMFjmaZjxPCXSDD05J5NdVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 81A0C244E8
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Oct 2011 05:02:35 +0200 (CEST)
Received: by faao24 with SMTP id o24so79211faa.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2011 20:02:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Refer to HDA Specification

7.3.3.31 Configuration Default

Misc[3:0] is a bit field used to indicate other information about the
jack. Currently, only bit 0 is defined.
If bit 0 is set, it indicates that the jack has no presence detect
capability, so even if a Pin
Complex indicates that the codec hardware supports the presence detect
functionality on the jack, the external circuitry is not capable of
supporting the functionality. The bit definitions for the Miscfield
are in Table 106.


Do we need to change is_jack_detectable() when user setup BIOS to use
AC97 Front Audio Panel which set  AC_DEFCFG_MISC_NO_PRESENCE bit ?


+#define get_defcfg_misc(cfg) \
+	((cfg & AC_DEFCFG_MISC) >> AC_DEFCFG_MISC_SHIFT)


static inline bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid)
{
	return (snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_PRES_DETECT) &&
+	  	(!(get_defcfg_misc(codec,nid) & AC_DEFCFG_MISC_NO_PRESENCE)) &&	
		(get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP);
}


or add another fuction is_defcfg_misc_no_presence() to indicate jack
has no presence detect capability ?
