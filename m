From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: [PATCH] asihpi unbalanced spinlocks
Date: Wed, 5 Apr 2006 15:58:12 +1200
Message-ID: <200604051558.12850.linux@blennerhassett.gen.nz>
References: <s5hmzfl9cql.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UB0MEcr7TiHjdKJ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzfl9cql.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, "Brignoli, Delio" <dbrignoli@audioscience.com>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_UB0MEcr7TiHjdKJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 21 Mar 2006 06:45, Takashi Iwai wrote:
> Hi,
>
> if someone has patches intended for merging to ALSA tree, please
> submit them ASAP.

Fix unbalanced spin_lock/unlocks
(Note we have huge changes in the pipeline,  but lets get this hopefully 
uncontroversial fix in first)

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

--- asihpi_orig.c	2006-04-05 15:44:17.000000000 +1200
+++ asihpi.c	2006-04-05 15:45:49.000000000 +1200
@@ -1825,6 +1825,7 @@
 				    &wSourceType, &wSourceIndex);
 	HPI_Multiplexer_SetSource(phSubSys, hControl, wSourceType,
 				  wSourceIndex);
+	spin_unlock_irqrestore(&asihpi->mixer_lock, flags);
 	return change;
 }
 
@@ -1902,6 +1903,7 @@
 
 	HPI_ChannelModeSet(phSubSys, hControl,
 			   ucontrol->value.enumerated.item[0] + 1);
+	spin_unlock_irqrestore(&asihpi->mixer_lock, flags);
 	return change;
 }
 
@@ -1979,6 +1981,7 @@
 
 	HPI_SampleClock_SetSource(phSubSys, hControl,
 				  ucontrol->value.enumerated.item[0] + 1);
+	spin_unlock_irqrestore(&asihpi->mixer_lock, flags);
 	return change;
 }
 

--Boundary-00=_UB0MEcr7TiHjdKJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="asihpi.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asihpi.c.patch"

--- asihpi_orig.c	2006-04-05 15:44:17.000000000 +1200
+++ asihpi.c	2006-04-05 15:45:49.000000000 +1200
@@ -1825,6 +1825,7 @@
 				    &wSourceType, &wSourceIndex);
 	HPI_Multiplexer_SetSource(phSubSys, hControl, wSourceType,
 				  wSourceIndex);
+	spin_unlock_irqrestore(&asihpi->mixer_lock, flags);
 	return change;
 }
 
@@ -1902,6 +1903,7 @@
 
 	HPI_ChannelModeSet(phSubSys, hControl,
 			   ucontrol->value.enumerated.item[0] + 1);
+	spin_unlock_irqrestore(&asihpi->mixer_lock, flags);
 	return change;
 }
 
@@ -1979,6 +1981,7 @@
 
 	HPI_SampleClock_SetSource(phSubSys, hControl,
 				  ucontrol->value.enumerated.item[0] + 1);
+	spin_unlock_irqrestore(&asihpi->mixer_lock, flags);
 	return change;
 }
 

--Boundary-00=_UB0MEcr7TiHjdKJ--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
