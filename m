From: Giuliano Pochini <pochini@shiny.it>
Subject: Same PCI ID, different cards - rfc
Date: Sun, 17 Apr 2005 17:25:29 +0200
Message-ID: <20050417172529.7dea3b59.pochini@shiny.it>
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



I did some work in order to solve the problem about the Gina3G and the
Layla3G which share the same PCI card so it's impossible to say what card is
installed before probing.

The main difference between the two cards is the number of channels. I added
those data in chip_t and I replaced the related macros with inline functions
(defined in echoaudio.h). Those functions return a constant for all non-3G
cards, so no overhead is added. The patch has been tested on my Gina24 and
Gina3G only. It's quite big because it touches a lot of code and it replaces
a few files but the relevant changes are only in echoaudio.h, echo3g.c and
echo3g_dsp.c .

http://xoomer.virgilio.it/g_pochini/e3g.patch


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
