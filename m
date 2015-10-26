From: Kailang <kailang@realtek.com>
Subject: Re: No sound after suspend-to-ram
Date: Mon, 26 Oct 2015 03:20:26 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A2376C@RTITMBSV09.realtek.com.tw>
References: <CALcwt_Acar7dhMHtEo9PtSi+RBcpXXDcQTNHZr-CEfNYhhWmRA@mail.gmail.com>
 <s5hh9ljj5nd.wl-tiwai@suse.de>
 <CALcwt_DPaX1-oBw6gVUT85bFLUKeQGcv=M9aCBHsHD=+eu_bVA@mail.gmail.com>
 <s5hsi52ujmp.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A236B9@RTITMBSV09.realtek.com.tw>
 <CALcwt_BakjANwqurkEkywkFTiNUd3WcmJFn1tovM5AVnF7XXUA@mail.gmail.com>
 <s5hr3kkaf7z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id BEDD2260471
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 04:20:43 +0100 (CET)
In-Reply-To: <s5hr3kkaf7z.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, George Gugulea <gugulea@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi George,

I think your machine had the I2C codec for speaker. I will check it with our AE.
BIOS fill the verb table for initial I2C part  to enable speaker function.
But Linux didn't know this feature. 
So, when you enter to suspend state, the codec hiden register will return to default value.
When you resume, speaker will no sound. 
Because driver need to fill the initial verb for I2C codec. But Linux didn't do it.
This says Dell had not support this machine for Linux OS.
If this support Linux OS, Ubuntu will request this from me.

This case just need to fill two registers for turn on speaker.
I could make a patch for this.

BR,
Kailang

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Saturday, October 24, 2015 3:38 PM
> To: George Gugulea
> Cc: Kailang; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] No sound after suspend-to-ram
> 
> On Sat, 24 Oct 2015 00:01:00 +0200,
> George Gugulea wrote:
> > 
> > Sure thing,
> > 
> > Kailang, yes, there is a side headphones jack and it does work OK 
> > after PM suspend-to-ram
> > 
> > I did `echo 1 > 
> /sys/modules/snd_hda_codec/parameters/dump_coef ` and 
> > I attached the output but you are probably interested in this:
> > 
> > Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono .....
> > 447c447
> > <     Coeff 0x1f: 0x00c0
> > ---
> > >     Coeff 0x1f: 0x0000
> > 464c464
> > <     Coeff 0x30: 0x00b1
> > ---
> > >     Coeff 0x30: 0x0090
> > 
> > And after I reset the two processing caps, the sound is back again.
> > 
> > hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x1f hda-verb 
> > /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x00c0 hda-verb /dev/snd/hwC0D0 
> > 0x20 SET_COEF_INDEX 0x30 hda-verb /dev/snd/hwC0D0 0x20 
> SET_PROC_COEF 
> > 0x00b1
> > 
> > I'm not sure that this are the correct parameters of 
> hda-verb (because 
> > I lack the knowledge of alsa development) but based on the 
> result it 
> > seems to be correct
> 
> Yes, the command sequences are correct (sorry I didn't write 
> it in details).  Mostly only some of these bits are 
> mandatory, but only Realtek knows this secret...
> 
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
