From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0000209]: Sometimes XMMS stop playing songs (dmix used)
Date: Thu, 14 Oct 2004 22:40:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041014204016.03E1E2D0C1@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 775BD29D
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2004 22:40:16 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000209
======================================================================
Reported By:                srr
Assigned To:                
======================================================================
Project:                    ALSA - firmware
Bug ID:                     209
Category:                   
Reproducibility:            sometimes
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-14-2004 11:41 CEST
Last Modified:              10-14-2004 22:40 CEST
======================================================================
Summary:                    Sometimes XMMS stop playing songs (dmix used)
Description: 
Sometimes XMMS stop playing songs and show message that says "Audio device
not
properly configured or busy". It happends when new song just start
playing. If I click on Play button, songs continued playing. 

I can't repeat this bug, it happends 3-5 times in day.

If i start mpg123 and xmms they are play simultaniously (even if i start
10
copies of mpg123)

This is output from xmms:

ALSA lib pcm_hw.c:1057:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed:
Device
or resource busy
ALSA lib pcm_dmix.c:868:(snd_pcm_dmix_open) unable to open slave
 
** WARNING **: alsa_setup(): Failed to open pcm device (default): Device
or
resource busy


======================================================================

----------------------------------------------------------------------
 tiwai - 04-16-2004 11:54 CEST 
----------------------------------------------------------------------
perhaps some other application opens the pcm device.
try "fuser /dev/snd/pcmC0D0p" if this happens.  it will show
the processes using this device.

----------------------------------------------------------------------
 srr - 04-20-2004 07:39 CEST 
----------------------------------------------------------------------
fuser do not show anything: 
$ /sbin/fuser /dev/snd/pcmC0D0p 
$

OSS programs can not use /dev/dsp because of file permissions:
$ ls -l /dev/dsp
c---------  1 srr audio 14, 3 &https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0001071;&https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0001085;&https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0001074; 23 20:55 /dev/dsp

ALSA programs that i am use (aplay and xmms) are use only default dmixed
device.
$ cat ~/.asoundrc
pcm.intel8x0 {
        type hw
        card 0
} 
  
ctl.intel8x0 {
        type hw
        card 0
} 
  
pcm.!default {
    type plug
    slave.pcm "dmixer"
}
 
pcm.dsp0 {
    type plug
    slave.pcm "dmixer"
}
 
pcm.dmixer  {
    type dmix
    ipc_key 1024
    slave {
        pcm "hw:0,0"
        period_time 0
        period_size 1024
        buffer_size 4096
        #periods 128
        rate 48000
    }
    bindings {
        0 0
        1 1
    }
} 
  
ctl.dmixer {
    type hw
    card 0
}

----------------------------------------------------------------------
 chtephan - 10-14-2004 22:40 CEST 
----------------------------------------------------------------------
I'm seeing a similar (or probably same? problem).

When using beep media player (xmms GTK2 port) with the ALSA plugin in mmap
mode, pause the song and want to resume, audio output doesn't continue,
player hangs. Stopping and restarting works though.

I tracked it down to this point:
plugin calls snd_pcm_pause to resume the stream, then provides some
buffers of data via the mmap call and then waits forever for space to
become available, but audio output never started.

pcm.!default {
        type plug
        slave.pcm dmix
}

pcm.dsp0 {
        type plug
        slave.pcm dmix
}

pcm.dmix {
        type dmix
        ipc_key 1024
        ipc_key_add_uid false
        ipc_perm 0666
        slave {
                pcm "hw:0"
                period_time 0
                period_size 2048
                buffer_size 8192
        }
}

alsa-lib 1.0.7rc2, linux 2.6.9-rc3, snd-intel8x0, Gentoo

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-14-04 11:41 srr            New Bug                                      
04-16-04 11:54 tiwai          Bugnote Added: 0000832                       
04-20-04 07:39 srr            Bugnote Added: 0000869                       
04-20-04 07:41 srr            Bug Monitored: srr                           
10-14-04 22:40 chtephan       Bugnote Added: 0002160                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
