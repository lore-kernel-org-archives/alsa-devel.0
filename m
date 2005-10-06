From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Implement support for display of dB gain
 in alsamixer.
Date: Thu, 06 Oct 2005 13:54:37 +0100
Message-ID: <43451E8D.9010402@superbug.co.uk>
References: <Pine.HPX.4.33n.0509201455140.23957-100000@studcom.urz.uni-halle.de> <Pine.LNX.4.61.0509210954590.12389@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0509210954590.12389@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

>On Tue, 20 Sep 2005, Clemens Ladisch wrote:
>
>  
>
>>Jaroslav Kysela wrote:
>>    
>>
>>>On Mon, 19 Sep 2005, Takashi Iwai wrote:
>>>      
>>>
>>>>>I would vote to keep the kernel space as simple as possible and give the
>>>>>whole contents to apps. They can implement reading/caching/filtering
>>>>>themselves.
>>>>>          
>>>>>
>>>>Agreed.
>>>>        
>>>>
>>Too.
>>
>>    
>>
>>>Ok, good ideas. I would propose this final API:
>>>
>>>1) one key with specific delimiters like:
>>>
>>>list		# list everything (all keys)
>>>list/master	# list only master keys (mixer, pcm etc.)
>>>list/mixer	# list only mixer keys
>>>list/pcm
>>>      
>>>
>>This is _not_ a simple API.  AFAICS the idea was to have just one big
>>string/blob containing all descriptions, and to let the lib or
>>applications do the listing/searching/etc.
>>
>>Accessing specific keys (elements) would be needed only if something
>>wasn't read only.
>>    
>>
>
>You need also take in account that keys might be added/removed at runtime.
>The question is still to have:
>
>1) manager code in the midlevel to register keys from drivers and do 
>   lookups; in this case the drivers will register the keys
>2) leave things simple for midlevel and the ioctl will be directly mapped 
>   to the driver code (the blob version of ioctl); in this case the driver 
>   must handle all things like memory allocation, key changes etc.
>
>						Jaroslav
>  
>

I think that a simple TLV(type, length, value) approach might be more 
efficient for kernel -> alsa-lib info passing.
The message can easily be made hyrachical. One starts with one TLV as a 
wrapper around all information passed. Inside that TLV will be other 
TLVs, and inside those others. This allows the alsa-lib to simply skip 
values it does not yet know about. We can even use a TLV in the request 
from alsa-lib to the kernel.

The T(Type) value is a simple 32bit integer. The receiving function 
simply uses a lookup to find the parameter name, and also the type of 
the value, e.g. Integer, string etc.

For an example of a protocol already using this approach, look at the 
RFCs for RADIUS.

James



*
*


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
