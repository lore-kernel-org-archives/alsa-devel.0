From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: smix plugin available?
Date: Wed, 27 Nov 2002 12:06:10 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE41A82.6030608@superbug.demon.co.uk>
References: <E18Goo5-0008Ma-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18Goo5-0008Ma-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Florian Bomers <Florian.Bomers@sun.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:

>  
>
>>>the APIs that are used to write almost all audio software code in 
>>>production these days all use a callback model. 
>>>      
>>>
>>Sorry for questioning this statement. Of course we all don't have any statisti
>>cal data but
>>you miss what I see as the majority of applications that use audio devices:
>>
>>1) games
>>2) media players
>>3) GUI sounds (i.e. accessibility)
>>    
>>
>
>this is a fair point. i apologize. i have my head so far inside the
>"audio software for musicians" box that i tend to fail to see such
>applications :)
>
>however, the very fact that the applications developers of such
>programs really don't know much (if anything) about audio programming,
>and probably don't want to know much about it either, suggests that an
>API like ALSA which exposes the full HAL is probably a mistake. again,
>i consider PortAudio a vastly preferable solution.
>
>  
>
I would like to point out that a "callback" api would work just as well 
as an open/write/close api for

1) games
2) media players
3) GUI sounds (i.e. accessibility)

I have to agree with Paul on the fact that a "callback" approach is really the ONLY real option.
Here is my reasoning: -
1) My perspective is from "(2) Media players" and not "Pro-Audio"
2) Sound Hardware tends to have very small buffers.
3) For nice sounding audio, these buffers should never run dry. I.E. No XRUNs.
4) A open/write/close api will never ever be able to guarantee no XRUNs, as it has no control on when it will get scheduling time to do the next write.
5) With a "callback" approach, the kernel would be notified by the sound hardware that it was ready for new samples, the kernel could then adjust the scheduler, so that the "callback" function was called ASAP.
The "callback" function then only has to decide which samples to give. If the "callback" function could receive a "delay" value from the sound hardware at each callback, a media player would then have all the information it needed to do full audio/video sync.
6) I don't need "sample sync", but I do NEED "callback" based api to provide me with "no XRUNs".

Summary: - 
The only way to cure XRUN problems is with a "callback" based api.
All application that currently use open/write/close apis, can just as easily use a "callback" api.

Cheers
James





-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
