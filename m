From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: updated patch for period_size constraint
Date: Tue, 10 Sep 2002 08:29:59 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020910152959.91672.qmail@web11503.mail.yahoo.com>
References: <Pine.LNX.4.21.0209091619550.10104-100000@gate.perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-179275162-1031671799=:89300"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11503.mail.yahoo.com (web11503.mail.yahoo.com [216.136.172.35])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id RAA28335
	for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2002 17:30:11 +0200
In-Reply-To: <Pine.LNX.4.21.0209091619550.10104-100000@gate.perex.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0-179275162-1031671799=:89300
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I modified my previous patch for supporting a period_size (rather than
period_bytes) constraint with Takashi's suggestion that the fields be non-zero
for either constraint to kick in. See file in attachment. It has worked fine on
my hardware for the past few days.

Guilhem.


__________________________________________________
Yahoo! - We Remember
9-11: A tribute to the more than 3,000 lives lost
http://dir.remember.yahoo.com/tribute
--0-179275162-1031671799=:89300
Content-Type: text/plain; name="alsa-driver-rc3.diff"
Content-Description: alsa-driver-rc3.diff
Content-Disposition: inline; filename="alsa-driver-rc3.diff"

--- alsa-kernel/include_orig/pcm.h	Tue Aug  6 03:28:27 2002
+++ alsa-kernel/include/pcm.h	Wed Sep  4 13:32:19 2002
@@ -75,6 +75,8 @@
 	unsigned int channels_min;	/* min channels */
 	unsigned int channels_max;	/* max channels */
 	size_t buffer_bytes_max;	/* max buffer size */
+	size_t period_size_min;		/* min size size (in samples) */
+	size_t period_size_max;		/* max size size (in samples) */
 	size_t period_bytes_min;	/* min period size */
 	size_t period_bytes_max;	/* max period size */
 	unsigned int periods_min;	/* min # of periods */
--- alsa-kernel/core_orig/pcm_native.c	Tue Aug 13 12:13:34 2002
+++ alsa-kernel/core/pcm_native.c	Fri Sep  6 12:52:44 2002
@@ -1628,9 +1628,17 @@
 					   hw->rate_min, hw->rate_max);
 	snd_assert(err >= 0, return -EINVAL);
 
+	if (hw->period_size_min || hw->period_size_max) {
+		err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+						   hw->period_size_min, hw->period_size_max);
+		snd_assert(err >= 0, return -EINVAL);
+	}
+
+	if (hw->period_bytes_min || hw->period_bytes_max) {
 	err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 					   hw->period_bytes_min, hw->period_bytes_max);
 	snd_assert(err >= 0, return -EINVAL);
+	}
 
 	err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIODS,
 					   hw->periods_min, hw->periods_max);

--0-179275162-1031671799=:89300--


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
