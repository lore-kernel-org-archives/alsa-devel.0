From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000221]: ac97 detect fails on xbox/i8x0
Date: Mon, 22 Nov 2004 14:44:59 +0100
Message-ID: <b75d67690df1edec64e9e186239b2969@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 567BE2B4
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2004 14:44:59 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=221> 
======================================================================
Reported By:                chrb
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   221
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-19-2004 11:14 CEST
Last Modified:              11-22-2004 14:44 CET
======================================================================
Summary:                    ac97 detect fails on xbox/i8x0
Description: 
this test for ac97 in ac97_codec.c fails:

       /* test for AC'97 */
        if (!(ac97->scaps & AC97_SCAP_SKIP_AUDIO) && !(ac97->scaps &
AC97_SCAP_AUDIO)) {
                /* test if we can write to the record gain volume register
*/
                snd_ac97_write_cache(ac97, AC97_REC_GAIN, 0x8a06);
                if ((err = snd_ac97_read(ac97, AC97_REC_GAIN)) == 0x8a06)
                        ac97->scaps |= AC97_SCAP_AUDIO;
        }

The test writes to a record gain register but the xbox hardware doesn't
have a record in line, or a hardware mixer. Could this test be made more
generic?

At the moment this block:

        if (!ac97_is_audio(ac97) && !ac97_is_modem(ac97)) {
                if (!(ac97->scaps &
(AC97_SCAP_SKIP_AUDIO|AC97_SCAP_SKIP_MODEM)))
                        snd_printk(KERN_ERR "AC'97 %d access error (not
audio or modem codec)\n", ac97->num);
                snd_ac97_free(ac97);
                return -EACCES;
        }

logs an error and exits. When this is commented out the driver works fine.
Only the ac97 detection seems to be problematic.
======================================================================

----------------------------------------------------------------------
 perex - 09-07-04 18:00 
----------------------------------------------------------------------
The problem is, that all registers except vendor and device IDs are read as
zero. We cannot use a different register. So I added a workaround for xbox
to our CVS.
You should specify the xbox via a module parameter xbox=1.

----------------------------------------------------------------------
 perex - 10-22-04 16:42 
----------------------------------------------------------------------
Use xbox module option to specify xbox workaround.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-04 11:14 chrb           New Issue                                    
04-19-04 15:29 perex          Status                   new => assigned     
04-19-04 15:29 perex          Assigned To               => perex           
04-19-04 15:31 perex          Note Added: 0000857                          
04-19-04 15:31 perex          Note Edited: 0000857                         
04-20-04 14:10 chrb           Note Added: 0000880                          
04-20-04 14:51 perex          Note Added: 0000882                          
04-20-04 16:03 chrb           Note Added: 0000886                          
04-20-04 17:59 eradicator     Issue Monitored: eradicator                    
05-10-04 09:54 kingmob        Issue Monitored: kingmob                     
07-23-04 09:43 chrb           Note Added: 0001468                          
09-07-04 16:44 perex          Note Added: 0001715                          
09-07-04 16:45 perex          Resolution               open => suspended   
09-07-04 16:45 perex          View Status              @0@ => public       
09-07-04 16:45 perex          Description Updated                          
09-07-04 17:11 chrb           Note Added: 0001720                          
09-07-04 18:00 perex          Note Added: 0001723                          
10-22-04 16:42 perex          Status                   assigned => resolved
10-22-04 16:42 perex          Resolution               suspended => fixed  
10-22-04 16:42 perex          Note Added: 0002245                          
11-22-04 14:44 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
