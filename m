From: castet.matthieu@free.fr
Subject: Re: mpu401_pnp
Date: Mon,  7 Feb 2005 11:40:27 +0100
Message-ID: <1107772827.4207459b9628a@imp2-q.free.fr>
References: <Pine.HPX.4.33n.0502070940520.3379-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Received: from postfix3-2.free.fr (postfix3-2.free.fr [213.228.0.169])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B8A361DB
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2005 11:40:28 +0100 (MET)
In-Reply-To: <Pine.HPX.4.33n.0502070940520.3379-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Clemens Ladisch <clemens@ladisch.de>:

> castet.matthieu@free.fr wrote:
> > I send you a mpu401 modules that support pnpbios.
>
> Applied (merged with mpu401.c), thanks.
>
> (I didn't read your mail from Friday until I had written the patch. :)
>
> > As you can see, because of a bug in pnpbios code, sometime it doesn't=
 find
> a
> > irq, so it add a litle hack waiting the bug is fix in the kernel.
>
> I didn't add this workaround.  Is this bug still in the kernel?
>
No it was corrected in 2.6.9 or 2.6.10.

Regards,

Matthieu




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
