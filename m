From: Laurent Georget <lgeorget2@club-internet.fr>
Subject: Re: help for a levelmeter
Date: Fri, 18 Oct 2002 11:00:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DAFCDAB.1090204@club-internet.fr>
References: <20021016220528.EF3E0E081@relay-4m.club-internet.fr>
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
Cc: Paul Davis <pbd@op.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>    [ please forward to alsa-devel@lists.sourceforge.net. i still
>      cannot post there. 
>    ]
> 
> 
>>Anyway I can now try to experiment the copy_plugin : would you know some 
>>program using
>>this plugin, which would make the thing easier !
> 
> 
> programs don't "use" a plugin. its just a function of which PCM device
> they are told to open. the code they contain is no different whether
> they are accessing a hardware PCM device, a "plughw" PCM device, or a
> "copy" PCM device.
> 
> --p


Ok, thanks for explanation !
Does asking  "a program using snd_pcm_copy  family function" would be 
correct ?

(or using snd_pcm_meter functions, as Abramo Bagnara  said later on the 
thread)


In fact, the relation between plugins you define in .asoundrc and their 
relative c function
is not clear to me , so I'm now going to figure out out how it works, 
but if you have lights
on the subject,  it would be ok.

As you can see, i'm an unexperienced developper so be patient  ...
Laurent




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
