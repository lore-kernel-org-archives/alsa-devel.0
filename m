From: Lee Revell <rlrevell@joe-job.com>
Subject: bugtrack down again
Date: Sun, 23 Oct 2005 12:29:05 -0400
Message-ID: <1130084945.11980.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

It seems to be a routing problem.  I cannot traceroute to the site:

rlrevell@mindpipe:~/kernel-source/linux-2.6.13$ traceroute bugtrack.alsa-project.org 
traceroute to bugtrack.alsa-project.org (82.113.61.162), 30 hops max, 38 byte packets
 1  krustophenia.mshome.net (192.168.0.1)  0.473 ms  0.365 ms  0.367 ms
 2  access-66.snjp.dca.net (216.158.24.66)  221.836 ms  147.190 ms  152.372 ms
 3  core-1-fe0.snjp.dca.net (216.158.24.65)  143.382 ms  150.282 ms  152.386 ms
 4  core-1-s0-1-0.sdfc.dca.net (207.245.123.29)  151.278 ms  147.077 ms  151.904 ms
 5  core-5-gig5-2.sdfc.dca.net (207.245.121.52)  154.289 ms  141.365 ms  143.610 ms
 6  f0-3.na01.b003003-1.phl01.atlas.cogentco.com (66.28.12.45)  152.045 ms  146.897 ms  143.458 ms
 7  g2-2.104.core01.phl01.atlas.cogentco.com (66.28.5.37)  144.131 ms  143.987 ms  151.409 ms
 8  p4-0.core01.dca01.atlas.cogentco.com (66.28.4.17)  160.263 ms  155.259 ms  151.922 ms
 9  p2-0.core01.iad01.atlas.cogentco.com (154.54.2.202)  152.369 ms  155.312 ms  160.258 ms
10  ash-bb1-geth7-3-3-0.telia.net (213.248.88.41)  159.539 ms  151.955 ms  152.093 ms
11  nyk-bb2-pos0-3-0.telia.net (213.248.80.137)  159.644 ms  156.338 ms  159.317 ms
12  ldn-bb2-pos6-0-0.telia.net (213.248.65.209)  237.349 ms  3232.248 ms  226.887 ms
13  prs-bb2-pos6-0-0.telia.net (213.248.65.114)  236.511 ms  237.772 ms  239.576 ms
14  ffm-bb2-pos6-0-0.telia.net (213.248.65.118)  247.651 ms  253.045 ms  248.586 ms
15  prag-b2-pos3-0.telia.net (213.248.65.6)  271.853 ms  260.583 ms  255.651 ms
16  dial-telecom-109772-prag-b2.c.telia.net (213.248.96.82)  279.738 ms  258.710 ms  263.648 ms
17  inway-dial.inway.net (212.24.133.93)  271.877 ms  258.241 ms  271.848 ms
18  212.24.132.158 (212.24.132.158)  271.852 ms  269.280 ms  263.804 ms
19  budejovice.inway.net (213.151.70.198)  280.590 ms  280.862 ms  279.801 ms
20  budejovice.inway.net (213.151.70.198)  2504.334 ms !H  1725.700 ms !H *

Lee



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
