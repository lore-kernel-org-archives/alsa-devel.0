From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: 1.0.12 breaks firmware loading
Date: Wed, 30 Aug 2006 18:30:00 +0400
Message-ID: <70a871c80608300730j737aab47padfdcb37ec15d0ce@mail.gmail.com>
References: <70a871c80608281201u7675f14fxffba5558acb0038b@mail.gmail.com>
	<70a871c80608281301j6106ce6bn28edf2df00f64635@mail.gmail.com>
	<s5hac5o6iy3.wl%tiwai@suse.de>
	<70a871c80608290606h2c16e1f6k5f92af642cddaf50@mail.gmail.com>
	<s5hmz9n65n6.wl%tiwai@suse.de>
	<70a871c80608290657x3741a388t74a6848fcb86a173@mail.gmail.com>
	<s5hbqq363qh.wl%tiwai@suse.de> <s5hwt8r4kt4.wl%tiwai@suse.de>
	<70a871c80608291341q1853bb0fge45dcdbb168b0962@mail.gmail.com>
	<s5hslje5vx6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hslje5vx6.wl%tiwai@suse.de>
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

On 8/30/06, Takashi Iwai <tiwai@suse.de> wrote:
> So, the problem was alsa-firmware-1.0.12?
Definetely.


> Actually, the auto-loading mechanism is in the driver code, but there
> seems a bug there.  Please try the patch below?
>
> A possible bug with this feature is that the mixer setting might be
> reset after power-on.
>
Thank you.
I will test the patch tomorrow and report back.

Regards,
Dmitry.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
