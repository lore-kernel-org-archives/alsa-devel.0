From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Sound card DMA questions.
Date: Tue, 20 Jul 2004 09:39:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040720093911.pochini@shiny.it>
References: <40FC72D4.1040900@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40FC72D4.1040900@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 20-Jul-2004 James Courtier-Dutton wrote:
> With DMA accesses, one has a sound card connected to a PCI bus, which
> is then connected to the RAM.
>
> The sound card will schedule a DMA transfer.
>
> My questions are:
> 1) What size is the DMA transfer?

It's defined by the driver.


> 2) Are the min/max limits on how many bytes can be passed on a transfer?

Usually, no.  There may be limits defined by DMA-able region and
card's capabilities.


> 3) When does the transfer happen. At period boundarys or when ?

DMA transfers are managed entirely by the card once the driver
starts them. You should ask the manufacturer for these infos. Btw
they're not important from the driver's viewpoint.


> 4) What triggers a user land poll() to return. An irq based
> snd_period_elapsed() call, or something else?

_elapsed() doesn't require to be called from inside irq handler.


> 5) if I am reverse engineering a card, how can I discover these
> min/max values?

There isn't a standard procedure to reverse engeneer something.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
