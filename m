From: Kailang <kailang@realtek.com>
Subject: Re: No sound after suspend-to-ram
Date: Mon, 26 Oct 2015 07:00:20 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A237A0@RTITMBSV09.realtek.com.tw>
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
 by alsa0.perex.cz (Postfix) with ESMTP id 89B262604A1
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 08:00:25 +0100 (CET)
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

Hi Takashi,

        [ALC275_FIXUP_DELL_XPS] = {
                .type = HDA_FIXUP_VERBS,
                .v.verbs = (const struct hda_verb[]) {
                        /* Enables internal speaker */
                        {0x20, AC_VERB_SET_COEF_INDEX, 0x1f},
                        {0x20, AC_VERB_SET_PROC_COEF, 0x00c0},
                        {0x20, AC_VERB_SET_COEF_INDEX, 0x30},
                        {0x20, AC_VERB_SET_PROC_COEF, 0x00b1},
                        {}
                }
        },

Could I put code as upper? Was it enter to initial state?
I think it should be execute atfter resume back. Right?

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
