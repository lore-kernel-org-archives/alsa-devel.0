From: Jack Howarth <howarth@bromo.med.uc.edu>
Subject: esound 0.2.26 and alsa 0.9.0-rc1
Date: Thu, 9 May 2002 21:12:59 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205100112.VAA36533@bromo.msbb.uc.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bromo.msbb.uc.edu (bromo.med.uc.edu [129.137.3.146])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id DAA05655
	for <alsa-devel@alsa-project.org>; Fri, 10 May 2002 03:14:07 +0200
Received: (from howarth@localhost)
	by bromo.msbb.uc.edu (SGI-8.9.3/8.9.3) id VAA36533
	for alsa-devel@alsa-project.org; Thu, 9 May 2002 21:12:59 -0400 (EDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

   Has anyone gotten the alsa support in esound 0.2.26 to work?
I find that the current version (available from
http://ftp.gnome.org/pub/GNOME/pre-gnome2/releases/gnome-2.0-desktop-20020509/
) can be built without changes against the alsa 0.9.0-rc1 headres. However
on ppclinux with snd-powermac loaded, the libalsa esound module still
fails to initialize properly. It tries all of the possible bit sizes and
freqs and then exits saying it couldn't find a usable one. Is this
just a powermac problem or does other alsa soundcard drivers in 0.9.0-rc1
doing the same. I really was hoping to dump the esound/oss mode and
use esound in alsa mode instead.
                        Jack

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
