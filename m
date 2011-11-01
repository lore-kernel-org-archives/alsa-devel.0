From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] hda - is_jack_detectable()
Date: Tue, 01 Nov 2011 17:03:29 -0400
Message-ID: <4EB05EA1.1060701@canonical.com>
References: <CAN8cciZ4z5Jx9oHxoSt2K=NoOsOVMFjmaZjxPCXSDD05J5NdVA@mail.gmail.com>
	<CAN8ccia3XSQ0TxD2CqH7bSv=stf4Z8qbdeo=sOt_NUZ5+GNM=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id C9338244D9
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 22:03:34 +0100 (CET)
In-Reply-To: <CAN8ccia3XSQ0TxD2CqH7bSv=stf4Z8qbdeo=sOt_NUZ5+GNM=w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011-10-24 23:31, Raymond Yau skrev:
> sorry, it should be
>
> static inline bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid)
> {
>          return (snd_hda_query_pin_caps(codec, nid)&  AC_PINCAP_PRES_DETECT)&&
> +		!(get_defcfg_misc(snd_hda_codec_get_pincfg(codec, nid)
> 			&  AC_DEFCFG_MISC_NO_PRESENCE))&&	
>                  (get_wcaps(codec, nid)&  AC_WCAP_UNSOL_CAP);
> }
>
I also think it is a good idea, in fact I thought it was this way 
already. Can we merge this patch?

// David
