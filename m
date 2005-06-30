From: Karsten Jeppesen <karsten@jeppesens.com>
Subject: Re: Alsa fails to open plug:surround51
Date: Thu, 30 Jun 2005 14:45:52 -0700
Message-ID: <42C46810.30108@jeppesens.com>
References: <42BB74E8.4030006@jeppesens.com>	<Pine.HPX.4.33n.0506240910160.23252-100000@studcom.urz.uni-halle.de> <s5hk6kcylhx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk6kcylhx.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote:

>At Fri, 24 Jun 2005 09:11:35 +0200 (METDST),
>Clemens Ladisch wrote:
>  
>
>>Karsten Jeppesen wrote:
>>    
>>
>>>Xine will open default to play the dvd menu (2.0).
>>>Then it will issue a snd_pcm_close for that stream
>>>
>>>When it then tries to open plug:surround51 (for the movie)  then this
>>>call fails with resource busy.
>>>      
>>>
>>Which sound card?
>>
>>Could you check with strace whether the device (/dev/snd/pcmCxDyp)
>>really is closed?
>>    
>>
>
>A known problem with dmix.  It's a race between the dmix server
>process and reopening process.
>
>A workaround would be to take a short sleep (or polling of resource
>release) at closing a dmix stream...  But anyway it's tricky.
>  
>
What I ended up doing in Xine is just that. Sleeping a second and then 
try again.
Thanks both of you.  (Soundcard is an ALC650 builtin on an ABIT NF7-S, 
using analog outputs)

Karsten



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
