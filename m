From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: What happened with the DEBUG_THREAD define in the asterisk Makefile?
Date: Tue, 23 May 2006 17:28:26 -0300
Message-ID: <4473706A.3020305@instant.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

There's no mention of it in the current SVN version. Version 1.2.7.1 had 
the following:

# Optional debugging parameters
DEBUG_THREADS = #-DDUMP_SCHEDULER #-DDEBUG_SCHEDULER #-DDEBUG_THREADS 
#-DDO_CRASH #-DDETECT_DEADLOCKS

Also, the "howto debug a deadlock" at 
http://www.voip-info.org/wiki/view/Asterisk+debugging seems to be out of 
date -- it doesn't tell what DUMP_SCHEDULER, DEBUG_SCHEDULER and 
DETECT_DEADLOCKS are for, how can they be used, or what caveats are 
associated with enabling them.



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
