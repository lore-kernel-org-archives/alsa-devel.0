From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: Error: firmware not found
Date: Mon, 24 Jan 2005 12:44:35 +0100
Message-ID: <m2llajuk4c.fsf@vador.mandrakesoft.com>
References: <20050122113702.023929f1.pochini@shiny.it>
	<m2pszvuk6z.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2pszvuk6z.fsf@vador.mandrakesoft.com> (Thierry Vignaud's
 message of "Mon, 24 Jan 2005 12:43:00 +0100")
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

Thierry Vignaud <tvignaud@mandrakesoft.com> writes:

> > - In /etc/hotplug/pci.agent:pci_map_modules() at line 123 I had to
> > remove the break, otherwise the loop stops as soon as it finds the
> > first matching PCI ID. This is not good because some cards (in my
> > case the Layla3G and the Gina3G) have the same PCI card, but
> > different external module.
> 
> is this the only change you had to do?

eg:

--- ./etc/hotplug/pci.agent.tv3 2005-01-24 12:41:00.610030503 +0100
+++ ./etc/hotplug/pci.agent     2005-01-24 12:41:19.903578455 +0100
@@ -117,7 +117,6 @@
        if [ $class_temp -eq $class ]; then
            DRIVERS="$module $DRIVERS"
            : drivers $DRIVERS
-           break
        fi
     done
 }



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
