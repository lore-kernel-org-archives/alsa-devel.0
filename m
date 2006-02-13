From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001622]: ASUS A8V-MX onboard sound does not work
Date: Mon, 13 Feb 2006 23:56:15 +0100
Message-ID: <3da9be1c8e60dec4347cb53dc9a32f15@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 742E0155
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 23:56:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1622> 
======================================================================
Reported By:                m_yates
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1622
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10
Kernel Version:             2.6.12 (also reproduced using 2.6.15-rc2)
======================================================================
Date Submitted:             12-05-2005 18:59 CET
Last Modified:              02-13-2006 23:56 CET
======================================================================
Summary:                    ASUS A8V-MX onboard sound does not work
Description: 
Onboard sound plays for a second, then freezes on Asus A8V-MX mainboard. 
Here is sound output from lspci:

matt@duster:~$ lspci | grep Multimedia
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 70)

Here is alsa version (version that came with Ubuntu 5.10):

||/ Name           Version        Description
+++-==============-==============-============================================
ii  alsa-base      1.0.9b-4       ALSA driver configuration files

Here are the sound modules:

root@duster:/home/matt# lsmod | grep snd
snd_seq_dummy 4484 0
snd_seq_oss 32128 0
snd_seq_midi 9920 0
snd_seq_midi_event 8064 2 snd_seq_oss,snd_seq_midi
snd_seq 52032 6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_via82xx 29472 1
gameport 16392 1 snd_via82xx
snd_ac97_codec 87000 1 snd_via82xx
snd_pcm_oss 51232 0
snd_mixer_oss 17664 1 snd_pcm_oss
snd_pcm 91020 3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer 24200 2 snd_seq,snd_pcm
snd_page_alloc 11408 2 snd_via82xx,snd_pcm
snd_mpu401_uart 7936 1 snd_via82xx
snd_rawmidi 27040 2 snd_seq_midi,snd_mpu401_uart
snd_seq_device 9488 5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi
snd 55784 13
snd_seq_oss,snd_seq,snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu40
1_uart,snd_rawmidi,snd_seq_device
soundcore 10912 1 snd

Asus lists the audio chip as "Realtek ALC653", alsamixer shows "Realtek
ALC655 rev 1". 
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001557 Sounds play only for a very short time ...
======================================================================

----------------------------------------------------------------------
 Tuba - 02-10-06 14:09 
----------------------------------------------------------------------
I have attached mplayer8251.strace, which is from a custom 2.6.15 kernel on
Debian. The problem exists on other 2.6.15-kernels tested, as well as on a
box running Mandriva 2006.

Other media players fail in similar ways, either crashing or going into an
endless loop.

----------------------------------------------------------------------
 gobo - 02-13-06 23:56 
----------------------------------------------------------------------
Seeing the same problems as above. Have tried with several 2.6.14 and
2.6.15 kernel variants and alsa-drivers standalone on my gentoo system. 
Fails with xmms, mplayer, cat /dev/urandom > /dev/dsp, etc.
I can't really add more than what is already said, but if there is any
experimental code you wish to have tested I can try it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-05 18:59 m_yates        New Issue                                    
12-05-05 18:59 m_yates        Distribution              => Ubuntu 5.10     
12-05-05 18:59 m_yates        Kernel Version            => 2.6.12 (also
reproduced using 2.6.15-rc2)
12-06-05 15:53 tiwai          Note Added: 0006926                          
12-06-05 18:21 m_yates        Note Added: 0006931                          
12-06-05 20:16 m_yates        Note Added: 0006937                          
12-07-05 01:09 Dakkus         Issue Monitored: Dakkus                      
12-07-05 11:24 perex          Relationship added       has duplicate 0001557
12-07-05 16:16 thijser        Issue Monitored: thijser                     
01-02-06 23:53 AlexCline      Issue Monitored: AlexCline                    
01-03-06 20:41 AlexCline      Note Added: 0007406                          
01-29-06 02:14 adaviel        Note Added: 0007830                          
01-29-06 02:15 adaviel        Issue Monitored: adaviel                     
01-30-06 19:36 millallo       Issue Monitored: millallo                    
02-10-06 14:07 Tuba           File Added: mplayer8251.strace                    
02-10-06 14:09 Tuba           Note Added: 0008004                          
02-10-06 14:09 Tuba           Issue Monitored: Tuba                        
02-13-06 23:39 gobo           Issue Monitored: gobo                        
02-13-06 23:56 gobo           Note Added: 0008065                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
