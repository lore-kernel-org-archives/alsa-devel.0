From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: under-runs and prepare()
Date: Tue, 10 Sep 2002 09:05:14 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020910160514.63169.qmail@web11507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11507.mail.yahoo.com (web11507.mail.yahoo.com [216.136.172.39])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id SAA28944
	for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2002 18:05:21 +0200
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

Hi all,

I understand that prepare() is used to restart playout or capture from a known
state in the driver, and wonder if it is OK to have it block until buffers
being currently played out have completed?

This came up because our app is experiencing -EPIPE quite often, most likely
because real-time audio is being played out immediately without the least
buffering by the app. Any advice is most welcome regarding this issue.

Guilhem.


__________________________________________________
Yahoo! - We Remember
9-11: A tribute to the more than 3,000 lives lost
http://dir.remember.yahoo.com/tribute


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
