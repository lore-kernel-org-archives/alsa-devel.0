From: Kailang <kailang@realtek.com>
Subject: Re: ALC256 speaker noise issue
Date: Tue, 31 May 2016 03:16:04 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A3E5AA@RTITMBSV09.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A3E4E9@RTITMBSV09.realtek.com.tw>
 <s5hzir7d9y4.wl-tiwai@suse.de> <s5hwpmbd9si.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 436C4265D29
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 05:16:25 +0200 (CEST)
In-Reply-To: <s5hwpmbd9si.wl-tiwai@suse.de>
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
> Sent: Monday, May 30, 2016 8:12 PM
> To: Kailang
> Cc: (alsa-devel@alsa-project.org)
> Subject: Re: ALC256 speaker noise issue
> 
> On Mon, 30 May 2016 14:09:07 +0200,
> Takashi Iwai wrote:
> > 
> > On Mon, 30 May 2016 10:13:13 +0200,
> > Kailang wrote:
> > > 
> > > Hi Takashi,
> > >  
> > > ALC256 had speaker noise issue.
> > > Attach patch will solve it.
> > >  
> > > This issue is cause from LDO output voltage control.
> > > This patch is updated the right LDO register value.
> > 
> > Applied, thanks.
> 
> Oh, I forgot to mention that there was a typo in the original 
> patch (alc255fw[] vs alc256fw[]), so I fixed it manually.

Many Many Thanks. ^^
> 
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
