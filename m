From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: mpu401_pnp
Date: Mon, 7 Feb 2005 09:46:53 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502070940520.3379-100000@studcom.urz.uni-halle.de>
References: <1093985441.4134e4a1e2295@imp4-q.free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 56CAE1EC
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2005 09:46:55 +0100 (MET)
In-Reply-To: <1093985441.4134e4a1e2295@imp4-q.free.fr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: castet.matthieu@free.fr
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

castet.matthieu@free.fr wrote:
> I send you a mpu401 modules that support pnpbios.

Applied (merged with mpu401.c), thanks.

(I didn't read your mail from Friday until I had written the patch. :)

> As you can see, because of a bug in pnpbios code, sometime it doesn't find a
> irq, so it add a litle hack waiting the bug is fix in the kernel.

I didn't add this workaround.  Is this bug still in the kernel?


Best regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
