From: Kailang <kailang@realtek.com>
Subject: Re: Patch to enable audio on alc888 vendor id
	0x10ec0888 revisionid 0x100202
Date: Tue, 7 Oct 2014 09:38:18 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A179F87E8@RTITMBSV09.realtek.com.tw>
References: <5432A439.1050909@gregfarrell.org>
 <s5h4mvhxom4.wl-tiwai@suse.de>	<5432ACB4.6060202@gregfarrell.org>
 <s5htx3hw8lq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 35E11260423
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 11:38:32 +0200 (CEST)
In-Reply-To: <s5htx3hw8lq.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Greg Farrell <greg@gregfarrell.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

It maybe wrong format for verb table of 0x1d.
I think the verb table was not create by Realtek AE.
EAPD need to high level for this case. 
But its SSID was not assigned. It didn't use fixup table to support it.

1. Create SVID and SSID
2. Change BIOS verb table of 0x1d

I will check with our AE for the verb table setting.

BR,
Kailang

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Monday, October 06, 2014 10:56 PM
> To: Greg Farrell
> Cc: alsa-devel@alsa-project.org; Jaroslav Kysela; Kailang
> Subject: Re: Patch to enable audio on alc888 vendor id 
> 0x10ec0888 revision id 0x100202
> 
> At Mon, 06 Oct 2014 15:52:36 +0100,
> Greg Farrell wrote:
> > 
> > On 06/10/14 15:24, Takashi Iwai wrote:
> > > Is the chip really identified as ALC888 by the driver? 
> Please give 
> > > alsa-info.sh output (run with --no-upload option), just 
> to be sure.
> > > The same codec ID (10ec:0888) is used by various chips, so we may 
> > > need to use a different thing to check the validity of 
> > > alc888_coef_init() application. thanks, Takashi
> > 
> > It is. One other thing of note is that there is a 'SKU not 
> ready' error.
> 
> This message is irrelevant.  It means just that the codec 
> SSID isn't set in Realtek-compliant way.
> 
> > I originally intended to just cut & paste enough content from the 
> > alsa-info.sh output file to show it is detected as a ALC888 
> chip but 
> > figured that I was better giving you everything rather than 
> filtering 
> > based on what I feel is helpful to you. Apologies for the 
> size of the email.
> 
> Yep, that's more helpful indeed.
> 
> I'll wait for Kailang's comment on this issue.
> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
