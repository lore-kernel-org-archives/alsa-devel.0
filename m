From: Luke Ross <luke@lukeross.name>
Subject: Re: "Unable to handle kernel paging request"
	panic	in	snd-usb-audio on x86_64
Date: Mon, 25 Sep 2006 00:48:58 +0100
Message-ID: <20060924234858.GA23432@lukeross.name>
References: <20060920225128.GG19215@lukeross.name>
	<s5hvenhcb8v.wl%tiwai@suse.de>
	<20060922104850.GA20850@lukeross.name>
	<s5hodt3j4fm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hodt3j4fm.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Sep 25, 2006 at 06:29:01PM +0200, Takashi Iwai wrote:
>
> > > Or are you using dmix?
> > 
> > At the moment I'm using neither. I'm using an alsa-enabled mpg123:
> > 
> > mpg123 -a hw:1,0 sound.mp3
> 
> Is there any other known program to cause this?
> Also, does it happen with the very first time you use the sound
> driver, too?

Yes, it happens with all programs I've tried so far, including 
gstream-properties, and it always happens on the first time the channel 
is PCM opened (the mixer is fine).

> I still couldn't find a proper way to reproduce this bug...

So I can compare, which kernel version are you using? As touched on 
before, it only happens to me on x86_64, and it may be SMP dependent 
(my i386 machine is uniprocessor, my x86_64 one is SMP).

I'm still awaiting the laplink cable to do a full panic log :-(

Thanks,

Luke
-- 
``Never attribute to malice what can be explained by incompetence.'' (Hanlon)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
