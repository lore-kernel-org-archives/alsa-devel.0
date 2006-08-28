From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: blocking snd_rawmidi_read and usb device
	disconnection
Date: Mon, 28 Aug 2006 16:14:30 +0400
Message-ID: <70a871c80608280514x77847afbu9b8d75ba35a99519@mail.gmail.com>
References: <70a871c80608271715i339b2695i87e920e3c34b75da@mail.gmail.com>
	<s5hpsel6rji.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hpsel6rji.wl%tiwai@suse.de>
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

On 8/28/06, Takashi Iwai <tiwai@suse.de> wrote:
>
> Ditto.  Better to be fixed.
Good news :)

> But, I suppose the current behavior doesn't "break" the system, at
> least?
Sometimes, can't figure when specifically, after killing such waiting
program, ref couner for snd_rawmidi becomes bigger than it should and
can't be unloaded. One time it ended up with refcounter 8, with no
modules using it.

It's not a showstopper, but definetely a bug.

Dmitry.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
