From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: mpu401_uart -how to set for output only?
Date: Fri, 19 May 2006 17:10:01 +0100
Message-ID: <200605191710.01019.gineera@aspect135.co.uk>
References: <200605191151.24428.gineera@aspect135.co.uk> <s5hejyqxjy0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hejyqxjy0.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 19 May 2006 13:44, you wrote:
> At Fri, 19 May 2006 11:51:24 +0100,
>
> Alan Horstmann wrote:
> > When a mpu401 midi device is created, it seems to appear as available for
> > both input and output.
> >
> > However, several ice1712 cards use the 2nd mpu401 port for midi out only
> > and do not make any connection available for input.
> >
> > How can the 2nd device be created for output only so the device does not
> > appear as available for input?
>
> I have the following pending patch on my local tree.
> It changes the 5th parameter in snd_mpu401_uart_new() to bit flags,
> and allows you to choose duplex, separate tx, and mmio mode.
>
> If it looks OK to you, I'll commit it.

Wow!  It is not very often something has been tackled before you mention the 
need!  I hope to try this out quickley over the next few days and report 
back.

Alan



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
