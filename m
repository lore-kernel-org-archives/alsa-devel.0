From: Benoit Fouet <benoit.fouet@purplelabs.com>
Subject: missing snd_dlclose in timer.c
Date: Tue, 25 Apr 2006 11:03:28 +0200
Message-ID: <444DE5E0.9030200@purplelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from athena.purplelabs.com (adsl-2-196.adsl.easynet.fr [212.11.31.196])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 47969159
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 11:03:30 +0200 (MEST)
Received: from localhost (localhost [127.0.0.1])
	by athena.purplelabs.com (Postfix) with ESMTP id 3E46541096
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 11:03:30 +0200 (CEST)
Received: from athena.purplelabs.com ([127.0.0.1])
 by localhost (athena.purplelabs.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23970-12 for <alsa-devel@alsa-project.org>;
 Tue, 25 Apr 2006 11:03:28 +0200 (CEST)
Received: from [10.1.2.69] (unknown [10.1.2.69])
	by athena.purplelabs.com (Postfix) with ESMTP id 4221C3D372
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 11:03:28 +0200 (CEST)
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

I worked on an ARM9E platform with not much memory. We had to
dynamically link the libraries we needed.
BTW I found out that there was a dlclose missing in ALSA lib in the
snd_timer_open_conf function.
Find below the diff of my file, if you want to add it in th hg repository.

Cheers,
Ben


diff -r 211e55692b5d src/timer/timer.c
--- a/src/timer/timer.c Wed Apr 19 12:29:47 2006 +0200
+++ b/src/timer/timer.c Tue Apr 25 10:53:04 2006 +0200
@@ -171,7 +171,10 @@ static int snd_timer_open_conf(snd_timer
        _err:
        if (type_conf)
                snd_config_delete(type_conf);
-       return err >= 0 ? open_func(timer, name, timer_root, timer_conf,
mode) : err;
+       err = err >= 0 ? open_func(timer, name, timer_root, timer_conf,
mode) : err;
+       if (h)
+               snd_dlclose(h);
+       return err;
 }

 static int snd_timer_open_noupdate(snd_timer_t **timer, snd_config_t
*root, const char *name, int mode)



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
