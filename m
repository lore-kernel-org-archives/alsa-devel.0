From: Kailang <kailang@realtek.com>
Subject: Re: Support Dell headset mode for ALC891
Date: Mon, 13 Jun 2016 07:24:45 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A3EE49@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A3EBF3@RTITMBSV09.realtek.com.tw>
 <s5hlh2ec2h2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 18B0F261685
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 09:24:50 +0200 (CEST)
In-Reply-To: <s5hlh2ec2h2.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Thursday, June 09, 2016 2:15 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: Support Dell headset mode for ALC891
> 
> On Wed, 08 Jun 2016 09:17:12 +0200,
> Kailang wrote:
> > 
> > Hi Takashi,
> > 
> > This patch is supported Dell headset mode for ALC891.
> > It is only support I-phone type headset.
> > I think this function is only support for DELL.
> > So, headset mode and platform support is merged.
> > 
> > This patch is test passed by Ubuntu team.
> > 
> > Many Thanks.
> (snip)
> > Date: Tue, 7 Jun 2016 11:31:34 +0800
> > Subject: [PATCH] ALSA: hda/realtek - ALC891 headset mode for Dell
> >
> > New headset mode of ALC891 for Dell.
> > 
> > Signed-off-by: Kailang Yang <kailang@realtek.com>
> 
> Could you put more comments in the changelog, as what you 
> gave in the mail?
> 
       OK.
> 
> > diff --git a/sound/pci/hda/patch_realtek.c 
> > b/sound/pci/hda/patch_realtek.c index 7960316..9dc641e 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -3718,6 +3718,9 @@ static void 
> alc_headset_mode_unplugged(struct hda_codec *codec)
> >  	case 0x10ec0295:
> >  		alc_process_coef_fw(codec, coef0225);
> >  		break;
> > +	case 0x10ec0867:
> > +		alc_update_coefex_idx(codec, 0x57, 0x5, 1<<14, 0);
> > +		break;
> >  	}
> >  	codec_dbg(codec, "Headset jack set to unplugged 
> mode.\n");  } @@ 
> > -3805,6 +3808,8 @@ static void 
> alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
> >  		alc_process_coef_fw(codec, coef0293);
> >  		snd_hda_set_pin_ctl_cache(codec, mic_pin, PIN_VREF50);
> >  		break;
> > +	case 0x10ec0867:
> > +		alc_update_coefex_idx(codec, 0x57, 0x5, 0, 1<<14);
> > 	case 0x10ec0662:
> 
> No break between 0867 and 0662?

Yes, no break. ^^
It is only more one line difference for 0x0867.

> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
