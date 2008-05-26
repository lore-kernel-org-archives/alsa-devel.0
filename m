From: klondike <franxisco1988@gmail.com>
Subject: Re: ICH8 HDA not detected after upgrade from Ubuntu
	7.10 to 8.04
Date: Mon, 26 May 2008 13:00:10 +0200
Message-ID: <8b17778e0805260400l2419addfm7fb6c64ca995f310@mail.gmail.com>
References: <5ea2cfca0805250944g3705aa41jb78f3b89e43075ef@mail.gmail.com>
	<4839DF2B.7020501@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <4839DF2B.7020501@cox.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: stan <ghjeold_i_mwee@cox.net>
Cc: alsa-user@lists.sourceforge.net, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2008/5/25 stan :
> I think this is an issue for some hda-intel cards in kernel version
> 2.6.25.  In the cases I have seen the card was working on the 24 version
> kernel, but when they moved to 25 it stopped working.  That is, it's a
> regression.  I don't think there is anything you can do until the
> problem is fixed there.  Using the earlier kernel is probably not
> possible with the rest of the system.  I don't know this, but suspect
> it.  You could try compiling an earlier kernel on your system.
The thing is that the kernel jump was from 2.6.22 to 2.6.24, albeit
that could also cause problems.

BTW: if you want to compile a kernel on Ubuntu you can look at
https://help.ubuntu.com/community/Kernel/Compile but I don't think
that's a good idea as different versions of the alsa drivers and the
alsa lib may be incompatible.

PS: Janto it'd be nice if you post a bug report on launchpad so Ubuntu
developers also know this issue.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
