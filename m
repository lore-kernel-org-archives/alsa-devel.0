From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: patch: RME9632 precise_ptr fix (9652 owners please
 read)
Date: Fri, 08 Oct 2004 23:05:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41670F10.3030000@wildgooses.com>
References: <4163FCCA.1090909@wildgooses.com> <s5hd5zuu1t5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5zuu1t5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Wed, 06 Oct 2004 15:10:18 +0100,
>Ed Wildgoose wrote:
>  
>
>>Hooray.  With some very kind help from Martin Björnsen, I have figured 
>>out the problem with the rme9652 driver when using the precise_ptr 
>>option and a fix is shown below.
>>
>>I have not been able to get in touch with Thomas Charbonnel (original 
>>author) for a long time now, so I would be grateful if someone on the 
>>alsa team could commit this to cvs.
>>    
>>
>
>Could you provide the summary, the patch description and
>signed-off-by lines for changelog?
>  
>

Sure, sorry for the delay:

Summary:
Correct hardware position mask to mask correctly when buffer is not 
maximum size.

Signed off:  Ed Wildgoose <lists@wildgooses.com>


Thanks

P.S. Anyone with a 9652 card, I would still be interested to hear if 
this improves things for you?  I think this behaviour could be made the 
default if it works correctly.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
