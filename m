From: Giuliano Pochini <pochini@shiny.it>
Subject: pcm interfaces questions
Date: Tue, 25 Mar 2003 18:24:13 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030325182413.pochini@shiny.it>
References: <s5hwuipozr8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwuipozr8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



snd_pcm_new() has two parameters for the number of substreams
for playback and capture. Yes, but what does it mean ? If I
have N playback substreams, can I service N applications that
use one stream ? Can channels be allocated on demand, to allow
the user to use 4 xmms or 1 xmms and a dvd player (5.1) at the
same time ? :)) It's quite useless... I'm just curious.
Also snd_pcm_new() can create multiple pcm interfaces. SP/DIF
and ADAT i/o need a pcm instance too, isn't it ?


Bye.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
