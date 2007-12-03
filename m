From: Ctirad Fertr <c.fertr@gmail.com>
Subject: Re: [PATCH] 1616(M) cardbus improvements
Date: Tue, 4 Dec 2007 00:43:25 +0100
Message-ID: <200712040043.25400.c.fertr@gmail.com>
References: <200711160007.00300.c.fertr@gmail.com>
	<200712030033.25351.c.fertr@gmail.com>
	<s5h8x4cdt31.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.vol.cz (smtp2.vol.cz [195.250.128.75])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C9692444F
	for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2007 00:43:42 +0100 (CET)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp2.vol.cz (Postfix) with ESMTP id 3B7C42A1CE
	for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2007 00:43:42 +0100 (CET)
In-Reply-To: <s5h8x4cdt31.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne Monday 03 of December 2007 10:29:38 jste napsal(a):

> In my patch, I modified the input put callback to use
> emu1616_src_regs.  Check if it's a wrong implementation.

Oh, you are right. I forgot to add 1616 related code here. Funny I didn't 
noticed any problem in regular use, because I use just analog inputs for 
capture (no difference between 1820 and 1616) and the internal routing worked 
as expected :-)
Thanks for correcting.

> > Unfortunatelly, now I found that driver (or host card) reload causes
> > kernel ooops on 2.6.23 (2.6.22 is unaffected). This is NOT related to my
> > patch.  It crashes even with 1.0.15 version. This is bad :( It crashes
> > immeditely after a firmware for the host card is loaded. Can someone
> > confirm that?
>
> Try HG version whether the same problem occurs.  Many bugs related
> with emu10k1 have been done after 1.0.15.

It seems it was caused by mix of latest driver/headres and older 
alsa-lib/alsa-utils. After upgrade of all components to the latest HG it is 
stable again. The pure 1.0.15 is stable as well with 2.6.13. It was just 
false alarm, fortunatelly.

-----
Ctirad
