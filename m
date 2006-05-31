From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001226]: Ego Sys NEON
Date: Wed, 31 May 2006 19:23:29 +0200
Message-ID: <b5a5986ed026533d9fc44744ce9a660a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1D609140
	for <alsa-devel@alsa-project.org>;
	Wed, 31 May 2006 19:23:30 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1226> 
======================================================================
Reported By:                nictuku
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1226
Category:                   USB - usb-audio
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Slackware Current
Kernel Version:             2.4
======================================================================
Date Submitted:             07-01-2005 21:21 CEST
Last Modified:              05-31-2006 19:23 CEST
======================================================================
Summary:                    Ego Sys NEON
Description: 
hi, i have a ESI NeON (
http://www.esi-pro.com/viewProduct.php?pid=42&page=1 ) i've tryed to make
it work with alsa with no success, but strangely on the oss the 24-bit
audio interface works. I just send this bug report to know if there's a
way to make it work or if it's planned to put support on this hardware. if
you need to test it feel free to contactme (nictuku@gmail.com)
thanx
======================================================================

----------------------------------------------------------------------
 rzr - 05-27-06 16:05 
----------------------------------------------------------------------
Curently, neon is not fully supported by "snd-usb-audio" because : 
* the sound output goes to garbage , a few minutes after playing music 
* there are at least 2 capture audio chanels and alsamixer does show only
one, (I want to use the HiZ input to plug a guitar).

I attached my current /proc/asound/NeON if it helps...
I'll also drop notes at http://rzr.online.fr/q/MIDI

Find me online for more details



----------------------------------------------------------------------
 Clemens Ladisch - 05-31-06 19:23 
----------------------------------------------------------------------
What does "garbage" mean? Is there some noise, or is the original data
completely lost?
Does it occur at 44.1 kHz, at 48 kHz, or both?
Does it work again if you restart the output?

The device does not define a mixer control for input switching.  I guess
this would be done with the HID interface.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-05 21:21 nictuku        New Issue                                    
07-01-05 21:21 nictuku        Distribution              => Slackware Current
07-01-05 21:21 nictuku        Kernel Version            => 2.4             
07-04-05 09:23 Clemens LadischNote Added: 0005382                          
07-06-05 23:04 nictuku        Issue Monitored: nictuku                     
07-06-05 23:06 nictuku        Note Added: 0005395                          
07-06-05 23:09 nictuku        Issue End Monitor: nictuku                    
07-23-05 00:32 nictuku        Note Added: 0005551                          
07-25-05 11:05 Clemens LadischNote Added: 0005562                          
08-04-05 18:09 nictuku        Note Added: 0005651                          
05-27-06 03:04 rzr            File Added: neon-usb_0a92_00c1.zip                
   
05-27-06 03:06 rzr            Note Added: 0009981                          
05-27-06 15:48 rzr            Note Edited: 0009981                         
05-27-06 16:05 rzr            Note Edited: 0009981                         
05-31-06 19:23 Clemens LadischNote Added: 0010025                          
======================================================================
