From: John Rigg <ad@carbon-black.co.uk>
Subject: Re: joining 2 mixer ports with .asoundrc?
Date: Fri, 1 Sep 2006 18:47:34 +0100
Message-ID: <20060901174734.GA2629@localhost.localdomain>
References: <44F8348E.2040200@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <44F8348E.2040200@gmx.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Harald Gutmann <harald.gutmann@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 01, 2006 at 03:24:30PM +0200, Harald Gutmann wrote:
> hello!
> 
> i've here a m-audio 1010lt with an ice1712 chip.
> on this card, there is no pcm mixer channel per default, but i think it 
> should be possible to add on in the .asoundrc file.

You shouldn't need to set this up in .asoundrc. The 1010LT has a very
good mixer available for it: envy24control from alsa-tools. You can set
up the card with this and the settings will usually be restored on reboot
(depending on how your distro works).

John

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
