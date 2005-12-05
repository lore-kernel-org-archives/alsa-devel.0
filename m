From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001554]: LADSPA plugin do not work in case of policy NONE. LADSPA plugin usage is not documented propertly.
Date: Mon, 5 Dec 2005 14:46:05 +0100
Message-ID: <a5226ea1e70cc88cf67a10e5121a1c20@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F057416D
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2005 14:46:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1554> 
======================================================================
Reported By:                gena2x
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1554
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-13-2005 21:04 CET
Last Modified:              12-05-2005 14:46 CET
======================================================================
Summary:                    LADSPA plugin do not work in case of policy NONE.
LADSPA plugin usage is not documented propertly.
Description: 
This bug make impossible to work with single channel of multichannel
frame.
So I do not find another clear way to filter high frequences out of my
subwoofer.


======================================================================

----------------------------------------------------------------------
 perex - 11-22-05 09:01 
----------------------------------------------------------------------
From: Gennadiy Kupava <gena2x@mail.spbnit.ru>

I have modem dial-up at home (Just afraid to connect to something more
speedy, I know that Internet will eat 90% of my time). At work I have no
access to protocols other than http and ftp.
So I spend quarter of day to suck sown alsa from cvs (of course playing
chess).
Then I got FTBFS, my mood was broken by following message:
gcc -shared  .libs/conf.o .libs/confmisc.o .libs/input.o .libs/output.o
.libs/async.o .libs/error.o .libs/dlmisc.o .libs/socket.o
.libs/shmarea.o .libs/userfile.o .libs/names.o -Wl,--whole-archive
control/.libs/libcontrol.a mixer/.libs/libmixer.a pcm/.libs/libpcm.a
rawmidi/.libs/librawmidi.a timer/.libs/libtimer.a hwdep/.libs/libhwdep.a
seq/.libs/libseq.a instr/.libs/libinstr.a compat/.libs/libcompat.a
alisp/.libs/libalisp.a -Wl,--no-whole-archive  -lm -ldl -lpthread
-Wl,-soname -Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
/usr/bin/ld: .libs/libasound.so.2.0.0: undefined versioned symbol name
snd_pcm_hw_params_get_buffer_size_max@ALSA_0.9
/usr/bin/ld: failed to set dynamic section sizes: Bad value
I know only bit about versioned symbols, so this need futher
investigation to just compile alsa-lib.
I found function snd_pcm_hw_params_get_buffer_size_max. It is in some
maroses. Then I try to go in simple way - apply debian patches for
1.0.9-1.0.10rc. That was wrong way... I'll beat it at this weekend.

I have another free saturday(at least), so plan to spend it on polishing
patch (there _is_ thing to polish - it is written to just work) (if get
rid of compile error).

Also I think, that there is nothing need to speed up. So... Just do not
think that I will leave patch which can give great pleasure of be merged
to kernel.

So, i`ll write to BTS at/just after next weekend about progress, ok?

Hr.. I read my post and find that due to my English I use word 'I' too
many times...

----------------------------------------------------------------------
 perex - 12-05-05 14:46 
----------------------------------------------------------------------
gena2x: any progress?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-13-05 21:04 gena2x         New Issue                                    
11-13-05 21:04 gena2x         File Added: patch.localeANDladspa                 
  
11-14-05 10:59 perex          Note Added: 0006712                          
11-14-05 11:32 gena2x         Note Added: 0006719                          
11-21-05 18:31 jdthood        Note Added: 0006772                          
11-22-05 09:01 perex          Note Added: 0006786                          
12-05-05 14:46 perex          Note Added: 0006911                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
