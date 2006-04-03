From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001979]: Missing symbols in oss mixer code
Date: Mon, 3 Apr 2006 08:46:04 +0200
Message-ID: <6689d2638e88ad463114877d9c741c51@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D95B5192
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2006 08:46:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1979> 
======================================================================
Reported By:                zx80user
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1979
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-29-2006 23:03 CEST
Last Modified:              04-03-2006 08:46 CEST
======================================================================
Summary:                    Missing symbols in oss mixer code
Description: 
Attempting to load the snd-pcm-oss module and the snd-pcm-mixer modules
fails due to missing symbols.


======================================================================

----------------------------------------------------------------------
 Raymond - 04-02-06 05:26 
----------------------------------------------------------------------
static int aica_pcmvolume_get(snd_kcontrol_t * kcontrol,
			      snd_ctl_elem_value_t * ucontrol)
{	
     struct snd_acia *chip = snd_kcontrol_chip(kcontrol);

Look at ymfpci to study how to implement 64 channels



----------------------------------------------------------------------
 Raymond - 04-03-06 08:46 
----------------------------------------------------------------------
static int __devinit add_aicamixer_controls(struct snd_aica *chip)
{
        int err;
        snd_kcontrol *kctl;
        kctl = snd_ctl_new1(&snd_aica_pcmvolume_control,chip);
        if (!kctl) {
		snd_printk("snd_ctl_new1 failed\n");
                return -ENOMEM;
        };
	err = snd_ctl_add (chip->card, kctl);
        if (err < 0){
		snd_printk("pcmvolume failed\n");
		return err;
	}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-06 23:03 zx80user       New Issue                                    
03-29-06 23:04 zx80user       Issue Monitored: zx80user                    
03-29-06 23:05 zx80user       Note Added: 0009019                          
03-30-06 10:00 Raymond        Note Added: 0009024                          
04-01-06 17:20 Raymond        Note Added: 0009056                          
04-02-06 05:16 Raymond        Note Added: 0009057                          
04-02-06 05:26 Raymond        Note Edited: 0009057                         
04-03-06 08:46 Raymond        Note Added: 0009088                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
