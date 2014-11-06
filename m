From: Kailang <kailang@realtek.com>
Subject: Re: Restore hidden register for default value
Date: Thu, 6 Nov 2014 02:36:09 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A179FAB55@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A179F9CEA@RTITMBSV09.realtek.com.tw>
 <s5hr3y0cz5k.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A179FAAFE@RTITMBSV09.realtek.com.tw>
 <s5hlhnq9jtm.wl-tiwai@suse.de> <s5hwq798cp8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 474B62650C5
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 03:36:41 +0100 (CET)
In-Reply-To: <s5hwq798cp8.wl-tiwai@suse.de>
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
> Sent: Thursday, November 06, 2014 7:12 AM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: Restore hidden register for default value
> 
> At Wed, 05 Nov 2014 08:40:21 +0100,
> Takashi Iwai wrote:
> > 
> > At Wed, 5 Nov 2014 07:20:06 +0000,
> > Kailang wrote:
> > > 
> > >  Hi Takashi,
> > > 
> > >  I mail it again.
> > 
> > Oh, your previous post didn't include the patch, so I just 
> waited for 
> > it.
> > 
> > Now I took a look at the patch.  One thing I'd like to 
> change is the 
> > place to set spec->init_hook.  It'd be better to set around 
> the code 
> > where alc662_fill_coef is passed.  Since ALC668 is irrelevant with 
> > this, move the switch/case there, apply both spec->init_hook 
> > conditionally.
> 
> I changed that part manually and applied the patch now.

Oh! Thank you ... I just want to do this modify to you today.
Many Thanks. ^^

> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
