From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: The ALSA Situation
Date: Sat, 13 Nov 2004 11:38:42 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411131133300.1736@pnote.perex-int.cz>
References: <200411102113.iAALDLUN001061@localhost.localdomain>
 <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
 <Pine.LNX.4.58.0411110714280.2179@pnote.perex-int.cz>
 <Pine.LNX.4.58.0411102241240.2301@ppc970.osdl.org>  <s5his8cfiot.wl@alsa2.suse.de>
  <Pine.LNX.4.58.0411110855380.2301@ppc970.osdl.org>  <s5hhdnwfgbz.wl@alsa2.suse.de>
  <Pine.LNX.4.58.0411111021520.2301@ppc970.osdl.org>  <s5hekizfo0n.wl@alsa2.suse.de>
  <Pine.LNX.4.58.0411120741300.2301@ppc970.osdl.org>  <20041112230617.41c5073e@mango.fruits.de>
 <1100308501.2337.54.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1100308501.2337.54.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: Florian Schmidt <mista.tapas@gmx.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Nov 2004, Manuel Jander wrote:

> By now, the only solution i can think of, is doing some measurements at
> startup, to determine the feasible period size/count bounds, without
> xruns.

I would suggest to look to snd_spcm functions in alsa-lib/include/pcm.h.
The alsa-lib will take care.

I think that the bottom HAL should be kept as is (to allow every 
parameters for specific apps), but we can simplify the initialization
for standard set of applications.

> IMHO, ALSA requires a resource manager. And before someone starts
> hacking any shit, please let us design something well done.

Exactly. We need a configuration manager for alsa-lib.
We can discuss it right now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
