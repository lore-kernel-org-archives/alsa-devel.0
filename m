From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Change alsamixer to show different views.
 Playback controls, or Capture controls.
Date: Fri, 27 Aug 2004 17:42:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <412F6481.7030300@superbug.demon.co.uk>
References: <412F2E4E.4080300@superbug.demon.co.uk> <s5hwtzkk0hf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AE188200
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 18:42:42 +0200 (MEST)
In-Reply-To: <s5hwtzkk0hf.wl@alsa2.suse.de>
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
> At Fri, 27 Aug 2004 13:51:26 +0100,
> James Courtier-Dutton wrote:
> 
>>I attach a diff file against ./alsa-utils/alsamixer/alsamixer.c
>>
>>It causes alsamixer to display 2 different views of the mixer controls.
>>One view shows only the "Playback" controls, the other view shows only 
>>the "Capture" controls, with a hidden mode (Press F1, then Enter) to 
>>show the old method of all controls together.
> 
> 
> Nice work, applied to cvs.
> 
> 
> Takashi
> 

I have a question. The "Mic Boost" seems to think it is a "Playback" 
control. What would be the best way to getting that to be a "Capture" 
control. Would simply editing it in ac97_codec.c be enough?




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
