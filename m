From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Error: firmware not found
Date: Tue, 25 Jan 2005 09:15:59 +0100 (CET)
Message-ID: <XFMail.20050125091559.pochini@shiny.it>
References: <m2llajuk4c.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2llajuk4c.fsf@vador.mandrakesoft.com>
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

>> is this the only change you had to do?
>=20
> eg:
>=20
> --- ./etc/hotplug/pci.agent.tv3 2005-01-24 12:41:00.610030503 +0100
> +++ ./etc/hotplug/pci.agent     2005-01-24 12:41:19.903578455 +0100
> @@ -117,7 +117,6 @@
>         if [ $class_temp -eq $class ]; then
>             DRIVERS=3D"$module $DRIVERS"
>             : drivers $DRIVERS
> -           break
>         fi
>      done
>  }


Yes, this and the path to the fw directory. It works fine
for my setup. Users did not try it yet.



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
