From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: ADPCM 16kbps and other formats
Date: Fri, 16 Aug 2002 15:47:59 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020816224759.14004.qmail@web11504.mail.yahoo.com>
References: <s5hvg6x8dhi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11504.mail.yahoo.com (web11504.mail.yahoo.com [216.136.172.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id AAA04851
	for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2002 00:48:22 +0200
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

It is my understanding that the SNDRV_PCM_FORMAT_IMA_ADPCM format supported by
ALSA is the 32kbps variant of G.726 standard in telephony (vs. propriatory
variants like MS-ADPCM).

I would like to add support for at least the 16kbps variant of G.726 (24kbps
and 40kbps are other possibilities), and wonder if an entirely different format
should be used for each (vs. one G.726 format and PCM subtypes)?

Of course, any hints as to how one adds new PCM formats to ALSA would be
immensely welcomed.

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
