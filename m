From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: Error: firmware not found
Date: Mon, 24 Jan 2005 12:52:27 +0100
Message-ID: <m2hdl7ujr8.fsf@vador.mandrakesoft.com>
References: <20050122113702.023929f1.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050122113702.023929f1.pochini@shiny.it> (Giuliano Pochini's
 message of "Sat, 22 Jan 2005 11:37:02 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini <pochini@shiny.it> writes:

> This is not good because some cards (in my case the Layla3G and the
> Gina3G) have the same PCI card, but different external module.

you mean that you've one of this card and that hotplug loads the wrong
module ?
if yes, this is a driver bug indeed.

if several drivers request devices with the same ids whereas they
thrully are different devices, these drivers should export a list of
ids with subids then.



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
