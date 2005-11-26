From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Implement support for display of dB gain
 in alsamixer.
Date: Sat, 26 Nov 2005 12:02:17 +0000
Message-ID: <43884EC9.3090609@superbug.co.uk>
References: <Pine.HPX.4.33n.0509201455140.23957-100000@studcom.urz.uni-halle.de>	<Pine.LNX.4.61.0509210954590.12389@tm8103.perex-int.cz>	<43451E8D.9010402@superbug.co.uk> <s5h64sabx5i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64sabx5i.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>I think that a simple TLV(type, length, value) approach might be more 
>>efficient for kernel -> alsa-lib info passing.
>>The message can easily be made hyrachical. One starts with one TLV as a 
>>wrapper around all information passed. Inside that TLV will be other 
>>TLVs, and inside those others. This allows the alsa-lib to simply skip 
>>values it does not yet know about. We can even use a TLV in the request 
>>from alsa-lib to the kernel.
>>
>>The T(Type) value is a simple 32bit integer. The receiving function 
>>simply uses a lookup to find the parameter name, and also the type of 
>>the value, e.g. Integer, string etc.
>>
>>For an example of a protocol already using this approach, look at the 
>>RFCs for RADIUS.
> 
> 
> I think it's OK to use such a protocol, as long as the kernel
> implemention is simple.  Maybe less allergy than XML texts :)
> One-to-one mapping would be the easiest for the driver side.
> And, above all, it's driver specific how complex it will be.
> Not many drivers require the dynamic topology information.
> 
> 
> My concern about the new ioctl is: Avoid architecture dependency.
> It implies:
>   - Don't use union.
>   - Don't use long.
>   - Don't use long long.
>   - Don't use bit fields.
>   - Avoid pointer as much as possible.
>   - Consider the alignment.
> 
> This is one of the reasons why I don't want to merge the dB attribute
> into snd_ctl_elem_info/value.
> 
> 
> Takashi
> 
> 

Ok, so I am going to implement a new IOCTL that will use TLVs.
The first implementation will be used to support the dB gain information 
passing, but it will be flexible enough to request any information needed.

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
