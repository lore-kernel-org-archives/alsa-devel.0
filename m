From: Carlos Pita <carlosjosepita@yahoo.com.ar>
Subject: Re: oss raw midi emulation
Date: Sun, 28 Nov 2004 14:34:12 -0300
Message-ID: <200411281434.12978.carlosjosepita@yahoo.com.ar>
References: <200411281214.24321.carlosjosepita@yahoo.com.ar> <Pine.LNX.4.58.0411281622150.11615@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp202.mail.sc5.yahoo.com (smtp202.mail.sc5.yahoo.com [216.136.129.92])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 53411243
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 18:30:21 +0100 (MET)
In-Reply-To: <Pine.LNX.4.58.0411281622150.11615@pnote.perex-int.cz>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 28 November 2004 12:22, you wrote:
> On Sun, 28 Nov 2004, Carlos Pita wrote:
> 
> > which suggests that /dev/midi?? shouldn't be symlinked as I'm
> > doing with /dev/midi10.
> 
> No, debian or snddevices script in the driver package does right job.

debian sarge only creates /dev/midi00, ..., /dev/midi03. I need the
/dev/midi10, ..., /dev/midi13 ones. Perhaps if I install udev they will
be created when virmidi is loaded (my kernel has hotplug enabled,
but does virmidi send a hotplug add event? I'm really short of
knowledge here).

I think that my current /dev/ fs is a "static" one, since debian udev package
is not installed and devfs fs creation is disabled at boot time. But I don't know
how to be sure. If the /dev/ fs is "static", would snddevices add the
needed /dev/midi10../dev/midi13 files?

Regards,
Carlos


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
