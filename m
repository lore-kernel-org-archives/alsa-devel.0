From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: ALS300 Driver....kinda
Date: Tue, 20 Jul 2004 09:46:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040720094619.pochini@shiny.it>
References: <20040719235831.B509579004D@ws1-14.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040719235831.B509579004D@ws1-14.us4.outblaze.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ash Willis <ashwillis@programmer.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 19-Jul-2004 Ash Willis wrote:

> I've only been focusing on PCM playback for the moment and the driver is in
> such a state that it will allow the first dma transfer to take place but then
> when servicing interrupts, no further writes to dma take place, so the card
> just sits there playing a small sample over and over...

How is the DMA buffer structured ?  It's OK if the card keeps repeating the
buffer forever, but you need a way to inform ALSA what the card is playing at
a given moment, usually when it crosses periods boundaries.



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
