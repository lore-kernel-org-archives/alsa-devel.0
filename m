From: Kailang <kailang@realtek.com>
Subject: Re: Verb table for group section
Date: Tue, 12 Dec 2017 09:49:12 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A183FA397@RTITMBSV02.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A183FA361@RTITMBSV02.realtek.com.tw>
 <s5hh8sw9usf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id CE7B8267194
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 10:49:17 +0100 (CET)
In-Reply-To: <s5hh8sw9usf.wl-tiwai@suse.de>
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
> Sent: Tuesday, December 12, 2017 5:10 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: Verb table for group section
> 
> On Tue, 12 Dec 2017 09:30:18 +0100,
> Kailang wrote:
> > 
> > Hi Takashi,
> >  
> > Attach file was ALC274 in our ENG test machine.
> >  
> > 0x16 0x90170110   => speaker
> > 0x19 0x01a1913c   => headset mic
> > 0x1a 0x01a1913d   => headphone MIC
> > 0x1b 0x04011020  => Line out
> > 0x21 0x0421102F  => Headphone
> >  
> > How could i set verb for group and sequence that Line out 
> and Headphone will use DAC 0x03?
> 
> What is the exact restriction?  0x1b and 0x21 must use 0x03 
> while 0x16 to 0x02?

Because the EQ support on DAC 0x02. If speaker muted, EQ will disable.

> 
> If yes, try to define spec->gen.preferred_dacs[].  It's a 
> list of paired NIDs to define the preferred DAC for each pin. 
>  For example,
> 
> 	{ 0x1b, 0x03, 0x21, 0x03, 0x16, 0x02, 0 }
> 
> (don't forget the zero-termination).

static void alc274_dell_fixup_dac_bind(struct hda_codec *codec,
					    const struct hda_fixup *fix,
					    int action)
{
	struct sigmatel_spec *spec = codec->spec;
	static hda_nid_t preferred_pairs[] = {
		0x21, 0x03, 0x1b, 0x03, 0x16, 0x02,
		0
	};

	if (action != HDA_FIXUP_ACT_PRE_PROBE)
		return;

	spec->gen.preferred_dacs = preferred_pairs;
}

I use upper. It was assigned to 0x03 for 0x1b.
But could I set it to default for ALC274?
Speaker always use DAC 0x02. Other outs use DAC 0x03.

> 
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
