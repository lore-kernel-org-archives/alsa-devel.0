From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: 1.0.12 breaks firmware loading
Date: Mon, 4 Sep 2006 10:03:39 +0400
Message-ID: <70a871c80609032303j16ec31e8xf4fdc1c3dc5f0dac@mail.gmail.com>
References: <70a871c80608281201u7675f14fxffba5558acb0038b@mail.gmail.com>
	<70a871c80608290606h2c16e1f6k5f92af642cddaf50@mail.gmail.com>
	<s5hmz9n65n6.wl%tiwai@suse.de>
	<70a871c80608290657x3741a388t74a6848fcb86a173@mail.gmail.com>
	<s5hbqq363qh.wl%tiwai@suse.de> <s5hwt8r4kt4.wl%tiwai@suse.de>
	<70a871c80608291341q1853bb0fge45dcdbb168b0962@mail.gmail.com>
	<s5hslje5vx6.wl%tiwai@suse.de>
	<70a871c80608300730j737aab47padfdcb37ec15d0ce@mail.gmail.com>
	<s5hr6yy47dh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hr6yy47dh.wl%tiwai@suse.de>
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

Sorry for the delay.

On 8/30/06, Takashi Iwai <tiwai@suse.de> wrote:
> Hm, could you compare the files installed between 1.0.11 and 1.0.12?

Only in alsa-1.0.12/lib/firmware: asihpi
Only in alsa-1.0.11/lib/firmware/ea: loader_dsp.fw
Only in alsa-1.0.12/lib/firmware: emu

I incorrectly stated problems with RME Multiface, it works with 1.0.12.
Echo Indigo IO does not. And there's a new file in .12 - loader_dsp.fw.
I suppose, echo firmware loading was changed.

As for multiface, patch did not help. I stiil have to replug cardbus
if I power-cycle multiface box. hdsploader still gives:
Upload firmware for card hw:0
Hwdep ioctl error on card hw:0 : Device or resource busy.

Regards,

Dmitry.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
