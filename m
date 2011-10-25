From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] hda - is_jack_detectable()
Date: Tue, 25 Oct 2011 11:31:23 +0800
Message-ID: <CAN8ccia3XSQ0TxD2CqH7bSv=stf4Z8qbdeo=sOt_NUZ5+GNM=w@mail.gmail.com>
References: <CAN8cciZ4z5Jx9oHxoSt2K=NoOsOVMFjmaZjxPCXSDD05J5NdVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3B50E24511
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Oct 2011 05:31:25 +0200 (CEST)
Received: by faao24 with SMTP id o24so95001faa.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2011 20:31:23 -0700 (PDT)
In-Reply-To: <CAN8cciZ4z5Jx9oHxoSt2K=NoOsOVMFjmaZjxPCXSDD05J5NdVA@mail.gmail.com>
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

sorry, it should be

static inline bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid)
{
        return (snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_PRES_DETECT) &&
+		!(get_defcfg_misc(snd_hda_codec_get_pincfg(codec, nid)
			& AC_DEFCFG_MISC_NO_PRESENCE)) &&	
                (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP);
}
