From: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Wed, 29 Sep 2004 07:51:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <415A4D50.8070107@pg.gda.pl>
References: <200409281447.i8SEl26W023093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409281447.i8SEl26W023093@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>in sound area. I personally want to offer Linux solution as a desktop 
>>multimedia system but at this time I just can't.
>>Sorry to say that.
> 
> 
> this is getting really irritating adam. you *can* do this, i *do* it.
> you don't like the API and you want to be able to overwrite any part
> of the buffer. this is not equivalent to "offering linux as a desktop
> multimedia system.
 From my point of view it is. I have some closed source multimedia apps
which need properly working OSS interface - java, flash player, real 
player,games and some others. You are using jack which is another 
approach requiring *rewritting* of apps. I *cannot* do this.

>>If an app could comunicate with it through /dev interface it could be 
>>unchanged and compability will be saved.
> 
> 
> ah, so thats the essence here. you still want apps to use the OSS API.
> ok, i'm out of here.
Yes, I need OSS api. It is not the problem with api. The OSS api fits my 
needs. OSS doesn't detect hw xruns but ALSA is not doing that too.
So problem is in implementing better functionality of the drivers
without changeing api. Commercial OSS is doing it that way and that is 
the proper way I think. So improving OSS/Free and expanding its 
functionality and adding new ioctl's if needed is a better way then 
makeing a completly new api. There could be a module layer on top of 
ALSA hw drivers doing that. We could do advanced functions in kernel or 
in RT daemon but from api point of view there should be no change.
Some kernel work should be done too, because kernel should know that 
some types of devices are multimedia ones (audio, video or some RT data 
grabbers and specialized devices) which should be treated specially.
Without kernel support it always will work poorly. So extracting this 
all from kernel is not a good way too.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
