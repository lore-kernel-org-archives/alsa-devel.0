From: Venkam Bala krishna <venkam.bala@gmail.com>
Subject: omap34xx mixer elements
Date: Mon, 27 Jul 2009 20:12:51 +0530
Message-ID: <b3ccc1bb0907270742u50f9e837i3122d5c2bf943eaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by alsa0.perex.cz (Postfix) with ESMTP id BBC1624581
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jul 2009 16:42:52 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so900952wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2009 07:42:51 -0700 (PDT)
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

Hi all

Thanks in advance,

I am newbie to alsa
Currently working on porting android to omap34xx

Right now porting alsa.

This is a general question.

Please check the below log and specify any suggestions,  why is it not
listing any  of my capture devices.
What should be done to recognise my capture devices?
Do i have to do it in kernel level or user level?(since my amixer is listing
all my elements, given below the log is my amixer output for verification).

Any suggestions are welcome

thanks once agiain,

log
========================

D/AudioHardwareALSA(  799): Mixer: element name: 'Carkit'
D/AudioHardwareALSA(  799): Mixer: element name: 'DAC Voice Analog Downlink'
D/AudioHardwareALSA(  799): Mixer: element name: 'DAC Voice Digital
Downlink'
D/AudioHardwareALSA(  799): Mixer: element name: 'DAC1 Analog'
D/AudioHardwareALSA(  799): Mixer: element name: 'DAC1 Digital Coarse'
D/AudioHardwareALSA(  799): Mixer: element name: 'DAC1 Digital Fine'
D/AudioHardwareALSA(  799): Mixer: element name: 'DAC2 Analog'
D/AudioHardwareALSA(  799): Mixer: element name: 'DAC2 Digital Coarse'
D/AudioHardwareALSA(  799): Mixer: element name: 'DAC2 Digital Fine'
D/AudioHardwareALSA(  799): Mixer: element name: 'Earpiece'
D/AudioHardwareALSA(  799): Mixer: element name: 'Headset'
D/AudioHardwareALSA(  799): Mixer: element name: 'Left Digital Loopback'
D/AudioHardwareALSA(  799): Mixer: element name: 'PreDriv'
D/AudioHardwareALSA(  799): Mixer: element name: 'Right Digital Loopback'
D/AudioHardwareALSA(  799): Mixer: element name: 'Voice Digital Loopback'
D/AudioHardwareALSA(  799): Mixer: master 'PCM' not found.
D/AudioHardwareALSA(  799): Mixer: route 'Earpiece' found.
D/AudioHardwareALSA(  799): Mixer: route 'Speaker' not found.
D/AudioHardwareALSA(  799): Mixer: route 'Bluetooth' not found.
D/AudioHardwareALSA(  799): Mixer: route 'Headphone' not found.
D/AudioHardwareALSA(  799): Mixer: route 'Bluetooth A2DP' not found.
D/AudioHardwareALSA(  799): Mixer: element name: 'Analog'
D/AudioHardwareALSA(  799): Mixer: element name: 'DAC Voice Analog Downlink'
D/AudioHardwareALSA(  799): Mixer: element name: 'DAC Voice Digital
Downlink'
D/AudioHardwareALSA(  799): Mixer: element name: 'Left Digital Loopback'
D/AudioHardwareALSA(  799): Mixer: element name: 'Right Digital Loopback'
D/AudioHardwareALSA(  799): Mixer: element name: 'TX1 Digital'
D/AudioHardwareALSA(  799): Mixer: element name: 'TX2 Digital'
D/AudioHardwareALSA(  799): Mixer: element name: 'Voice Digital Loopback'
D/AudioHardwareALSA(  799): Mixer: master 'Capture' not found.
D/AudioHardwareALSA(  799): Mixer: route 'Capture' not found.
D/AudioHardwareALSA(  799): Mixer: route '' not found.
D/AudioHardwareALSA(  799): Mixer: route 'Bluetooth Capture' not found.
D/AudioHardwareALSA(  799): Mixer: route 'Capture' not found.
D/AudioHardwareALSA(  799): Mixer: route 'Bluetooth A2DP Capture' not found.
D/AudioHardwareALSA(  799): mixer initialized.

===========================

amixer output

