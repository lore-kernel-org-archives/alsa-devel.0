From: Martin Langer <martin-langer@gmx.de>
Subject: Re: highest sample rate on rme32
Date: Tue, 17 Sep 2002 15:05:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020917130548.GF13567@tuba.home>
References: <20020917092404.GE13567@tuba.home>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA00443
	for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2002 15:06:15 +0200
Content-Disposition: inline
In-Reply-To: <20020917092404.GE13567@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2002 at 11:24:04AM +0200, Martin Langer wrote:
> 
> my rme32 hardware can capture signals with 32/44.1/48 kHz and it's working
> fine for 32 and 44.1 signals on input. The funny thing happened with 48kHz
> on input. 
> 

Nevertheless the late Digi32 Pro cards with CS8414 should capture 88.2 and
96kHz data without problems. This patch enables it. 

BTW, the Cirrus CS8414 specs doesn't talk about 64kHz! IMHO the card can only
play and not capture 64kHz samples. 


martin

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rme32.diff"

--- /tmp/rme32.c	Tue Sep 17 14:38:45 2002
+++ alsa-kernel/pci/rme32.c	Tue Sep 17 14:33:12 2002
@@ -859,6 +859,10 @@
 	spin_unlock_irqrestore(&rme32->lock, flags);
 
 	runtime->hw = snd_rme32_capture_spdif_info;
+	if (RME32_PRO_WITH_8414(rme32)) {
+		runtime->hw.rates |= SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000;
+		runtime->hw.rate_max = 96000;
+	}
 
 	snd_pcm_hw_constraint_minmax(runtime,
 				     SNDRV_PCM_HW_PARAM_BUFFER_BYTES,

--k+w/mQv8wyuph6w0--


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
