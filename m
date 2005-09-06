From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000322]: oops while removing au8810
Date: Tue, 6 Sep 2005 14:58:20 +0200
Message-ID: <84dcb75a66ff7e41ebd137cc97fb9453@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2EA51195
	for <alsa-devel@alsa-project.org>; Tue,  6 Sep 2005 14:58:20 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=322> 
======================================================================
Reported By:                aris
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   322
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               conectiva linux 10 snapshot with custom kernel
Kernel Version:             2.6.7-rc2
======================================================================
Date Submitted:             06-02-2004 13:24 CEST
Last Modified:              09-06-2005 14:58 CEST
======================================================================
Summary:                    oops while removing au8810
Description: 
after getting an error on activating IRQ (not sure if this board is
working)
and trying to remove module I get an oops. I tryed to dig in but couldn't
find where exactly it is happening.
the IRQ error message:
PCI: Found IRQ 11 for device 0000:00:0b.0
PCI: Sharing IRQ 11 with 0000:00:01.1
Vortex: init.... <6>done.
vortex: IRQ reg error

======================================================================

----------------------------------------------------------------------
 Raymond - 09-06-05 14:34 
----------------------------------------------------------------------
It seem that the au8810 driver has a bug if au8810 has a quad codec.

Are your card SQ1500 ? 

lspci -vvn



----------------------------------------------------------------------
 Raymond - 09-06-05 14:58 
----------------------------------------------------------------------
au8830.h

#define VORTEX_CODEC_EN 0x29190
#define		EN_AUDIO0		0x00000300          <- front channels
#define		EN_MODEM		0x00000c00
#define		EN_AUDIO1		0x00003000          <- rear channels
#define		EN_SPORT		0x00030000
#define		EN_SPDIF		0x000c0000
#define		EN_CODEC		(EN_AUDIO1 | EN_AUDIO0)

au8810.h
#define VORTEX_CODEC_CTRL	0x29184
#define VORTEX_CODEC_EN		0x29190
#define		EN_CODEC0	0x00000300
#define 	EN_AC98		0x00000c00 /* Modem AC98 slots. */
#define		EN_CODEC1	0x00003000
#define		EN_CODEC	(EN_CODEC0 | EN_CODEC1)
#define		EN_SPORT	0x00030000
#define		EN_SPDIF	0x000c0000

au88x0_core.c

static void vortex_codec_init(vortex_t * vortex)
{
...
	/* Enable codec channels 0 and 1. */
	hwwrite(vortex->mmio, VORTEX_CODEC_EN,
		hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_CODEC);

}


static snd_pcm_hardware_t snd_vortex_playback_hw_adb = {
...
#ifdef CHIP_AU8830
	.channels_max = 4,
#else
	.channels_max = 2,
#endif
...
}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-04 13:24 aris           New Issue                                    
06-02-04 13:24 aris           Distribution              => conectiva linux 10
snapshot with custom kernel
06-02-04 13:24 aris           Kernel Version            => 2.6.7-rc2       
06-03-04 17:51 mjander        Note Added: 0001289                          
06-03-04 17:51 mjander        Note Added: 0001290                          
06-03-04 17:52 mjander        File Added: aureal-quadfix.patch                  
 
04-12-05 20:45 alien999999999 Issue Monitored: alien999999999                   

08-30-05 12:22 jdthood        Note Added: 0005973                          
09-06-05 11:03 Raymond        Note Added: 0006043                          
09-06-05 14:12 aris           Note Added: 0006044                          
09-06-05 14:32 Raymond        Note Added: 0006045                          
09-06-05 14:34 Raymond        Note Edited: 0006045                         
09-06-05 14:58 Raymond        Note Added: 0006046                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
