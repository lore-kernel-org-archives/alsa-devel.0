From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: Re: [PATCH] azt3328 fatal deadlock fix (very rare,
	though)
Date: Tue, 27 Jun 2006 15:45:34 +0200
Message-ID: <20060627134534.GA26679@rhlx01.fht-esslingen.de>
References: <20060621083234.GA25022@rhlx01.fht-esslingen.de>
	<s5hk67aer2z.wl%tiwai@suse.de>
	<20060627112823.GA30790@rhlx01.fht-esslingen.de>
	<s5h3bdqwy03.wl%tiwai@suse.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h3bdqwy03.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net, andi@lisas.de
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Jun 27, 2006 at 03:04:28PM +0200, Takashi Iwai wrote:
> Glad to hear that there is no real bug ;)

Yeah.

You seem to be a frightening bit too sure about that, though... ;)

> > Hmm, or is my driver broken on IRQ sharing? Will investigate a bit more...
> 
> I don't see problematic codes there at a quick glance.

OK.

> BTW, do you still keep CONFIG_EXPERIMENTAL for AZT3328 driver?
> If it works for you well, we can remove that flag since there is no
> many bug reports.

Been thinking about that before (since the driver is almost as
feature-complete as it can get with an entirely undocumented card),
but I wanted to run the Wine audio test suite on it directly before
removing the flag (since that could easily reveal some issues due to
much more varied sound traffic), but I haven't managed to do that yet.

Oh, and needless to say it's a *very good* idea in general to run the
Wine test suite on all sorts of ALSA drivers...

Andreas Mohr

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
