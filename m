From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: dsnoop slave definition fails on startup
Date: Fri, 9 Feb 2007 22:03:14 -0500
Message-ID: <75b66ecd0702091903u68000c96mbf1c1ae60a8ea8c8@mail.gmail.com>
References: <eq4rah$lhp$1@sea.gmane.org> <s5h1wl3xzv7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h1wl3xzv7.wl%tiwai@suse.de>
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
Cc: "S. Petty" <spetty01@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2/6/07, Takashi Iwai <tiwai@suse.de> wrote:
> Add the following line in the slave block
>
>                 format S32_LE
>
> Currently, the default format of direct plugins is S16, and most of
> ice1712 boards support only 32bit format.

Takashi-san,

This raises an interesting question - how can AC3 passthrough work on
these devices?  mplayer and other apps fail because they can't set
S16_LE.

Lee

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
