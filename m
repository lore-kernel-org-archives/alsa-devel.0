From: Kailang <kailang@realtek.com>
Subject: Re: FW: move eapd coef function before ACT_PRE_PROBE
	state
Date: Tue, 7 May 2019 09:25:10 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D765ACE@RTITMBSVM07.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A1D765A9D@RTITMBSVM07.realtek.com.tw>
 <s5hmujy39go.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C17FF89673
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 11:25:14 +0200 (CEST)
In-Reply-To: <s5hmujy39go.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, May 7, 2019 5:23 PM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: FW: move eapd coef function before ACT_PRE_PROBE state
> 
> On Tue, 07 May 2019 11:17:15 +0200,
> Kailang wrote:
> >
> > Hi Takashi,
> >
> > This one.
> 
> I already replied twice.  The patch needs rewrite.
> Didn't you get the post?

Yes, I didn't get.
Ok! I rewrite patch again.

> 
> 
> thanks,
> 
> Takashi
> 
> >
> > -----Original Message-----
> > From: Kailang
> > Sent: Monday, May 6, 2019 2:46 PM
> > To: Takashi Iwai (tiwai@suse.de) <tiwai@suse.de>
> > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > Subject: RE: move eapd coef function before ACT_PRE_PROBE state
> >
> > Hi Takashi,
> >
> > Are you available for apply this ?
> > Thanks.
> >
> > BR,
> > Kailang
> >
> > > -----Original Message-----
> > > From: Kailang
> > > Sent: Tuesday, April 30, 2019 3:41 PM
> > > To: Takashi Iwai (tiwai@suse.de) <tiwai@suse.de>
> > > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > > Subject: move eapd coef function before ACT_PRE_PROBE state
> > >
> > > Hi Takashi,
> > >
> > > alc_fill_eapd_coef(),this function was change EAPD control to default.
> > > Default was set EAPD by verb control.
> > > This function was run in ACT_INIT state.
> > > Move it to ACT_PRE_PROBE above. It will have a chance to change EAPD
> > > control on ACT_PRE_PROBE state. It could change control by 0x20 coef bit.
> > >
> > > BR,
> > > Kailang
> > [2 0000-move-eapd-coef-func.patch <application/octet-stream (base64)>]
> >
> 
> ------Please consider the environment before printing this e-mail.
