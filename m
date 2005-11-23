From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001571]: Segfaults when trying to specify the preamble values (iec958 plugin)
Date: Wed, 23 Nov 2005 17:45:13 +0100
Message-ID: <526677800cd6f3ab333348457ddf83ce@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2F771176
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 17:45:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1571> 
======================================================================
Reported By:                nboullis
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1571
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-17-2005 01:51 CET
Last Modified:              11-23-2005 17:45 CET
======================================================================
Summary:                    Segfaults when trying to specify the preamble values
(iec958 plugin)
Description: 
When I try to specify the preamble values for the iec958 plugin (see the
attached .asoundrc file for an example), I get segfaults with all
applications that try to use the corresponding device. If I simply comment
out the 3 preamble lines, the application runs fine (well, not with the
null output, but with a real S/PDIF device) but I get no sound since I'm
not using the correct preamble values.

(This is with version 1.0.10.)

Here is a backtrace I got with valgrind (using xmms as the application):

==15761== 
==15761== Thread 5:
==15761== Invalid read of size 4
==15761==    at 0x1CADD3F7: snd_config_iterator_first (conf.c:3146)
==15761==    by 0x1CB373BB: _snd_pcm_iec958_open (pcm_iec958.c:623)
==15761==    by 0x1CAF9CB6: snd_pcm_open_conf (pcm.c:2070)
==15761==    by 0x1CAFA61A: snd_pcm_open_slave (pcm.c:2187)
==15761==    by 0x1CB1A32C: _snd_pcm_plug_open (pcm_plug.c:1140)
==15761==    by 0x1CAF9CB6: snd_pcm_open_conf (pcm.c:2070)
==15761==    by 0x1CAFA2BD: snd_pcm_open_noupdate (pcm.c:2102)
==15761==    by 0x1CAFA376: snd_pcm_open (pcm.c:2123)
==15761==    by 0x1CAB0E18: (within /usr/lib/xmms/Output/libALSA.so)
==15761==    by 0x1CAB09D1: alsa_open (in
/usr/lib/xmms/Output/libALSA.so)
==15761==    by 0x1CBB0469: (within /usr/lib/xmms/Input/libmpg123.so)
==15761==    by 0x1BAFFB62: start_thread (in /lib/tls/libpthread-0.60.so)
==15761==  Address 0x4 is not stack'd, malloc'd or (recently) free'd

Hope this helps.
======================================================================

----------------------------------------------------------------------
 nboullis - 11-19-05 01:35 
----------------------------------------------------------------------
As asked by Takashi Iwai, I just re-did the same experiment within gdb;
here is the backtrace:

#0  0xb6f5b0b7 in snd_config_iterator_first () from
/usr/lib/libasound.so.2
#1  0xb6fb23dc in _snd_pcm_iec958_open () from /usr/lib/libasound.so.2
#2  0xb6f75a37 in snd_async_handler_get_pcm () from
/usr/lib/libasound.so.2
#3  0xb6f763ab in snd_pcm_open_slave () from /usr/lib/libasound.so.2
#4  0xb6f960f5 in _snd_pcm_plug_open () from /usr/lib/libasound.so.2
#5  0xb6f75a37 in snd_async_handler_get_pcm () from
/usr/lib/libasound.so.2
#6  0xb6f7604e in snd_async_handler_get_pcm () from
/usr/lib/libasound.so.2
#7  0xb6f76107 in snd_pcm_open () from /usr/lib/libasound.so.2
#8  0xb7001e19 in alsa_open () from /usr/lib/xmms/Output/libALSA.so
#9  0xb70019d2 in alsa_open () from /usr/lib/xmms/Output/libALSA.so
#10 0xb6ebe46a in get_iplugin_info () from
/usr/lib/xmms/Input/libmpg123.so
#11 0xb7d8fb63 in start_thread () from /lib/tls/libpthread.so.0
#12 0xb7bfa18a in clone () from /lib/tls/libc.so.6

(I have lost my 1.0.10 build, so this is with debian's 1.0.9-3 (with my
preamble patch applied).

If it is usefull, I can do it again with a clean 1.0.10 ou CVS HEAD build.

----------------------------------------------------------------------
 tiwai - 11-23-05 17:45 
----------------------------------------------------------------------
OK it's a typo.  The patch is attached.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-05 01:51 nboullis       New Issue                                    
11-17-05 01:51 nboullis       File Added: .asoundrc                        
11-17-05 01:53 nboullis       Issue Monitored: nboullis                    
11-19-05 01:35 nboullis       Note Added: 0006760                          
11-23-05 17:45 tiwai          Note Added: 0006820                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
