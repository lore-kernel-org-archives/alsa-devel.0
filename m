From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Regression for Lenovo X240 sound in 3.18
Date: Tue, 10 Feb 2015 09:49:08 +0800
Message-ID: <CAN8cciY-Epxy3XYLbV5hYc15ctJQC7Ze_bbfHq_En6aq1ytX6g@mail.gmail.com>
References: <alpine.LSU.2.11.1412291303200.30351@nerf08.vanv.qr>
 <s5h387xi2yp.wl-tiwai@suse.de>
 <alpine.LSU.2.11.1412301629280.1813@nerf08.vanv.qr>
 <s5h1tnhi1jx.wl-tiwai@suse.de> <s5hr3vhgldi.wl-tiwai@suse.de>
 <alpine.LSU.2.11.1412301907120.5263@nerf08.vanv.qr>
 <s5hmw64gq1f.wl-tiwai@suse.de>
 <alpine.LSU.2.11.1501101213460.22151@nerf60.vanv.qr>
 <s5h4mqvv0m5.wl-tiwai@suse.de>
 <alpine.LSU.2.11.1502091233110.6143@nerf60.vanv.qr>
 <s5hr3tztfaz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com
 [209.85.192.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 4636D260615
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 02:49:09 +0100 (CET)
Received: by mail-qg0-f44.google.com with SMTP id j5so9320761qga.3
 for <alsa-devel@alsa-project.org>; Mon, 09 Feb 2015 17:49:08 -0800 (PST)
In-Reply-To: <s5hr3tztfaz.wl-tiwai@suse.de>
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
Cc: Jan Engelhardt <jengelh@inai.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, mr.bobukas@gmail.com
List-Id: alsa-devel@alsa-project.org

> > >>
> > >> On 3.19-rc3+ [eb74926920cfa756087a82e0b081df837177cb95] I confirm
> > >> all the volume bars/switches that went missing for me are back again.
> > >>
> > >> As said, all is fine here.
> > >
> > >Sorry, I've forgotten this pending issue.
> > >Could you confirm that the patch below works for you?  Then I'll queue
> > >up for 3.20-rc1 and backport appropriately.
> >
> > I have no problems with 3.19-rc6.
> > Your patch does not appear to break anything, but it does not appear
> > to fix something, either. It does change the controls again though.
> > I suggest not to apply it.
> >
> > http://picpaste.de/3_19_rc6-NgtzogKW.png
> > http://picpaste.de/3_19_rc6_YOURPATCH-y6IcoXpE.png
>
> OK, if 3.19 works as is, then there is no reason to change there.
>
> I don't understand why T440P fixup node 0x16 as Dock Headphone Jack but
the driver create Line Out Playback Switch at node 0x16

Do the driver change the type to line out when there are three different
location (int, ext sep and ext left) ?

using hda-emu , when Dock headphone jack is plugged , the pin ctl is OUT
instead of OUT HP
