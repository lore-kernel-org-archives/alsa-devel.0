From: Fred Gleason <fredg@salemradiolabs.com>
Subject: Re: AudioScience driver
Date: Tue, 1 Jul 2003 16:52:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307011652.48863.fredg@salemradiolabs.com>
References: <20030625145823.9192.h003.c012.wm@mail.icqmail.com.criticalpath.net> <s5hr85blmrl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr85blmrl.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Eliot Blennerhassett <bigblen@icqmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 30 June 2003 09:26, Takashi Iwai wrote:

> > Good idea.
> > how about /usr/include/asihpi/hpi.h
>
> well, assuming the certain header location is not recommended.
>
> basically, the kernel sources must not refer to the standard header
> files for user-space.  if you need a header file for the kernel,
> include it in the kernel tree.  or, more easily, specify the header
> path explicitly with -I option in Makefile (which may be given by the
> configure script).

Then perhaps '/usr/include/linux/hpi.h'.  

Cheers!


|-------------------------------------------------------------------------|
|      Frederick F. Gleason, Jr.      |         Salem Radio Labs          |
|       Voice: 1-(540)-341-2880       |      87 Lee Highway, Suite 11     |
|        FAX: 1-(540)-341-7176        |        Warrenton, VA 20186        |
|-------------------------------------------------------------------------|
| When you say 'I wrote a program that crashed Windows', people stare     |
| at you and say 'Hey, I got those with the system, *for free*'.          |
|                                         -- Linus Torvalds               |
|-------------------------------------------------------------------------|




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
