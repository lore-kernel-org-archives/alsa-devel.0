From: Michael Voigt <michael.c.m.voigt@web.de>
Subject: Re: write/read system calls and ioctl
Date: Sat, 22 Dec 2007 13:12:59 +0100
Message-ID: <200712221313.02976.michael.c.m.voigt@web.de>
References: <200712191856.20679.michael.c.m.voigt@web.de>
	<s5hsl1w1ajj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id B5C42243A4
	for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2007 13:13:12 +0100 (CET)
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id F0A26BC2C554
	for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2007 13:13:11 +0100 (CET)
Received: from [141.76.49.56] (helo=os-dhcp056.inf.tu-dresden.de)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.108 #208) id 1J63E7-0002Ie-00
	for alsa-devel@alsa-project.org; Sat, 22 Dec 2007 13:13:11 +0100
In-Reply-To: <s5hsl1w1ajj.wl%tiwai@suse.de>
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

Thanks a lot, Takashi!

Am Freitag 21 Dezember 2007 13:45:20 schrieb Takashi Iwai:
> At Wed, 19 Dec 2007 18:56:17 +0100,
>
> Michael Voigt wrote:
> > My question: what is snd_pcm_write in pcm_native.c good for? Is it only
> > there to keep ALSA compatible to older versions of alsa-lib?
>
> Yes, exactly.  Some apps (e.g. older version of sox) used directly
> read/write, and this is also for them.
>
>
> Takashi



-- 
Today is Sweetmorn, the 64th day of The Aftermath in the YOLD 3173
