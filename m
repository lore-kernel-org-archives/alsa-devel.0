From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: No sound with snd_cmipci
Date: Mon, 09 Oct 2006 16:35:51 +0200
Message-ID: <452A5E47.5020801@drzeus.cx>
References: <452936A5.1020902@drzeus.cx> <s5hk639r4tz.wl%tiwai@suse.de>	
	<452A5822.9090804@drzeus.cx> <1160403701.629.18.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1160403701.629.18.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Mon, 2006-10-09 at 16:09 +0200, Pierre Ossman wrote:
>   
>>         control.4 {
>>                 comment.access 'read write'
>>                 comment.type BOOLEAN
>>                 comment.count 1
>>                 iface MIXER
>>                 name 'PCM Playback Switch'
>>                 value false
>>         } 
>>     
>
> Does it work if you unmute PCM playback?
>   

Afraid not. I haven't tried all combinations of mixer settings, but I
have changed every control at least once.

I have been using alsamixer though, so I hope it doesn't hide something
that amixer shows.

Rgds
Pierre


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
