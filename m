From: John Rigg <ad@sound-man.co.uk>
Subject: multi_pcm poll timeout error
Date: Sat, 3 Dec 2005 15:23:18 +0000
Message-ID: <20051203152318.GA4386@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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
Cc: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>, Achim_Kuntz <achim.kuntz@gmx.net>, Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

The pcm_multi plugin doesn't work currently with jackd in duplex mode. 
It's OK for either capture or playback with multi cards, but a poll time out
occurs in duplex mode. Several users have experienced this problem with
multiple ice1712 and RME cards.
After some testing I found the following:

alsa-lib-1.0.8 works
alsa-lib-1.0.9rc1 onwards gives poll time out

These were both tested with a recent version of jackd (0.100.7 with
MMAP_COMPLEX patch) on Debian 3.1.
Don't know if it's relevant, but this appears to be about the time 
pcm_generic.h was added.

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
