From: Laurent Georget <lgeorget2@club-internet.fr>
Subject: Re: help for a levelmeter
Date: Fri, 18 Oct 2002 11:27:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DAFD3E9.8090400@club-internet.fr>
References: <20021015224039.59921.qmail@web12207.mail.yahoo.com>		<3DADC922.5000808@club-internet.fr> <3DAE626C.7601185C@libero.it> <87r8ep9ca1.fsf@sulphur.joq.us> <3DAF2236.EA2A74BD@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Abramo Bagnara wrote:
> Jack O'Quin wrote:
> 
>>Abramo Bagnara <abramo.bagnara@libero.it> writes:
>>
>>
>>>The correct plugin has already been written and available inside
>>>alsa-lib.
>>>
>>>The name is pcm_meter, it's lockless and perfectly integrated with ALSA
>>>PCM chains.
>>>
>>>A sample implementation for curses level meter is already available and
>>>working.
>>>
>>>It's very simple to add other *-meters, scopes, etc.
>>
>>That's great!
>>
>>Is there any user-level documentation for all this cool stuff?
> 
> 
> Ehm... guess what...
> 
> No, wait: I wrote some lines in asoundrc.txt:
> 
>   type meter            # Meter PCM
>   slave STR             # Slave name (see pcm_slave)
>   # or
>   slave {               # Slave definition or name
>     pcm STR             # Slave PCM name
>     # or
>     pcm { }             # Slave PCM definition
>   }
>   [frequency INT]       # Updates per second
>   scopes {              # Scopes
>     ID STR              # Scope name (see pcm_scope)
>   # or
>     ID { }              # Scope definition (see pcm_scope)
>   }
> 
> # PCM scope type definition
> pcm_scope_type.NAME {
>   [lib STR]             # Library file (default libasound.so)
>   [open STR]            # Open function (default
> _snd_pcm_scope_NAME_open)
> }
> 
> # PCM scope definition
> pcm_scope.NAME {
>   type STR              # Scope type
>   ...
> }
> 
> The rest is obvious, of course ;-)))
> 

Excellent!

Well, you wrote  that there is a sample implementation of this pcm_meter ,
but I can't find it (searched in alsa tools / utils , and searched  with 
google with no good result)

Anyway, i'm going on trying to use it

Thanks

Laurent




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
