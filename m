From: Marcus Andersson <054185595@telia.com>
Subject: Re: hdsp and midi problems
Date: Sat, 21 Jun 2003 22:14:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF4BCA2.578FD128@telia.com>
References: <3EF4BB26.F407F10E@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

More information,

when I run the program with 100% load using my VIA motherboard midi, I
loose no bytes as far as I can see.

I use alsa 0.9.4

Marcus

Marcus Andersson wrote:
> 
> Hi,
> 
> I have written a simple application that continuously reads one byte
> from midi in on my hdsp multiface and prints the result to the console.
> This is done with a plain loop without any calls to poll() or select().
> When I run this loop as fast as I can, with 100% processor load, I loose
> lots of bytes sent over midi. When I run the loop slower, I loose one
> byte occasionally. Can this behaviour be explained? What should I do to
> be sure to not loose any bytes? Is this a bug?
> 
> Marcus
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: INetU
> Attention Web Developers & Consultants: Become An INetU Hosting Partner.
> Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
> INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
