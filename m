From: Charles Eidsness <charles.eidsness@ieee.org>
Subject: Re: S24_LE Mode for USB Driver
Date: Wed, 13 Aug 2008 10:15:12 -0400
Message-ID: <48A2EC70.30600@ieee.org>
References: <489B5A4E.3040903@ieee.org>
	<s5htzdpi62s.wl%tiwai@suse.de>	<48A2C2D8.4040401@ladisch.de>
	<s5h63q59k2u.wl%tiwai@suse.de>	<48A2D601.8070009@ieee.org>
	<s5h1w0t9irv.wl%tiwai@suse.de>
Reply-To: charles.eidsness@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp113.rog.mail.re2.yahoo.com (smtp113.rog.mail.re2.yahoo.com
	[68.142.225.229])
	by alsa0.perex.cz (Postfix) with SMTP id A087A103897
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 16:15:14 +0200 (CEST)
In-Reply-To: <s5h1w0t9irv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>
>> Unfortunately for me this means that if I want to avoid the extra discretization 
>> distortion that comes with truncating those bottom 8-bits I'll have to add a 
>> dither function to my DAC.
> 
> We can put msbits hwparams to indicate that only 24bits are used.
> But most apps simply ignore this and checks only the format.  So, I
> don't think this would help in practise.
> 
> 

Thanks Takashi but it's probably not worth it.

Cheers,
Charles
