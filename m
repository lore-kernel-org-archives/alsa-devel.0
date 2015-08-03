From: Kailang <kailang@realtek.com>
Subject: Re: EAPD enable for HP ALC221
Date: Mon, 3 Aug 2015 08:30:18 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A1F4D8@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A1F456@RTITMBSV09.realtek.com.tw>
 <s5hfv40pyr2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id BC5822650BE
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 10:30:22 +0200 (CEST)
In-Reply-To: <s5hfv40pyr2.wl-tiwai@suse.de>
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

Hi Takashi,

The nid is the 0x17.
Default nid were 0x14 and 0x15.
And the 0x1d verb doesn't have enable amp bit.

BR,
Kailang

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Monday, August 03, 2015 4:23 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: EAPD enable for HP ALC221
> 
> On Mon, 03 Aug 2015 08:55:02 +0200,
> Kailang wrote:
> > 
> > Hi Takashi,
> >  
> > HP ALC221 platform needs to enable EAPD for speaker output.
> > Attach patch was enable the EAPD for speaker.
> 
> The EAPD should have been enabled as default.  If it isn't 
> the case, likely something else is wrong.
> 
> Could you give more information, e.g. alsa-info.sh outputs at 
> both working and broken states?
> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
