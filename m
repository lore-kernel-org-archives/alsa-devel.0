From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Current Hardware Parameter Settings
Date: Fri, 26 Mar 2004 12:39:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040326123958.pochini@shiny.it>
References: <20040325162009.54160.qmail@web25101.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040325162009.54160.qmail@web25101.mail.ukl.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Cc: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 25-Mar-2004 Brian Furey wrote:
> Thanks Giuliano,
>
> How can I get a dump of the current hardware configuration space?

Hmm, lspci ?  :)
If you mean how to get the capabilities of the card, it's a bit
tricky. The caps are not a static thing. Each setting may rure
others. For example, a card has 8 channels and supports these
formats: S32_LE and S16_LE. But all combinations may not be
available. When the application sets format=S16_LE the driver
may restrict the max number of channels to 2. And if it sets
channels=4 the driver removes S16_LE from the list.
I can't help you anyway because I know nearly nothing about the
userspace API.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
