From: noreply@alsa-project.org
Subject: [ALSA - lib 0000150]: Clicking when trying to use dmix on ice1724 card
Date: Fri, 16 Jul 2004 14:29:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716122952.866582C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 01ED6244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:29:53 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000150
======================================================================
Reported By:                cyr
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Bug ID:                     150
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             03-23-2004 03:48 CET
Last Modified:              07-16-2004 14:29 CEST
======================================================================
Summary:                    Clicking when trying to use dmix on ice1724 card
Description: 
When I try to use the dmix feature on my ice1724 card I get constant
clicking sounds. I've tried different configurations (period_size,
buffer_size etc). The only difference seems to be that the frequency of
the clicks depend on period_size. It  may be one click for each
"period"...   I'm not sure if this is somehow hardware specific since I
don't have any other hardware to test it on. 

This is using v1.0.3b
======================================================================

----------------------------------------------------------------------
 cyr - 04-04-2004 03:20 CEST 
----------------------------------------------------------------------
I recorded a sound clip to illustrate the problem. It's not bit-perfect
since it was recorded using analog loopback but it may help.

http://area26.no-ip.org/linked/cardtest.wav

The dmix settings used were:

    type dmix
    ipc_key 1024       
    slave {
        pcm "hw:0,0"     
        period_time 0
        period_size 1024 
        buffer_size 8192 
    }

----------------------------------------------------------------------
 pfalkner - 04-04-2004 23:45 CEST 
----------------------------------------------------------------------
I'm experiencing the same issue with my ens1370, but I've noticed it only
occurs with 48000Hz sounds; 44100Hz and lower seem ok.  I have my dmix's
rate parameter set to 44100, but the clicking exists no matter what that
is set to, even 48000.

As reported above, frequency of clicks depends on period_size.

This is with 1.0.4, previously using 1.0.2 which worked fine.

----------------------------------------------------------------------
 username - 04-24-2004 17:05 CEST 
----------------------------------------------------------------------
I'm having this exact same problem (ice1724 chip) with

- kernel 2.6.5 w/included ALSA
- kernel 2.6.6rc2 w/included ALSA
- kernel 2.6.5 w/external alsa 1.0.4
- kernel 2.6.5rc2 w/external alsa 1.0.4
(haven't tried other/older combos for lack of time)

The card works flawlessly when using:

  pcm.native {
    type plug
    slave {
        pcm "hw:0,0"
        format S32_LE
        rate 48000
    }
  }

but not when using a dmix device (using the same parameters as above) --
even when only one app is playing sound.

Like the original reporter, I've also tried various buffer_sizes, etc. The
only thing I noted was that the problem dimished a lot when the
buffer_size was a multiple of the of the sample rate (but it was still
quite audible and annoying). Increasing the buffer_size generally helps,
but doesn't seem to eliminate the problem.

Interestingly, the problem also occurs with the "dshare" device (even
though only one app can play at a time); so either they share a bug, or
something else is going wrong with the interaction between these plug-ins
and the lower-level plugins.

HTH.

----------------------------------------------------------------------
 ceno - 05-15-2004 11:14 CEST 
----------------------------------------------------------------------
See also bug 0000277 (include's a fix), sorry missed this bug report.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-23-04 03:48 cyr            New Bug                                      
03-23-04 19:02 perex          Category                 general => pcm - digital audio
03-23-04 19:02 perex          Assigned To               => perex           
03-23-04 19:02 perex          Status                   new => assigned     
04-04-04 03:20 cyr            Bugnote Added: 0000740                       
04-04-04 23:45 pfalkner       Bugnote Added: 0000750                       
04-04-04 23:46 pfalkner       Bug Monitored: pfalkner                      
04-24-04 17:05 username       Bugnote Added: 0000925                       
04-24-04 17:11 username       Bug Monitored: username                      
05-15-04 11:14 ceno           Bugnote Added: 0001122                       
05-24-04 19:49 perex          duplicate_id             0 => 277            
05-24-04 19:49 perex          Resolution               open => duplicate   
05-24-04 19:49 perex          Status                   assigned => resolved
07-16-04 14:29 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
