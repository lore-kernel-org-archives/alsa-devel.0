From: Kailang <kailang@realtek.com>
Subject: Re: Fix ALC233 default init
Date: Wed, 25 Apr 2018 08:15:51 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A184124D3@RTITMBSV02.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A184124BC@RTITMBSV02.realtek.com.tw>
 <s5h36zjww36.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 08D52266CA1
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 10:15:58 +0200 (CEST)
In-Reply-To: <s5h36zjww36.wl-tiwai@suse.de>
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
> Sent: Wednesday, April 25, 2018 4:04 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: Fix ALC233 default init
> 
> On Wed, 25 Apr 2018 09:56:28 +0200,
> Kailang wrote:
> > 
> > Hi Takashi,
> >  
> > Attach patch was for fix ALC233 for default initial.
> 
> So this changes the initial coef to be equivalent with ALC255?
ID: 0x10ec0235 Bonding for ALC233
This codec equivalent with ALC255. It only use for Lenovo.

> What about alc_process_coef_fw() for headset?
Not need. Because this codec only for Lenovo.

> 
> Anyways, a bit more details would be helpful.
> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > BR,
> > Kailang
> > [2 0000-alc233-additional-support.patch <application/octet-stream 
> > (base64)>]
> > 
> 
> ------Please consider the environment before printing this e-mail.
> 
