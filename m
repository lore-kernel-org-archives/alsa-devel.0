From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: new pcm format(s)
Date: Wed, 21 Aug 2002 13:47:40 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020821204740.89113.qmail@web11507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11507.mail.yahoo.com (web11507.mail.yahoo.com [216.136.172.39])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id WAA03541
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2002 22:47:43 +0200
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

I have enquired last Friday about the preferred way for adding formats, since
I'd prefer not follow one option and have someone differ later on. Since I
received no answer, I guess no one as an opinion on the topic and there won't
be any argument. ;)

Anyway, I found out that there's not so much space left for more formats.
Therefore, I added one for G726 and started adding subformats (a field that was
unused until now). This also means that I need to update the function
snd_pcm_format_width() in order to deal with subformats.

Regards,
Guilhem.


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
