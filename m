From: noreply@alsa-project.org
Subject: [ALSA - lib 0000223]: nested assignments in asserts + subscripts out of range
Date: Fri, 16 Jul 2004 12:59:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105916.29FC426008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A5153244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:59:16 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000223
======================================================================
Reported By:                notting
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Bug ID:                     223
Category:                   ordinary pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             04-20-2004 03:15 CEST
Last Modified:              07-16-2004 12:59 CEST
======================================================================
Summary:                    nested assignments in asserts + subscripts out of range
Description: 
Originally reported at:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=120973

Description of problem:

I just tried to compile Core2 Test2 package alsa-lib-1.0.3a-1

The compiler said

1.

pcm.c(754): warning https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000175: subscript out of range

The source code is

       
snd_interval_set_value(&params->intervals[SND_PCM_HW_PARAM_PERIOD_SIZE],
pcm->period_size);

but

        struct sndrv_interval intervals[SNDRV_PCM_HW_PARAM_LAST_INTERVAL
-
                                       
SNDRV_PCM_HW_PARAM_FIRST_INTERVAL + 1];

I make it that the array has 12 elements, and the source code asks
for element https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000013.

2.

pcm.c(755): warning https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000175: subscript out of range
pcm.c(756): warning https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000175: subscript out of range
pcm.c(757): warning https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000175: subscript out of range
pcm.c(758): warning https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000175: subscript out of range
pcm.c(759): warning https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000175: subscript out of range

Duplicates.

3.

iwffff.c(644): warning https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000175: subscript out of range

The source code is

    gwave->share_id[4] = snd_LE_to_host_32(*(((unsigned int *)wave) +
8/4));

but 

	unsigned int share_id[4];

4.

iwffff.c(880): warning https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000175: subscript out of range
iwffff.c(880): warning https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000175: subscript out of range

Duplicates.

5. 

More deeply, I checked for nested assigments in assert statements. I
found

[dcb@localhost BUILD]$ find . -name \*.c -print | xargs grep -n
"assert.*(.* = "
./alsa-lib-1.0.3a/src/pcm/pcm.c:1799:   assert(handler->type =
SND_ASYNC_HANDLER_PCM);
./alsa-lib-1.0.3a/src/async.c:56:       assert(siginfo->si_code =
SI_SIGIO);
./alsa-lib-1.0.3a/src/control/control.c:539:    assert(handler->type =
SND_ASYNC_HANDLER_CTL);

I'm not saying this is certainly wrong code, I'm only saying it is IMHO
deeply suspicious code.
======================================================================

----------------------------------------------------------------------
 perex - 04-20-2004 15:30 CEST 
----------------------------------------------------------------------
Fixed in CVS. Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-20-04 03:15 notting        New Bug                                      
04-20-04 11:11 perex          Assigned To               => perex           
04-20-04 11:11 perex          Status                   new => assigned     
04-20-04 15:30 perex          Resolution               open => fixed       
04-20-04 15:30 perex          Status                   assigned => resolved
04-20-04 15:30 perex          Bugnote Added: 0000885                       
07-16-04 12:59 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
