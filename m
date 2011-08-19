From: Alex Wolfson <alex.wolfson@canonical.com>
Subject: Re: Lost dB volumes on USB headset between 2.6.38 and
 3.0
Date: Thu, 18 Aug 2011 22:19:43 -0400
Message-ID: <4E4DC83F.4080704@canonical.com>
References: <mailman.806.1313679978.2087.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 482A724481
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 04:19:48 +0200 (CEST)
Received: from pool-173-76-98-227.bstnma.fios.verizon.net ([173.76.98.227]
	helo=[192.168.1.4]) by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <alex.wolfson@canonical.com>) id 1QuEgT-0006ZZ-Oy
	for alsa-devel@alsa-project.org; Fri, 19 Aug 2011 02:19:46 +0000
In-Reply-To: <mailman.806.1313679978.2087.alsa-devel@alsa-project.org>
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

> 2011/8/18 Takashi Iwai<tiwai at suse.de  <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>>:
> >/  At Tue, 16 Aug 2011 13:31:52 +0100,
> />/  Colin Guthrie wrote:
> />>/
> />>/  >  diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> />>/  >  index c04d7c7..cdd19d7 100644
> />>/  >  --- a/sound/usb/mixer.c
> />>/  >  +++ b/sound/usb/mixer.c
> />>/  >  @@ -152,6 +152,7 @@ static inline void check_mapped_dB(const struct usbmix_name_map *p,
> />>/  >       if (p&&  p->dB) {
> />>/  >               cval->dBmin = p->dB->min;
> />>/  >               cval->dBmax = p->dB->max;
> />>/  >  +           cval->initialized = 1;
> />>/  >       }
> />>/  >    }
> />>/  >
> />>/  >  @@ -1092,7 +1093,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
> />>/  >                               " Switch" : " Volume");
> />>/  >               if (control == UAC_FU_VOLUME) {
> />>/  >                       check_mapped_dB(map, cval);
> />>/  >  -                   if (cval->dBmin<  cval->dBmax) {
> />>/  >  +                   if (cval->dBmin<  cval->dBmax || !cval->initialized) {
> />>/  >                               kctl->tlv.c = mixer_vol_tlv;
> />>/  >                               kctl->vd[0].access |=
> />>/  >                                       SNDRV_CTL_ELEM_ACCESS_TLV_READ |
> />>/
> />>/
> />>/
> />>/  Not had a chance to test this yet but I will when I get a moment.
> />/
> />/  Any chance to test the patch?
> />/
> /
> The patch seem fix the no dB scale problem , however the broken dB
> test which you added seem redundant as cval->dBmin and cval->dBmax are
> still zero because error in get_min_max() at build_feature_ctl() and
> it seem that the valid dBmin and dBMax are calculated by get_min_max()
> at mixer_ctl_feature_info() on my usb logitech web cam
>
>
> LSA endpoint.c:450: 2:3:1: add audio endpoint 0x86
> ALSA mixer.c:1182: [5] FU [Mic Capture Switch] ch = 1, val = 0/1/1
> ALSA mixer.c:804: 5:2: cannot get min/max values for control 2 (id 5)
> ALSA mixer.c:1182: [5] FU [Mic Capture Volume] ch = 1, val = 0/1/1
> ALSA mixer.c:804: 5:2: cannot get min/max values for control 2 (id 5)
> usbcore: registered new interface driver snd-usb-audio
Fixed dB scale problem for my USB Logitech headset as well (046d:0a0b)
