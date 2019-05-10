From: Kailang <kailang@realtek.com>
Subject: Re: FW: move eapd coef function before ACT_PRE_PROBE
	state
Date: Fri, 10 May 2019 07:24:04 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D765FAE@RTITMBSVM07.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A1D765A9D@RTITMBSVM07.realtek.com.tw>
 <s5hmujy39go.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A1D765C5E@RTITMBSVM07.realtek.com.tw>
 <s5hv9ylo167.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A1D765CA5@RTITMBSVM07.realtek.com.tw>
 <s5h36lpnvzj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDB3AF89673
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2019 09:24:09 +0200 (CEST)
In-Reply-To: <s5h36lpnvzj.wl-tiwai@suse.de>
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

Hi Takashi,

The patch was work for me.
Thanks.

BR,
Kailang

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Wednesday, May 8, 2019 5:20 PM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: FW: move eapd coef function before ACT_PRE_PROBE state
> 
> On Wed, 08 May 2019 11:17:30 +0200,
> Kailang wrote:
> >
> > Sorry!! I didn't get the mail.
> >
> > > -----Original Message-----
> > > From: Takashi Iwai <tiwai@suse.de>
> > > Sent: Wednesday, May 8, 2019 3:28 PM
> > > To: Kailang <kailang@realtek.com>
> > > Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> > > Subject: Re: FW: move eapd coef function before ACT_PRE_PROBE state
> > >
> > > On Wed, 08 May 2019 08:59:02 +0200,
> > > Kailang wrote:
> > > >
> > > > Hi Takashi,
> > > >
> > > > I recreate patch as attach.
> > >
> > > No, no, it's not what I meant.  I already *reviewed* and replied your
> patch.
> > >
> > > I copy my previous reply once again.  Please read and test it.
> >
> > Patch fail.
> >
> > patch: **** malformed patch at line 10: @@ -796,10 +795,22 @@ static int
> alc_build_controls(struct hda_codec *codec)
> 
> Some mailer problem...  Use the attachment below.
> 
> 
> Takashi
> 
> 
> ------Please consider the environment before printing this e-mail.
