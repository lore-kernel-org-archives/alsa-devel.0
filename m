From: Robert Krakora <rob.krakora@messagenetsystems.com>
Subject: ALSA 1.0.20 Speex PCM Plugin
Date: Tue, 2 Jun 2009 16:39:46 -0400
Message-ID: <b24e53350906021339r55bef955od429a2ae0f867ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id A4DB3243E0
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 22:39:47 +0200 (CEST)
Received: by qyk1 with SMTP id 1so11662078qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 02 Jun 2009 13:39:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

Has anyone successfully employed the ALSA 1.0.20 Speex PCM Plugin?  I
followed the "speexdsp.txt" document under the 'doc' directory but the
result was the following error:

[root@vizioroom105 ~]# arecord -Dplug:mic poopy.wav
Recording WAVE 'poopy.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
ALSA lib pcm_params.c:2135:(snd1_pcm_hw_refine_slave) Slave PCM not usable
arecord: set_params:957: Broken configuration for this PCM: no
configurations available

Here is my asound.conf:

# MessageNet Systems ALSA sound configuration file
# Allowing multiple playback and capture

pcm.!default {
   type plug
   slave.pcm "duplex"
}
pcm.duplex {
   type asym
   playback.pcm "dmixer"
   capture.pcm "analog_input"
}
pcm.dmixer {
   type dmix
   ipc_key 1024
   ipc_perm 0666
   slave {
       pcm "hw:2,3"
       period_time 0
       period_size 1024
       buffer_size 8192
   }
   bindings {
      0 0
      1 1
   }
}
pcm.mic
{
  type speex
  slave.pcm {
      type hw
      card 1
  }
  agc 1
  agc_level 8000
}
pcm.analog_input
{
   type dsnoop
   ipc_key 2048
   ipc_perm 0666
   slave{
      pcm "hw:1,2"
   }
}
pcm.dsp0 {
   type plug
   slave.pcm "dmixer"
}
ctl.mixer0 {
   type hw
   card 0
}

Here are the results of alsa-info.sh:

http://www.alsa-project.org/db/?f=358e4d5d828dda3c44220382c8b480fd6019ab2a

Thanks in advance.

Best Regards,

-- 
Rob Krakora
Senior Software Engineer
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677 Ext. 206
(317)663-0808 Fax
