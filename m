From: Giuliano Pochini <pochini@shiny.it>
Subject: Echoaudio driver, hint request
Date: Mon, 8 Nov 2004 22:46:37 +0100
Message-ID: <20041108224637.1fd8b6cd.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



My driver currently registers two pcm devices: pmc#0 for analog channels and
pcm#1 for digital channels. Though the DSP interface does not make that
distinction: for example the Gina24 has 2 analog and 8 digital input
channels and they are numbered 16..25. It's also possible to use a substream
made of all 10 channels at the same time.

The question is: what's better, the current approach of keeping analog and
digital channels on different pcm devices (quite messy at driver level), or
should I put them toghether and write a proper .alsarc file, so the user can
choose digital channels by name instead of by index ?



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
