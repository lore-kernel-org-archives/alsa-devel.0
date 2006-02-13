From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Can anyone help?
Date: Sun, 12 Feb 2006 19:28:28 -0500
Message-ID: <1139790508.2739.24.camel@mindpipe>
References: <1139526455.9296.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 41FF9AA
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 01:28:29 +0100 (MET)
In-Reply-To: <1139526455.9296.5.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-02-09 at 23:07 +0000, Adrian McMenamin wrote:
> I cannot get aplay to work on my architecture (afaics anyway) eg
> 
> / # aplay -D hw:0,0 /bin/busybox
> aplay: pcm.c: 2119: snd_pcm_open: Assertion `pcmp && name' failed.
> Aborted
> 

Try this patch:

--- /home/rlrevell/cvs/alsa/alsa-lib/src/pcm/pcm.c~	2006-01-12 20:00:54.000000000 -0500
+++ /home/rlrevell/cvs/alsa/alsa-lib/src/pcm/pcm.c	2006-02-12 19:27:08.000000000 -0500
@@ -2124,7 +2124,8 @@
 		 snd_pcm_stream_t stream, int mode)
 {
 	int err;
-	assert(pcmp && name);
+	assert(pcmp);
+        assert(name);
 	err = snd_config_update();
 	if (err < 0)
 		return err;

to see if it's the PCM handle or name that's not set.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
