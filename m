From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000221]: ac97 detect fails on xbox/i8x0
Date: Wed, 8 Dec 2004 12:21:26 +0100
Message-ID: <9ebe385869b09b18beed7fde66f70213@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A6E0238C
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2004 12:21:26 +0100 (MET)
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


A new RELATIONSHIP has been added to the following issue.
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000714 On newer xboxes, the xbox=1 workaround ...
======================================================================

----------------------------------------------------------------------
 perex - 04-19-04 15:31 
----------------------------------------------------------------------
Could you send me output from /proc/asound/card0/codec97#0/ac97#0-0+regs ?

edited on: 04-19-04 15:31

----------------------------------------------------------------------
 chrb - 04-20-04 14:10 
----------------------------------------------------------------------
0:00 = 0000
0:02 = 0000
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 0000
0:0c = 0000
0:0e = 0000
0:10 = 0000
0:12 = 0000
0:14 = 0000
0:16 = 0000
0:18 = 0000
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 0000
0:28 = 0000
0:2a = 0000
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 574d
0:7e = 4c09

----------------------------------------------------------------------
 perex - 04-20-04 14:51 
----------------------------------------------------------------------
It's not ok. Registers should not be zero.
Is something in /var/log/messages related to AC'97?
What is in file /proc/asound/card0/intel8x0 ?

----------------------------------------------------------------------
 chrb - 04-20-04 16:03 
----------------------------------------------------------------------
On /etc/init.d/alsasound start I get:

Apr 20 14:00:59 Pro kernel: PCI: Setting latency timer of device 00:06.0
to 64
Apr 20 14:01:01 Pro kernel: ALSA
../../alsa-kernel/pci/ac97/ac97_codec.c:1759: AC'97 0 does not respond -
RESET
Apr 20 14:01:01 Pro kernel: ALSA
../../alsa-kernel/pci/ac97/ac97_codec.c:1837: AC'97 0 analog subsections
not ready
Apr 20 14:01:01 Pro kernel: intel8x0_measure_ac97_clock: measured 49814
usecs
Apr 20 14:01:01 Pro kernel: intel8x0: clocking to 48000

Those are the only logged messages from alsa. 

/proc/asound/card0/intel8x0 contains:
Intel8x0

Global control        : 0x00000002
Global status         : 0x00300100
AC'97 codecs ready    : primary

----------------------------------------------------------------------
 chrb - 07-23-04 09:43 
----------------------------------------------------------------------
Reminder sent to perex

Months go by... ping. Surely theres an audio playback register that we
could write to test?

----------------------------------------------------------------------
 perex - 09-07-04 16:44 
----------------------------------------------------------------------
Sorry, no clue. It seems that another special initialization must be done
before AC'97 codec can be used on Xbox.

----------------------------------------------------------------------
 chrb - 09-07-04 17:11 
----------------------------------------------------------------------
Perhaps I did not make it clear. The driver works fine on the xbox. You
just need to change ac97 detection to not use REC_GAIN_REGISTER, as xbox
does not have this register. Any of normal registers would do.

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
12-08-04 12:21 tiwai          Relationship added       related to 0000714  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
