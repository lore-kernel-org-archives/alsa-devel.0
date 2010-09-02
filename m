From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Re: Turtle Beach Tahiti (snd-msnd-classic)
Date: Thu, 2 Sep 2010 12:30:11 +0200
Message-ID: <F5D2EA2BCBDF9247A489B479BEB484B60B02A46A94@sicily.nmmu.ac.za>
References: <F5D2EA2BCBDF9247A489B479BEB484B60B02A45910@sicily.nmmu.ac.za>
	<s5h7hj8nlc4.wl%tiwai@suse.de>
	<F5D2EA2BCBDF9247A489B479BEB484B60B02A46A93@sicily.nmmu.ac.za>
	<s5hhbi8h3nv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ra.nmmu.ac.za (ra.nmmu.ac.za [192.96.15.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 910F2246BC
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 12:29:36 +0200 (CEST)
In-Reply-To: <s5hhbi8h3nv.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "krzysztof.h1@wp.pl" <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

No, without passing cfg it assumed PnP mode (according to dmesg).  I'll try again with just your patch on the weekend - right now I just don't have enough time to do anything properly!  I'm just happy it appears we're making progress.

Mark
-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: 02 September 2010 11:54 AM
To: Brand, Mark (Mr) (Summerstrand Campus South)
Cc: alsa-devel@alsa-project.org; krzysztof.h1@wp.pl
Subject: Re: Turtle Beach Tahiti (snd-msnd-classic)

At Thu, 2 Sep 2010 11:52:53 +0200,
Brand, Mark (Mr) (Summerstrand Campus South) wrote:
>
> Dear Takashi and all,
>
> Thank you.  After patching, snd-msnd-classic still complained about the unknown parameter 'cfg', and still assumed PnP mode without it.  I found the following at line 810:
>         module_param_array(cfg, long, NULL, S_IRUGO);
> I moved it outside of the #ifndef MSND_CLASSIC block (2 lines up) and bingo!  I now have audio, thanks again!

Ah, no, you simply don't need cfg parameter for snd-msnd-classic.
Doesn't it work by my patch but without passing cfg?


Takashi

NOTICE: Please note that this eMail, and the contents thereof, is subject to the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
