From: Dave Andruczyk <djandruczyk@yahoo.com>
Subject: 0.9beta 11 info for non-gurus
Date: Tue, 26 Feb 2002 11:41:44 -0800 (PST)
Message-ID: <20020226194144.65409.qmail@web14102.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from web14102.mail.yahoo.com (web14102.mail.yahoo.com [216.136.172.132])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id UAA04251
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2002 20:41:57 +0100
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

For those not so well versed in ALSA if you install 0.9beta 11 over a
previous release, make sure you DELETE the /lib/modules/YOUR_KERNEL/misc/snd*
modules.

The beta 11 version reorganizes the ALSA kernel drivers in a much better and
cleaner format, under /lib/modules/YOUR_KERNEL/kernel/sound/


ALSO (I didn't check the docs),  but if your module was "snd-card-xxxxx"  its
now snd-xxxxx.  Thus the older snd-card-emu10k1, is now snd-emu10k1.

So edit your /etc/modules.conf as appropriate and things should be just fine.
make sure to run "depmod -a" after modifying /etc/modules.conf, or after
deleting/adding kernel modules to your modules tree under
/lib/modules/YOUR_KERNEL


Aside from that beta 11 works wonderfully on my box (Mandrake 8.1)



=====
Dave J. Andruczyk
Enterprise Resource Providers

__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - Send FREE e-cards for every occasion!
http://greetings.yahoo.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
