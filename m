From: Paul Davis <pbd@op.net>
Subject: Re: asoundrc parse error (bug)
Date: Thu, 09 May 2002 09:05:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205091304.PAA26398@alsa.alsa-project.org>
References: <Pine.LNX.4.33.0205090856280.544-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA26398
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 15:04:18 +0200
In-Reply-To: Your message of "Thu, 09 May 2002 09:26:57 +0200."
             <Pine.LNX.4.33.0205090856280.544-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> pcm.st {
>>        type plug
>>        slave.pcm 9652
>>        ttable.0.24 1
>>        ttable.1.25 1
>> }       
>> 
>> this will fail unless you put the "9652" for the slave.pcm definition
>> in quotes. the error is:
>> 
>> ALSA lib pcm.c:1621:(snd_pcm_open_conf) Invalid type for PCM definition (id:
> pcm, value: 9652)
>> arecord: main:447: audio open error: Invalid argument
>
>It's ok, slave.pcm should be a string (as defined in asoundrc.txt or 
>alsa-lib reference guide).

well, my original claim was that the parsing code wouldn't allow the
use of numerics as device names. abramo claimed that there was no
problem with this. this example shows that there is. 

there is nothing ambiguous about the example above. the problem arises
only because a formal grammar is not being used to parse it. whatever.

>Anyway, it would be better to add support for RME cards to standard 
>configuration files. I've created initial ones, could you verify them?
>They are placed in /usr/share/alsa/cards/ directory - RME9636.conf and 
>RME9652.conf files (sources are in alsa-lib/src/conf). The S/PDIF output 
>should work as 'plug:spdif' or  simply 'spdif' when no conversion is 
>necessary.

they look fine, to the extent that i actually understand them :)

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
