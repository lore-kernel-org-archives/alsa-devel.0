From: Jose Fonseca <j_r_fonseca@yahoo.co.uk>
Subject: i810 regression (?)
Date: 06 Mar 2002 18:29:51 +0000
Message-ID: <1015439391.1256.29.camel@mefriss1>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from mhs.swan.ac.uk (mhs.swan.ac.uk [137.44.1.33])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA20780
	for <alsa-devel@alsa-project.org>; Wed, 6 Mar 2002 19:29:58 +0100
Received: from ccs-mail1.singleton.swan.ac.uk ([137.44.41.18])
	by mhs.swan.ac.uk with esmtp (Exim 3.34 #1)
	id 16ig86-0005A2-00
	for alsa-devel@alsa-project.org; Wed, 06 Mar 2002 18:27:10 +0000
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

I have an Intel i810 AC97 with RHL 7.1. After I updated the kernel to
2.4.9-31 I decided to update the alsa drivers to the latest 0.9.0beta12
version as well.

After doing everything as usual and change the module name in
/etc/modules.conf the sound worked, but it was accelerated, i.e., with a
higher frequency rate than it should.

I switched back to the previous driver (0.9.0beta10a) and it worked
again.

Is this a regression issue or a configuration matter?

Jose' Fonseca



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
