From: "Fabien COMTE" <fabien.comte@ercogener.com>
Subject: Application and hw mixing for VoIP
Date: Thu, 17 Sep 2009 11:51:33 +0200
Message-ID: <3448.6074270264$1253181108@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-msa-out01.orange.fr (smtp-msa-out01.orange.fr
	[193.252.23.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 4279A1037FE
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 11:51:36 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf5a04.orange.fr (SMTP Server) with ESMTP id 675651C0009F
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 11:51:35 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf5a04.orange.fr (SMTP Server) with ESMTP id 57A161C000A0
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 11:51:35 +0200 (CEST)
Received: from EG03VISTA64 (LMontsouris-152-63-17-45.w193-252.abo.wanadoo.fr
	[193.252.108.45])
	by mwinf5a04.orange.fr (SMTP Server) with ESMTP id 1A3C91C00099
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 11:51:34 +0200 (CEST)
Content-Language: fr
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I need some help please.
I have an application that does VoIP and use OSS emulated interface.

I want to :
- send through VoIP application a mixed sound from mic and an another
application (aplay should be ok for testing).

mic ----------------->
                         mix  ---- oss emulation -----> voip application
application 1 ------->
(aplay)

- use sound received from VoIP with HP output and an another application
(arecord should be ok for testing).

                                                  ---------> application 2
(arecord)
voip application ----- oss emulation ---->  copy
                                                  ---------> HP output
	

I tried a lot of asoundrc but they doesn't work. Every try I did, Dsnoop
cannot mix sound for application 1 and copy is already in use.

Could someone help me ?

# wm8731 is the name of my hardware codec
pcm_slave.wm8731 {
	type hw
	card 0
	device 0
}

pcm.from_voip {
       ipc_key 1025
       type dmix
       slave.pcm wm8731 
   }
   
   #one called "to_voip" for capturing 
   pcm.to_voip {
       ipc_key 1027
       type dsnoop
       slave.pcm wm8731 
   }
   
   #and this is the real magic
   pcm.temp_voip {
       type asym
       playback.pcm "from_voip"
       capture.pcm "to_voip"
   }
   
   #a quick plug plugin for above device to do the converting magic
   pcm.voip {
       type plug
       slave.pcm "temp_voip"
   }
   
   #a ctl device to keep xmms happy
   ctl.voip {
       type hw
       card 0
   }
   
   #for aoss:
   pcm.dsp0 {
       type plug
       slave.pcm "voip"
   }
   
   ctl.mixer0 {
       type hw
       card 0
   }

   pcm.from_voip_copy {
	type plug
	slave from_voip
	route_policy copy
}

Thank you.

Fabien
