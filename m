From: Paul Davis <pbd@op.net>
Subject: Re: any change in usb status?
Date: Mon, 04 Mar 2002 12:12:57 -0500
Message-ID: <200203042212.RAA03293@renoir.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA11336
	for <alsa-devel@alsa-project.org>; Mon, 4 Mar 2002 23:12:56 +0100
In-reply-to: Your message of "Mon, 04 Mar 2002 12:52:56 PST."
             <3C83DEA8.6010000@openface.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Reynald Hoskinson <bean@openface.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>I'm eying the maudio USB Audio Duo.  It seems an ideal soundcard for my 
>needs, is locally available, and relatively inexpensive, and if I ever 
>get a laptop, it'll work with that too. I understand usb is not 
>supported by alsa yet. Is this still true? Is there plans for the 
>future, or is there something that makes it impossible ever to use with 
>alsa? The m-audio delta series is well supported, so perhaps this could 
>be too in the future?

as i noted the other day, i believe that the plan is to support USB
(and IEEE1394/firewire) entirely in user space, though with the help
of the existing (generic) USB/IEEE1394 drivers.

alsa-lib has been designed to support such things. you just write a
library that opens the relevant USB device, handles the protocol
translation, and provides the functions used by alsa-lib. there is no
need to write a kernel driver. however, i have not heard of any plans
by anyone to do this. its not that hard in theory, but the impression
i have is that very few USB devices are fully standards-compliant, so
there is kinds of futzing around to get the device-specific parts of
the protocol translation part to work 100%.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
