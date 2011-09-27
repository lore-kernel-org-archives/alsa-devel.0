From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: davinci-pcm debug
Date: Tue, 27 Sep 2011 11:51:03 -0400
Message-ID: <CAPcSpELH_08HCii_7BZTpVury-DmdfGb8uVzvd80iHos_=nW5g@mail.gmail.com>
References: <7B4FB10C4117DC479BE74BE8181DEEC6136047E2@PO1-COV.ad.corp.globalstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67]) by alsa0.perex.cz (Postfix) with ESMTP id 9A61824462
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 17:51:07 +0200 (CEST)
Received: by vws5 with SMTP id 5so8335235vws.31
	for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2011 08:51:04 -0700 (PDT)
In-Reply-To: <7B4FB10C4117DC479BE74BE8181DEEC6136047E2@PO1-COV.ad.corp.globalstar.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Pettit <David.Pettit@globalstar.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi David,
On Thu, Sep 15, 2011 at 7:04 PM, David Pettit
<David.Pettit@globalstar.com> wrote:
> I've written a new codec driver and tested it on an EVM for a TI Davinci =
ARM processor. =A0It appeared to be working there. =A0However, now I'm tryi=
ng to debug buffer under-runs in my embedded system. =A0I've inserted a deb=
ugging trace in the function davinci_pcm_pointer() in davinci-pdm.c to prin=
t out the value of asp_count. =A0What I'm seeing is that when I first start=
 playing an audio file, the value of asp_count increments very slowly. =A0A=
fter some time, the value of asp_count start incrementing by the period siz=
e and I start seeing the debugging trace "davinci-pcm: audio_set_dma_params=
_play ...". =A0Is this behavior expected?
>
> If I enable XRUN DEBUG and set the value to 5, then I occasionally see th=
e message "PCM: hw_ptr skipping! (pos=3D17153, delta=3D23938, period=3D512,=
 jdelta=3D0/49/0, hw_ptr=3D17279/17279)" where delta is always high. =A0The=
 comments in pcm_lib.c indicate that delta should be small or zero. =A0What=
 does a large value indicate?

We had also experienced strange pointer increments here when using a
mainline version of the davinci-pcm driver. Commit
52e2c5d38ea6f13a19c29da7ba5183e6fac55400 'ASoC: davinci-pcm: convert
to BATCH mode' remedied the problem for us. I recommend you give it a
try.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
