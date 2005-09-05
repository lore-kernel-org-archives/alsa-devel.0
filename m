From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001372]: Intel HD audio module timeout and xine audio output abnormal
Date: Mon, 5 Sep 2005 05:41:21 +0200
Message-ID: <2b6340e44710f5f06b277b99026f6086@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F409818C
	for <alsa-devel@alsa-project.org>; Mon,  5 Sep 2005 05:41:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1372> 
======================================================================
Reported By:                KamMing
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1372
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.13-rc6
======================================================================
Date Submitted:             08-26-2005 05:10 CEST
Last Modified:              09-05-2005 05:41 CEST
======================================================================
Summary:                    Intel HD audio module timeout and xine audio output
abnormal
Description: 
As loading snd-hd-intel.ko , the system shows following message
ceaselessly:

" azx_get_response timeout "


After replace function azx_get_response() by :
{
        azx_t *chip = codec->bus->private_data;
        unsigned int wp, corbwp;
        int timeout = 2;

        corbwp = azx_readb(chip, CORBWP);
        while ((wp = azx_readb(chip, RIRBWP)) != corbwp) {
                if (! --timeout) {
                        snd_printk(KERN_ERR "azx_get_response
timeout\n");
                        break;
                }
                msleep(1);
        }
        wp <<= 1; /* an RIRB entry is 8-bytes */
        /* read the low value only */
        return le32_to_cpu(chip->rirb.buf[wp]);
} 

timeout problem fixed. This code comes from alsa-1.0.8a which is modified
by Intel and can be downloaded from Intel website.

After fixed timeout problem, xine's audio output abnormal. As playing
VCD/DVD , the audio output just repeat a piece of sound ceaslessly. And
sometimes the xine hang with a few minutes. I encountered this problem on
alsa-1.0.8a and alsa-1.0.10rc1(replaced function azx_get_response()). 
======================================================================

----------------------------------------------------------------------
 KamMing - 09-05-05 05:41 
----------------------------------------------------------------------
This problem has been solved.  Sound playback normally as enable IO-APIC
supporting in kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-26-05 05:10 KamMing        New Issue                                    
08-26-05 05:10 KamMing        Kernel Version            => 2.6.13-rc6      
08-28-05 08:56 lazyfai        Issue Monitored: lazyfai                     
08-30-05 04:19 KamMing        Issue Monitored: KamMing                     
09-05-05 05:41 KamMing        Note Added: 0006039                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