=================
numid=18,iface=MIXER,name='Analog Capture Volume'
numid=23,iface=MIXER,name='Analog Left Capture Route'
numid=22,iface=MIXER,name='Analog Right Capture Route'
numid=14,iface=MIXER,name='Carkit Playback Volume'
numid=34,iface=MIXER,name='CarkitL Mixer AudioL1'
numid=35,iface=MIXER,name='CarkitL Mixer AudioL2'
numid=33,iface=MIXER,name='CarkitL Mixer Voice'
numid=31,iface=MIXER,name='CarkitR Mixer AudioR1'
numid=32,iface=MIXER,name='CarkitR Mixer AudioR2'
numid=30,iface=MIXER,name='CarkitR Mixer Voice'
numid=11,iface=MIXER,name='DAC Voice Analog Downlink Switch'
numid=10,iface=MIXER,name='DAC Voice Analog Downlink Volume'
numid=9,iface=MIXER,name='DAC Voice Digital Downlink Volume'
numid=7,iface=MIXER,name='DAC1 Analog Playback Switch'
numid=5,iface=MIXER,name='DAC1 Analog Playback Volume'
numid=3,iface=MIXER,name='DAC1 Digital Coarse Playback Volume'
numid=1,iface=MIXER,name='DAC1 Digital Fine Playback Volume'
numid=8,iface=MIXER,name='DAC2 Analog Playback Switch'
numid=6,iface=MIXER,name='DAC2 Analog Playback Volume'
numid=4,iface=MIXER,name='DAC2 Digital Coarse Playback Volume'
numid=2,iface=MIXER,name='DAC2 Digital Fine Playback Volume'
numid=51,iface=MIXER,name='Earpiece Mixer AudioL1'
numid=52,iface=MIXER,name='Earpiece Mixer AudioL2'
numid=53,iface=MIXER,name='Earpiece Mixer AudioR1'
numid=50,iface=MIXER,name='Earpiece Mixer Voice'
numid=15,iface=MIXER,name='Earpiece Playback Volume'
numid=19,iface=MIXER,name='HS ramp delay'
numid=29,iface=MIXER,name='HandsfreeL Mux'
numid=28,iface=MIXER,name='HandsfreeR Mux'
numid=13,iface=MIXER,name='Headset Playback Volume'
numid=40,iface=MIXER,name='HeadsetL Mixer AudioL1'
numid=41,iface=MIXER,name='HeadsetL Mixer AudioL2'
numid=39,iface=MIXER,name='HeadsetL Mixer Voice'
numid=37,iface=MIXER,name='HeadsetR Mixer AudioR1'
numid=38,iface=MIXER,name='HeadsetR Mixer AudioR2'
numid=36,iface=MIXER,name='HeadsetR Mixer Voice'
numid=56,iface=MIXER,name='Left Digital Loopback Volume'
numid=60,iface=MIXER,name='Left1 Analog Loopback Switch'
numid=58,iface=MIXER,name='Left2 Analog Loopback Switch'
numid=12,iface=MIXER,name='PreDriv Playback Volume'
numid=47,iface=MIXER,name='PredriveL Mixer AudioL1'
numid=48,iface=MIXER,name='PredriveL Mixer AudioL2'
numid=49,iface=MIXER,name='PredriveL Mixer AudioR2'
numid=46,iface=MIXER,name='PredriveL Mixer Voice'
numid=45,iface=MIXER,name='PredriveR Mixer AudioL2'
numid=43,iface=MIXER,name='PredriveR Mixer AudioR1'
numid=44,iface=MIXER,name='PredriveR Mixer AudioR2'
numid=42,iface=MIXER,name='PredriveR Mixer Voice'
numid=55,iface=MIXER,name='Right Digital Loopback Volume'
numid=61,iface=MIXER,name='Right1 Analog Loopback Switch'
numid=59,iface=MIXER,name='Right2 Analog Loopback Switch'
numid=25,iface=MIXER,name='TX1 Capture Route'
numid=16,iface=MIXER,name='TX1 Digital Capture Volume'
numid=24,iface=MIXER,name='TX2 Capture Route'
numid=17,iface=MIXER,name='TX2 Digital Capture Volume'
numid=21,iface=MIXER,name='Vibra H-bridge direction'
numid=20,iface=MIXER,name='Vibra H-bridge mode'
numid=27,iface=MIXER,name='Vibra Mux'
numid=26,iface=MIXER,name='Vibra Route'
numid=57,iface=MIXER,name='Voice Analog Loopback Switch'
numid=54,iface=MIXER,name='Voice Digital Loopback Volume'

===================

-- 
Regards
Venkam Balakrishna
