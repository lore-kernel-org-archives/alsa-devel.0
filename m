From: Richard Chan <rspchan@starhub.net.sg>
Subject: Re: ALC655 in CVS: Are Center/LFE switched with Surround?
Date: Wed, 19 Nov 2003 23:44:56 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBB8FF8.7050501@starhub.net.sg>
References: <3FBB8699.10602@starhub.net.sg> <s5hptfo1irr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hptfo1irr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote:

>At Wed, 19 Nov 2003 23:04:57 +0800,
>Richard Chan wrote:
>  
>
>>I've finally got 5.1 out of my via82xx/ALC655 system using the 
>>Line-In/Mic jacks!
>>Thanks Takashi.
>>    
>>
>
>glad to hear that it works now.  what was the problem?
>
> 
>  
>
>  
>
I was using
 amixer  set 'Line-In As Surround' unmute
I guess I needed to use
 amixer set 'Line-In As Surround' on

Thanks - will try the new config files and report back.

Richard



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
