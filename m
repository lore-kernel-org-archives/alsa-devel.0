From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000665]: Build failure in /usr/src/alsa/alsa-driver/acore/init.c
Date: Tue, 23 Nov 2004 17:44:05 +0100
Message-ID: <c31a30e74a08b9c3743634c68f072b34@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9E3812C0
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2004 17:44:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=665> 
======================================================================
Reported By:                ronis
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   665
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-22-2004 19:31 CET
Last Modified:              11-23-2004 17:44 CET
======================================================================
Summary:                    Build failure in
/usr/src/alsa/alsa-driver/acore/init.c
Description: 
There's an unterminated #ifdef in init.c.  (PM_CONFIG or  more likely
CONFIG_PCI).  Here's the log:

  CC [M]  /usr/src/alsa/alsa-driver/acore/init.o
/usr/src/alsa/alsa-driver/acore/init.c:680:1: unterminated #ifdef
make[4]: *** [/usr/src/alsa/alsa-driver/acore/init.o] Error 1
make[3]: *** [/usr/src/alsa/alsa-driver/acore] Error 2
make[2]: *** [_module_/usr/src/alsa/alsa-driver] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.9'
make: *** [compile] Error 2

Adding an extra #endif at the end of the file fixes things, although, I'm
not 100% sure that this is the right place  top put things.

(BTW, I'm now running 2.6.9 but didn't have a chance to midify my
profile)


======================================================================

----------------------------------------------------------------------
 ronis - 11-23-04 16:52 
----------------------------------------------------------------------
I just tried the latest CVS and got the same result.   I looked a little
further and noticed that part of the build patches various files, and that
some of these patches failed; specifically,

./acore/seq/seq.c.rej
./acore/info.c.rej
./acore/pcm_native.c.rej
./acore/init.c.rej
./acore/sound.c.rej
./pci/bt87x.c.rej
./pcmcia/pdaudiocf/pdaudiocf.c.rej
./pcmcia/vx/vxpocket.c.rej
./usb/usbaudio.c.rej

(others worked, albeit with various offets).  Here are the rejected
patches from init.c:

***************
*** 791,797 ****
  		return 0;
  	/* FIXME: correct state value? */
  	err = card->pm_suspend(card, 0);
  	pci_save_state(dev);
  	return err;
  }
  
--- 825,835 ----
  		return 0;
  	/* FIXME: correct state value? */
  	err = card->pm_suspend(card, 0);
+ #ifndef CONFIG_HAVE_PCI_SAVED_CONFIG
+ 	pci_save_state(dev, &pci_saved_config[card->number][0]);
+ #elif LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
  	pci_save_state(dev);
+ #endif
  	return err;
  }
  
***************
*** 803,812 ****
  	if (card->power_state == SNDRV_CTL_POWER_D0)
  		return 0;
  	/* restore the PCI config space */
  	pci_restore_state(dev);
  	/* FIXME: correct state value? */
  	return card->pm_resume(card, 0);
  }
- #endif
  
  #endif /* CONFIG_PM */
--- 841,858 ----
  	if (card->power_state == SNDRV_CTL_POWER_D0)
  		return 0;
  	/* restore the PCI config space */
+ #ifndef CONFIG_HAVE_PCI_SAVED_CONFIG
+ 	pci_restore_state(dev, &pci_saved_config[card->number][0]);
+ #elif defined(CONFIG_HAVE_NEW_PCI_SAVE_STATE)
  	pci_restore_state(dev);
+ #else
+  	pci_restore_state(dev, dev->saved_config_space);
+ #endif
  	/* FIXME: correct state value? */
  	return card->pm_resume(card, 0);
  }
+ 
+ #endif /* PCI_OLD_SUSPEND */
+ #endif /* CONFIG_PCI */
  
  #endif /* CONFIG_PM */

I think my missing #endif is the /*CONFIG_PCI*/ one at the bottom, but
clearly much more is broken.

Something is wrong.  I've looked in acore/init.c for lines like

***************pci_save_state(dev, &pci_saved_config[card->number][0]);
}
*** 791,797 ****
  		return 0;
  	/* FIXME: correct state value? */
  	err = card->pm_suspend(card, 0);
  	pci_save_state(dev);
  	return err;
 
They aren't there; moreover, pci_save_state now seems to take 2 arguments;
e.g.,

pci_save_state(dev, &pci_saved_config[card->number][0]);  

As I mentioned in my first report, I'm running 2.6.9.  Is this an issue?

David


(from line  801)}

----------------------------------------------------------------------
 tiwai - 11-23-04 17:44 
----------------------------------------------------------------------
Did you update both alsa-driver and alsa-kernel trees?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-04 19:31 ronis          New Issue                                    
11-23-04 15:59 tiwai          Note Added: 0002517                          
11-23-04 16:52 ronis          Note Added: 0002523                          
11-23-04 17:44 tiwai          Note Added: 0002524                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
