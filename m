From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: mpu401_pnp
Date: Mon, 7 Feb 2005 16:54:14 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502071640410.3379-100000@studcom.urz.uni-halle.de>
References: <4207664F.8030305@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3474B20B
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2005 16:54:16 +0100 (MET)
In-Reply-To: <4207664F.8030305@free.fr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: matthieu castet <castet.matthieu@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

matthieu castet wrote:
> Ok, I found a bug in your patch : when you call pnp_register_driver, you
> should check that it is >= 0. If not you shouldn't call
> pnp_unregister_driver.

I just copied this from the other ALSA PnP drivers.  It seems those
have all the same bug.

> One question : does snd_card_set_dev(card, &device->dev) is important ?

Well, this pointer should be set if possible, but I'm not sure if it's
actually used anywhere.

> It wasn't use with acpi.

Well, it should have been used. :-)  I adapted the ACPI code from the
serial driver which of course didn't have this, and the 2.4 kernel I
developed this on didn't have 'struct device' anyway.


Best regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
