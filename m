From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Re: intel 8x0 went silent in 2.6.11
Date: Fri, 04 Mar 2005 22:16:03 +0100
Message-ID: <4228D013.8010307@drzeus.cx>
References: <4227085C.7060104@drzeus.cx>	<29495f1d05030309455a990c5b@mail.gmail.com>	<Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>	<1109875926.2908.26.camel@mindpipe>	<Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>	<1109876978.2908.31.camel@mindpipe>	<Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com> <20050303154929.1abd0a62.akpm@osdl.org> <4227ADE7.3080100@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <4227ADE7.3080100@drzeus.cx>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Andrew Morton <akpm@osdl.org>, Mark Canter <marcus@vfxcomputing.com>, rlrevell@joe-job.com, nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pierre Ossman wrote:
> Andrew Morton wrote:
> 
>> Mark Canter <marcus@vfxcomputing.com> wrote:
>>  
>>
>>> To close this issue out of the LKML and alsa-devel, a bug report has 
>>> been written.
>>>
>>> It appears to be an issue with the 'headphone jack sense' (as kde 
>>> labels it).  The issue is in the way the 8x0 addresses the docking 
>>> station/port replicator's audio output jack.  The mentioned quick fix 
>>> does not work for using the ds/pr audio output, but does resolve it 
>>> for a user that is only using headphones/internal speakers.
>>>   
>>
>>
>> But there was a behavioural change: applications which worked in 2.6.10
>> don't work in 2.6.11, is that correct?
>>
>> If so, the best course of action is to change the kernel so those
>> applications work again.  Can that be done?
>>
>>  
>>
> Yes. Speakers worked in 2.6.10 and stopped working in 2.6.11. This could 
> be changed by setting the default for the two new volumes to muted. I 
> don't know how this affects the issue with the docking station or the 
> bug that this is supposed to solve though.
> 

It seems I spoke too soon. The defaults picked by the driver are 
actually fine. It seems to be alsactl store/restore that did something 
strange when coming from an older kernel.

Rgds
Pierre


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
