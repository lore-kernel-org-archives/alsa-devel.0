From: Martin Langer <martin-langer@gmx.de>
Subject: Re: RME96 driver patch
Date: Fri, 10 Jan 2003 15:53:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030110145314.GF20015@tuba.home>
References: <200301051646.47991.torger@ludd.luth.se>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.65.60])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA25551
	for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2003 15:51:35 +0100
Content-Disposition: inline
In-Reply-To: <200301051646.47991.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 05, 2003 at 04:46:47PM +0100, Anders Torger wrote:
> 
> Here is a patch against rme96.c
> 

snd_rme96_capture_spdif_open(snd_pcm_substream_t *substream)

[...]

+       runtime->hw = snd_rme96_capture_spdif_info;
+        if ((rate = snd_rme96_capture_getrate(rme96, &isadat)) > 0) {
+                if (isadat) {
+                        return -EIO;
+                }
+                runtime->hw.rates = snd_rme96_ratecode(rate);
+                runtime->hw.rate_min = rate;
+                runtime->hw.rate_max = rate;
+        }


You were changing sample rates in snd_rme96_capture_spdif_open. Isn't it too
late there? Looks like capturing with wrong sample rates is now possible?
Wouldn't this be better placed in the snd_rme96_capture_hw_params?


martin


-- 
"2b|!2b"


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
