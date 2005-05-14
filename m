From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: ld10k1 needs alsa-lib version 1.0.9rc3
Date: Sat, 14 May 2005 18:49:20 +0200
Message-ID: <20050514164920.GA14666@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 00DBA1C2
	for <alsa-devel@alsa-project.org>; Sat, 14 May 2005 18:49:22 +0200 (MEST)
Received: from mulder.hem.za.org (unknown [84.217.31.114])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id A186C71052
	for <alsa-devel@alsa-project.org>; Sat, 14 May 2005 18:49:22 +0200 (MEST)
Received: from skinner.hem.za.org ([fec0::202:44ff:fe1d:d021])
	by mulder.hem.za.org with esmtp (Exim 4.50)
	id 1DWzpI-00086P-Ti
	for alsa-devel@alsa-project.org; Sat, 14 May 2005 18:49:20 +0200
Received: from mikael by skinner.hem.za.org with local (Exim 4.50)
	id 1DWzpI-00041s-Jq
	for alsa-devel@alsa-project.org; Sat, 14 May 2005 18:49:20 +0200
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

Hi,

ld10k1 in alsa-tools needs emu10k1.h from alsa-lib 1.0.9rc3, since
emu10k1_fx8010_info_t has changed. The configure.in script should be
updated appropriately.

Regards,
Mikael Magnusson



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
