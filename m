From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] Echoaudio driver
Date: Sat, 6 Nov 2004 23:53:52 +0100
Message-ID: <20041106235352.72b20afa.pochini@shiny.it>
References: <s5his9h4a3u.wl@alsa2.suse.de>
	<XFMail.20041012112521.pochini@shiny.it>
	<20041023161530.605de269.pochini@shiny.it>
	<20041026231854.4708848a.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041026231854.4708848a.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
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

On Tue, 26 Oct 2004 23:18:54 +0200
Giuliano Pochini <pochini@shiny.it> wrote:

> 1- All levels are exported to userspace in 24.8 fixed point format. This is
> done by the driver, because the hw currently only have 1 or 0.5 dB
> resolution.

I removed that crap. Ctl interface now uses raw values.

I don't see anything obviously wrong in the driver now. What have I to do to
include it in alsa-driver yet ?

(the code is here as usual: http://xoomer.virgilio.it/g_pochini/ea.html)

Perhaps I'll put the driver in bugfixes-only state because it's very stable
and ready for production for a long time now and because Echoaudio has just
released a new version of their generic code that support all cards and I
want to start working of it ASAP. There are several changes to the DSP
firmware that may cause incompatibilities with the current driver (maybe
not, I only had a look at the notes).


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
