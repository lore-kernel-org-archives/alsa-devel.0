From: Luke Ross <luke@lukeross.name>
Subject: Re: "Unable to handle kernel paging request"
	panic	in	snd-usb-audio on x86_64
Date: Sat, 7 Oct 2006 18:10:23 +0100
Message-ID: <20061007171022.GA23089@lukeross.name>
References: <20060920225128.GG19215@lukeross.name>
	<s5hvenhcb8v.wl%tiwai@suse.de>
	<20060922104850.GA20850@lukeross.name>
	<s5hodt3j4fm.wl%tiwai@suse.de>
	<20061004201341.GA6195@lukeross.name>
	<s5hy7rtsh80.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hy7rtsh80.wl%tiwai@suse.de>
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

On Fri, Oct 06, 2006 at 03:31:59PM +0200, Takashi Iwai wrote:
>
> According to the stack trace, the problem looks rather like a problem
> of usb-audio driver than the PCM core stuff I've suspected.
> 
> Could you try the patch below?  It's to the latest HG but should be
> applicable to other recent versions, too.

I gave your patch a try, but the problem is still there.

Just for the record, the device in question supports only one rate, 
which is a non-ALSA-standard one. Therefore, needs_knot should be set 
and hence the call to snd_pcm_hw_constraint_list.

As a basic sanity check I did some printk just before the call and 
neither runtime nor fp are null, and fp->nr_rates is 1 as expected. I'm 
happy to try some more printk to try and work out what's going on, but 
still don't quite see why the code/soundcard combination works on i386 
but not x86_64 - could it be arch dependent?

Luke

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
