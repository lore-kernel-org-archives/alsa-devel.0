From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: How does one alter the main mixer volume (or any
 other mixer level) in ALSA from a command line (via a simple system call)?
Date: Thu, 6 Mar 2003 08:48:35 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303060846100.1206-100000@pnote.perex-int.cz>
References: <000601c2e39d$900ce510$aa1f830a@ICO>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA05247
	for <alsa-devel@alsa-project.org>; Thu, 6 Mar 2003 08:48:30 +0100
In-Reply-To: <000601c2e39d$900ce510$aa1f830a@ICO>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 6 Mar 2003, Ivica Bukvic wrote:

> Hi all,
> 
> I have this small question:
> 
> Is it possible (I presume it is) to alter mixer settings in Alsa by
> invoking some kind of a system call using shell (i.e. how the RME hdsp
> can have its stuff altered)?

Use amixer.

> If so, what is the range of values that describe the loudest and softest
> levels?

You may specify levels in percent (0%-100%). If you are asking, how the 
levels are related to dB, then we don't offer this information.

Our idea is to describe the hardware over alsa-lib (via some configuration 
files which will describe accurately the hardware). But it's not a goal 
for the near future.

> Finally, are these levels standardized?

Nope.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
