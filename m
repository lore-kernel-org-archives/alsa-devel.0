From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Change alsamixer to show different views.
 Playback controls, or Capture controls.
Date: Fri, 27 Aug 2004 18:34:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <412F709D.10903@superbug.demon.co.uk>
References: <412F2E4E.4080300@superbug.demon.co.uk>	<s5hwtzkk0hf.wl@alsa2.suse.de>	<412F6481.7030300@superbug.demon.co.uk> <s5hsma8jzfp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-37.mail.demon.net (anchor-post-36.mail.demon.net [194.217.242.86])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1654F1E5
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 19:34:23 +0200 (MEST)
In-Reply-To: <s5hsma8jzfp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>
>>I have a question. The "Mic Boost" seems to think it is a "Playback" 
>>control. What would be the best way to getting that to be a "Capture" 
>>control. Would simply editing it in ac97_codec.c be enough?
> 
> 
> Hmm, when you change the control name itself, it breaks slightly
> compatibility with older version.

What does the name have to be compatible with?
I.e. What program might break if we change this in ac97_codec.c ?

> 
> I don't mind it, but maybe it would be wiser to change alsa-lib
> simple.c to handle 'Mic Boost' as capture?
> 
> 
> Takashi
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
