From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: bugtrack down again
Date: Mon, 24 Oct 2005 14:50:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0510241447070.10314@tm8103-a.perex-int.cz>
References: <1130084945.11980.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1130084945.11980.14.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 23 Oct 2005, Lee Revell wrote:

> It seems to be a routing problem.  I cannot traceroute to the site:
> 
> rlrevell@mindpipe:~/kernel-source/linux-2.6.13$ traceroute bugtrack.alsa-project.org 
> traceroute to bugtrack.alsa-project.org (82.113.61.162), 30 hops max, 38 byte packets

Sorry my fault. It's not routing problem but DNS problem. The actual IP 
for the bugtrack host is 85.132.177.35 , but the secondary DNS servers are 
not synced (because also the master DNS server moved to new IP). I asked 
the server administrators to update their configuration files, so 
hopefully, the problem will be fixed soon.
 
					Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
