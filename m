From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The ALSA Situation
Date: Sat, 13 Nov 2004 10:01:40 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411131000520.4100@ppc970.osdl.org>
References: <200411102113.iAALDLUN001061@localhost.localdomain>
 <Pine.LNX.4.58.0411101426260.2301@ppc970.osdl.org>
 <Pine.LNX.4.58.0411110714280.2179@pnote.perex-int.cz>
 <Pine.LNX.4.58.0411102241240.2301@ppc970.osdl.org> <s5his8cfiot.wl@alsa2.suse.de>
 <Pine.LNX.4.58.0411110855380.2301@ppc970.osdl.org> <s5hhdnwfgbz.wl@alsa2.suse.de>
 <Pine.LNX.4.58.0411111021520.2301@ppc970.osdl.org> <s5hekizfo0n.wl@alsa2.suse.de>
 <Pine.LNX.4.58.0411120741300.2301@ppc970.osdl.org> <20041112230617.41c5073e@mango.fruits.de>
 <Pine.LNX.4.58.0411131138490.1736@pnote.perex-int.cz>
 <20041113131154.2e5690ba@mango.fruits.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041113131154.2e5690ba@mango.fruits.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Sat, 13 Nov 2004, Florian Schmidt wrote:
> 
> Cool, great news! :) How easy will it be for an end user to set this up? And
> another question: will it support mmap'ed mode?

Perhaps more importantly - will it be usable.

Sound is latency-critical. It's one of the _last_ things you want to have 
do a roundtrip to user mode..

		Linus


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
