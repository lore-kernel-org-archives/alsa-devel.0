From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: gcc 3.x build issue? (was: cat /proc/asound/version: "No such device": HELP!!)
Date: Tue, 18 Feb 2003 14:09:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302181409.19841.baldrick@wanadoo.fr>
References: <20030214111459.GA19210@rhlx01.fht-esslingen.de> <20030217191113.GA1853@rhlx01.fht-esslingen.de> <s5hn0kugeca.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0kugeca.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, andi@rhlx01.fht-esslingen.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> are you sure both all kernel sources and alsa drivers are compiled
> with the same compiler?
> you cannot mix gcc-2.x and gcc-3.x binaries for kernel.  the
> combination likely causes oops.

I just tried compiling the kernel with 2.95 and alsa with 3.2.
This combination results in the kind of no-such-device strangeness
that was reported.

Duncan.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
