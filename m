From: Luke Ross <luke@lukeross.name>
Subject: Re: "Unable to handle kernel paging request" panic
	in	snd-usb-audio on x86_64
Date: Fri, 22 Sep 2006 11:48:50 +0100
Message-ID: <20060922104850.GA20850@lukeross.name>
References: <20060920225128.GG19215@lukeross.name>
	<s5hvenhcb8v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hvenhcb8v.wl%tiwai@suse.de>
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

On Thu, Sep 21, 2006 at 08:42:24PM +0200, Takashi Iwai wrote:
> At Wed, 20 Sep 2006 23:51:28 +0100,
> Luke Ross wrote:
> > 
> > Last month I submitted a patch adding support for non-standard sample 
> > rates to the snd-usb-audio driver [1], which was added to the ALSA GIT 
> > tree.
> > 
> > This works fine with 2.6.16 on i386 on one of my machines, but causes a 
> > kernel panic on opening the sound device on my other machine (dual AMD 
> > Opterton with x86_64 kernel).
> 
> Try to build with debug option.  Maybe it comes from OSS emulation?
> 
> Or are you using dmix?

At the moment I'm using neither. I'm using an alsa-enabled mpg123:

mpg123 -a hw:1,0 sound.mp3

I've built the kernel with CONFIG_SND_DEBUG, which I assume is what you 
mean, but I didn't get any further output. Do you need to enable the 
debug at runtime as well?

Luke

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
