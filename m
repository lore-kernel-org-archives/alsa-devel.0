From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Re: [Alsa-user] [PATCH] emu10k1 multichannel	support
Date: Tue, 15 Feb 2005 18:49:51 +0100
Message-ID: <4212363F.1060702@pobox.sk>
References: <200502151448.j1FEmqHo008542@www4.pobox.sk> <1108484908.5922.33.camel@radium.gaugetheory.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108484908.5922.33.camel@radium.gaugetheory.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian L Scipioni <brian@gaugetheory.org>
Cc: rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

IEC958 Optical control optical and coaxial input and not output.
There never was control to change volume of optical or coaxial output.

Master should control optical out (if "IEC958 Optical Raw" is muted).

Peter Zubaj


Brian L Scipioni wrote:

>The Optical Raw Switch changes my output from headphones only, to
>headphones plus optical out (which goes to my DD receiver).  In either
>case the IEC958 Optical slider does nothing.  In prior versions it used
>to work fine.  Fortunately, I don't need optical out attenuated for
>anything I'm doing right now, but I thought I'd report it.
>
>thanks,
>brian
>
>On Tue, 2005-02-15 at 09:48, Peter Zubaj wrote:
>  
>
>>AFAIK there wasn't any change in DSP code which should affect "IEC958
>>Optical". Do you use correct slider ? "IEC958 Optical" and not "IEC958
>>Optical Raw". Second is only switch .
>>
>>Peter Zubaj
>>
>>
>>    
>>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
