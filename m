From: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
Subject: Re: [ALSA - driver 0000628]: Can't record audio
Date: Thu, 20 Jan 2005 21:00:18 +0000
Message-ID: <41F01BE2.5020808@blueyonder.co.uk>
References: <4ca0e9985d5a7a7378d1370dcaa3754e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-out5.blueyonder.co.uk (smtp-out5.blueyonder.co.uk [195.188.213.8])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BD74F270
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2005 22:00:39 +0100 (MET)
In-Reply-To: <4ca0e9985d5a7a7378d1370dcaa3754e@bugtrack.alsa-project.org>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

bugtrack@alsa-project.org wrote:
| The following issue has been RESOLVED.
| ======================================================================
| <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=628>
| ======================================================================
| Reported By:                pawlik
| Assigned To:                tiwai
| ======================================================================
| Project:                    ALSA - driver
| Issue ID:                   628
| Category:                   PCI - via82xx
| Reproducibility:            always
| Severity:                   major
| Priority:                   normal
| Status:                     resolved
| Distribution:               Debian
| Kernel Version:             2.6.8.1
| Resolution:                 not an issue
| Fixed in Version:
| ======================================================================
| Date Submitted:             11-03-2004 18:46 CET
| Last Modified:              01-17-2005 15:07 CET
| ======================================================================
| Summary:                    Can't record audio
| Description:
| I'm not able to record any audio. Reading from /dev/dsp results in an
| "Input/Output Error".
| The hardware I'm using is Soltek 75DRV5 with built-in soundcard.
| ======================================================================
|
| ----------------------------------------------------------------------
|  rossaxe - 01-16-05 17:09
| ----------------------------------------------------------------------
| What is this particular knob supposed to do? So far as I can tell, it just
| offers a choice betweens 'works' and 'breaks'
|
| ----------------------------------------------------------------------
|  tiwai - 01-17-05 15:07
| ----------------------------------------------------------------------
| This defines the connection of which input pin is selected for the certain
| input path.  So, whether it works or not strongly depends on the hardware.

Wouldn't it make sense to disable it on hardware for which it does not work?

Ross


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8Bvg9bR4xmappRARAtWbAJ4yMhnjJsmPYx2wJhFzdIMjGEAIpQCgj6u1
VU6489GB6yag+RcNT/h/Rzk=
=oc4t
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
