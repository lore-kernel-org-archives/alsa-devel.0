From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] Echoaudio driver
Date: Tue, 26 Oct 2004 23:18:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041026231854.4708848a.pochini@shiny.it>
References: <s5his9h4a3u.wl@alsa2.suse.de>
	<XFMail.20041012112521.pochini@shiny.it>
	<20041023161530.605de269.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041023161530.605de269.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 23 Oct 2004 16:15:30 +0200
Giuliano Pochini <pochini@shiny.it> wrote:

> Ok, external firmware should work for all cards. [...]

0.9.4- Two busy loops were been replaced with something more
system-friendly (the machine does not freeze anymore while loading the
firmware, expecially if something goes wrong). Some more coding style
changes were done (c++ comments).


There are two semi-issues left.

1- All levels are exported to userspace in 24.8 fixed point format. This is
done by the driver, because the hw currently only have 1 or 0.5 dB
resolution. I'm not sure if exporting gains in native resolution is better.

2- There is that ugly hack to make the sample rate selection work fine in
the most common cases. I already talked about that. The problem is that the
sample clock is shared by all channels. The current implementation allows an
app to change che clock freely as far as there is only one pcm device open.
When there are >1 it allows one app to set the clock only once. This method
prevents an app to kick in and screw up an already running recording or
playback. It's a hack, but it worked fine so far. I think it's about ok :-/


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
