From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: emu10k1 module compile error with latest cvs
Date: Sat, 2 Aug 2003 20:06:21 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030802190621.7778.qmail@web40602.mail.yahoo.com>
References: <20030802160424.03b022de.nigu@itadinanta.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030802160424.03b022de.nigu@itadinanta.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicola Orru' <nigu@itadinanta.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Nicola Orru' <nigu@itadinanta.it> wrote:
> It looks like a typo. Try and open emufx.c and
> replace EMU10K1_GRP_* with EMU10k1_GPR_*.

Yup, a typo. Changing .._GRP_.. to .._GPR_.. fixed it.

Cheers,
Chris

P.S. alsa-lib is still broken, though.

________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://uk.messenger.yahoo.com/


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
