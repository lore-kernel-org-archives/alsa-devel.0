From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Error: firmware not found
Date: Tue, 25 Jan 2005 09:22:26 +0100 (CET)
Message-ID: <XFMail.20050125092226.pochini@shiny.it>
References: <m2pszvuk6z.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2pszvuk6z.fsf@vador.mandrakesoft.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 24-Jan-2005 Thierry Vignaud wrote:

>> - Some distros that originally shipped with linux 2.4 (like my
>> YDL3.0) do not set /proc/sys/kernel/hotplug and .../modprobe because
>> rc.sysinit looks for /proc/ksyms that doesn't exists with linux 2.6.
>
> distro bug, please reports to them

It's an old pre-2.6 distro, there's nothing to report.
It may cause troubles to users, though, so I let you know.


>> - In /etc/hotplug/pci.agent:pci_map_modules() at line 123 I had to
>> remove the break, otherwise the loop stops as soon as it finds the
>> first matching PCI ID. This is not good because some cards (in my
>> case the Layla3G and the Gina3G) have the same PCI card, but
>> different external module.
>
> is this the only change you had to do?

Basically, yes.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
