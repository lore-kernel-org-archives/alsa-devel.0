From: "mahendra  sp" <mahendra_sp@rediffmail.com>
Subject: problem ragarding execution of Latency.c
Date: 30 Apr 2003 05:19:17 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030430051917.27750.qmail@webmail28.rediffmail.com>
Reply-To: "mahendra  sp" <mahendra_sp@rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: pzad@pobox.sk, hall@maoz.com, abramo@alsa-project.org, tiwai@suse.de, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

hi ,

   I am trying to execute the file latency.c , provided by ALSA.MY 
driver is ES 1938 solo-1. I have source code for the driver.

  application i want to write is similar to latency.c

  I want to write application to capture ansd playback.So i want 
to execute latency.c and see the output. I have include 
asoundlib.h.

   The errors it is giving when i give the command

  gcc -o latency.out latency.c

"in functio set_hwparams:undefined reference to 
snd_pcm_hw_params_any
snd_strerror,snd_pcm_hw_params_set_format..."

so please help as i am new to linux.
please give replies as i have to complete my project and my 
deadline in nearing.

thanks,
warm regards,
mahendra







-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
