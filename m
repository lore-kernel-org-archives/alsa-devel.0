From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: 1.0.12 breaks firmware loading
Date: Tue, 29 Aug 2006 17:57:18 +0400
Message-ID: <70a871c80608290657x3741a388t74a6848fcb86a173@mail.gmail.com>
References: <70a871c80608281201u7675f14fxffba5558acb0038b@mail.gmail.com>
	<s5hfyfg7ip0.wl%tiwai@suse.de>
	<70a871c80608281301j6106ce6bn28edf2df00f64635@mail.gmail.com>
	<s5hac5o6iy3.wl%tiwai@suse.de>
	<70a871c80608290606h2c16e1f6k5f92af642cddaf50@mail.gmail.com>
	<s5hmz9n65n6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmz9n65n6.wl%tiwai@suse.de>
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

On 8/29/06, Takashi Iwai <tiwai@suse.de> wrote:
> Which do you use, hdsploader or kernel firmware loader?
I tried both.

> Interesting.  Basically there is no change in hdsp driver itself.
> The diff is like below.
Seems much changed. The only suspicious line for me is one with
request_irq(). I see it uses different flags in 1.0.12.

I can test 1.0.12 with old request_irq if it does make sense. But a
bit later this day.

Dmitry

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
