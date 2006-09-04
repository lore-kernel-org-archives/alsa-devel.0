From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: 1.0.12 breaks firmware loading
Date: Tue, 5 Sep 2006 03:04:09 +0400
Message-ID: <70a871c80609041604w6de2916ajaf89cabeaa6eca32@mail.gmail.com>
References: <70a871c80608281201u7675f14fxffba5558acb0038b@mail.gmail.com>
	<70a871c80608290657x3741a388t74a6848fcb86a173@mail.gmail.com>
	<s5hbqq363qh.wl%tiwai@suse.de> <s5hwt8r4kt4.wl%tiwai@suse.de>
	<70a871c80608291341q1853bb0fge45dcdbb168b0962@mail.gmail.com>
	<s5hslje5vx6.wl%tiwai@suse.de>
	<70a871c80608300730j737aab47padfdcb37ec15d0ce@mail.gmail.com>
	<s5hr6yy47dh.wl%tiwai@suse.de>
	<70a871c80609032303j16ec31e8xf4fdc1c3dc5f0dac@mail.gmail.com>
	<s5hlkozlxyg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hlkozlxyg.wl%tiwai@suse.de>
Content-Disposition: inline
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

On 9/4/06, Takashi Iwai <tiwai@suse.de> wrote:
> I guess the problem of firmware loading was fixed by 1.0.13rc1
> package.  There was a problem in configure script that it resets the
> kernel CONFIG_FW_LOADER* acciedentally, which results in the driver
> without firmware support.
Not tested yet, will try to test today.

> Hm, could you check whether a kernel message like "Hammerfall-DSP:
> loading firmware" appears?  This should be called when a PCM device is
> opened, or any new PCM action is done.

Thank you. Works great!.
One minor issue: if firmware was already uploaded, after reboot,
firmware is not cached, since it's already present in the box. I
suppose it is easy to fix.


Regards,

Dmitry.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
