From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: [PATCH] alsactl crashes on 1.0.18rc3 alsa-utils
Date: Sun, 14 Sep 2008 23:37:27 +0100
Message-ID: <gak3n7$rgg$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EE98243C7
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 18:22:13 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kf0Ds-0002zA-Aa
	for alsa-devel@alsa-project.org; Sun, 14 Sep 2008 22:37:40 +0000
Received: from 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk
	([80.192.67.147]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2008 22:37:40 +0000
Received: from gmane by 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2008 22:37:40 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

One of my Mandriva colleagues (Gustavo De Nardin) fixed this in the 
following patch:
http://svn.mandriva.com/cgi-bin/viewvc.cgi/packages/cooker/alsa-utils/current/SOURCES/alsa-utils-1.0.18rc3-mdv-alsactl_segfault.patch?revision=HEAD&view=markup

Please apply if it's not already been fixed.

Cheers

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
