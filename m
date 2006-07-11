From: "Theodoros V. Kalamatianos" <thkala@softlab.ece.ntua.gr>
Subject: polypaudio renamed to pulseaudio
Date: Tue, 11 Jul 2006 20:23:02 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0607112016170.5284@rhama.deepcore.ngn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from diomedes.noc.ntua.gr (diomedes.noc.ntua.gr [147.102.222.220])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 14D0E253
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 19:23:42 +0200 (MEST)
Received: from theseas.softlab.ece.ntua.gr (theseas.softlab.ece.ntua.gr
	[147.102.1.1])
	by diomedes.noc.ntua.gr (8.13.7/8.13.7) with ESMTP id k6BHNgRP082025
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 20:23:42 +0300 (EEST)
	(envelope-from thkala@softlab.ece.ntua.gr)
Received: from rhama.deepcore.ngn (ppp056.dialup.ntua.gr [147.102.223.56])
	(authenticated bits=0)
	by theseas.softlab.ece.ntua.gr (8.13.4/8.13.4/Debian-3sarge1) with
	ESMTP id k6BHNZKF012999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2006 20:23:38 +0300
Received: from rhama.deepcore.ngn (localhost.localdomain [127.0.0.1])
	by rhama.deepcore.ngn (8.13.7/8.13.3) with ESMTP id k6BHN30r029299
	for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2006 20:23:03 +0300
Received: from localhost (sysop@localhost)
	by rhama.deepcore.ngn (8.13.7/8.13.3/Submit) with ESMTP id
	k6BHN2d2029293
	for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2006 20:23:03 +0300
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

According to www.pulseaudio.org the polypaudio project was renamed to 
pulseaudio. As a result the names of the header files and some other stuff 
have changed and alsa-plugins cannot be built with support for pulseaudio. 
I think that a new plugin should be added with support for the new PA 
project. It would probably be mostly a copy of the polyp plugin with 
minimal changes.

Regards,

Theodoros Kalamatianos


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
