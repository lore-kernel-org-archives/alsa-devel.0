From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: Error: firmware not found
Date: Mon, 24 Jan 2005 12:43:00 +0100
Message-ID: <m2pszvuk6z.fsf@vador.mandrakesoft.com>
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

> Since my echoaudio driver is the first driver which is using the new
> "standard" firmware loader, I can anticipate what you have to expect
> when other drivers will be converted to that interface: people will
> not be able to make them work.
> 
> I don't know what distributions are doing, but it is causing users
> (and, in turn, to me) a lot of trouble. I located these main
> problems in the latest hotplug scripts (hotplug-2004_09_23):

(...)

> - /etc/hotplug/firmware.agent sets FIRMWARE_DIR=/lib/firmware, but
> alsa-firmware install the files in /usr/lib/hotplug/firmware .

properly packaged distro (eg: mandrakelinux) have /usr/lib/hotplug
linked on /lib/hotplug
 
> - Some distros that originally shipped with linux 2.4 (like my
> YDL3.0) do not set /proc/sys/kernel/hotplug and .../modprobe because
> rc.sysinit looks for /proc/ksyms that doesn't exists with linux 2.6.

distro bug, please reports to them

> - In /etc/hotplug/pci.agent:pci_map_modules() at line 123 I had to
> remove the break, otherwise the loop stops as soon as it finds the
> first matching PCI ID. This is not good because some cards (in my
> case the Layla3G and the Gina3G) have the same PCI card, but
> different external module.

is this the only change you had to do?



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
