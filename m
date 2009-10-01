From: Navink Singh <navink.singh@tcs.com>
Subject: LEFT or RIGHT Channel in alsa mixer
Date: Thu, 1 Oct 2009 22:56:54 +0530
Message-ID: <OF807F8AEA.8F534B2B-ON65257642.005F90B8-65257642.005FC844@tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inmumg02.tcs.com (Inmumg02.tcs.com [219.64.34.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C0F12454A
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 19:26:58 +0200 (CEST)
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

Hi Developers,

              I need to configure my audio device such as to use only LEFT 
or RIGHT Channel.
I have carried out following steps to proceed with

1) Opened PCM playback Device
2) Configured its hardware and Software parameters
3) Open mixer
4) Attached Mixer to playback device
5) Registered Mixer
6) Loaded the mixer
7) Get the first element of mixer

A)
    Now when i use following API, snd_mixer_selem_is_playback_mono(aElem); 
i found mixer is using MONO channel.
But i am configuring my PCM Device for 2 channels

    I am using snd_mixer_selem_set_playback_switch() API to set right or 
Left channel to MUTE {Does not work}

    If i set all channels to Mute {Works fine}
              snd_mixer_selem_set_playback_switch_all (aElem, 0)

    Also i am able to set SND_MIXER_SCHN_MONO to mute {works fine}
              snd_mixer_selem_set_playback_switch(aElem, 
SND_MIXER_SCHN_MONO, 0)

B)
    There is also an API in my MIXER driver to set the right and left 
balance, but i did not find
any API in Application to do so {Is there any such API in Application}.


Thanks in Advance,

Navin Kumar Singh
Tata Consultancy Services
DLF Akruti Info Park,
PN 28,
Rajiv Gandhi Infotech Park   Hinjewadi, PHASE II
Pune - 411057,Maharashtra
India
Ph:- +91 20 66752458
Cell:- +919860227357
Mailto: navink.singh@tcs.com
Website: http://www.tcs.com
____________________________________________
Experience certainty.   IT Services
                        Business Solutions
                        Outsourcing
____________________________________________
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you
