From: John Rigg <ad@sound-man.co.uk>
Subject: Re: multi_pcm poll timeout error
Date: Sat, 3 Dec 2005 21:04:09 +0000
Message-ID: <20051203210409.GA5015@localhost.localdomain>
References: <20051203152318.GA4386@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051203152318.GA4386@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net, Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>, Achim_Kuntz <achim.kuntz@gmx.net>, Lee Revell <rlrevell@joe-job.com>, Frank van de Pol <fvdpol@coil.demon.nl>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 03, 2005 at 03:23:18PM +0000, John Rigg wrote:
> The pcm_multi plugin doesn't work currently with jackd in duplex mode. 
> It's OK for either capture or playback with multi cards, but a poll time out
> occurs in duplex mode. Several users have experienced this problem with
> multiple ice1712 and RME cards.
> After some testing I found the following:
> 
> alsa-lib-1.0.8 works
> alsa-lib-1.0.9rc1 onwards gives poll time out

The following patch comments out the offending code in
alsa-lib-1.0.10/src/pcm/pcm_multi.c and allows jackd to run in duplex
mode with multiple cards.
Obviously this isn't a proper fix (the code must have been added for
a reason) but it's working so far on my system.

John

--- src/pcm/pcm_multi.c.orig	2005-12-03 20:10:58.000000000 +0000
+++ src/pcm/pcm_multi.c	2005-12-03 20:20:56.000000000 +0000
@@ -597,7 +597,7 @@ static int snd_pcm_multi_resume(snd_pcm_
 	return err;
 }
 
-static int snd_pcm_multi_link_fd_failed(snd_pcm_t *pcm, int fd)
+/* static int snd_pcm_multi_link_fd_failed(snd_pcm_t *pcm, int fd)
 {
 	snd_pcm_multi_t *multi = pcm->private_data;
 	unsigned int i;
@@ -638,7 +638,7 @@ static int snd_pcm_multi_unlink(snd_pcm_
 		multi->slaves[i].linked = 0;
 	}
 	return 0;
-}
+} */
 
 static snd_pcm_sframes_t snd_pcm_multi_mmap_commit(snd_pcm_t *pcm,
 						   snd_pcm_uframes_t offset,
@@ -726,9 +726,9 @@ static snd_pcm_fast_ops_t snd_pcm_multi_
 	.rewind = snd_pcm_multi_rewind,
 	.forward = snd_pcm_multi_forward,
 	.resume = snd_pcm_multi_resume,
-	.link_fd = snd_pcm_multi_link_fd,
+//	.link_fd = snd_pcm_multi_link_fd,
 	.link = snd_pcm_generic_link2,
-	.unlink = snd_pcm_multi_unlink,
+//	.unlink = snd_pcm_multi_unlink,
 	.avail_update = snd_pcm_multi_avail_update,
 	.mmap_commit = snd_pcm_multi_mmap_commit,
 	.poll_descriptors_count = snd_pcm_multi_poll_descriptors_count,


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
