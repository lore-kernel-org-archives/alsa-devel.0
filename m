From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: PCM ioctls
Date: Fri, 16 Aug 2002 15:12:25 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020816221225.10207.qmail@web11504.mail.yahoo.com>
References: <s5hvg6x8dhi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11504.mail.yahoo.com (web11504.mail.yahoo.com [216.136.172.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id AAA04374
	for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2002 00:12:31 +0200
In-Reply-To: <s5hvg6x8dhi.wl@alsa2.suse.de>
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

Hi,

There are 3 standard PCM ioctls, and a driver could potentially support others
via its own ioctl function registered in the snd_pcm_ops_t structure. Could
anyone give me a hint regarding how an application could then call such
standard and other ioctls?

Thanks,
Guilhem.


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
