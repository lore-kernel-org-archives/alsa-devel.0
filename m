From: Christof Damian <cdamian@guideguide.com>
Subject: Hoontech Audio DSP24 Value (+bracket)
Date: Mon, 11 Feb 2002 14:15:59 +0000
Message-ID: <20020211141559.A16177@stratus.london.guideguide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa developer mailinglist <alsa-devel@alsa.alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
I already send the attached email to the alsa-user list, but haven't
got any response. 

After looking through ice1712.c I now realize that the DSP24 Value
might never have been tried with this driver. As it only mentions the
STDSP24, which is similar but not the same.

Is this correct, or has anyone got this working ?

I am currently fiddling with the driver and have done this:

--- pci/ice1712.c       9 Feb 2002 18:54:38 -0000       1.9
+++ pci/ice1712.c       11 Feb 2002 14:11:25 -0000
@@ -3750,6 +3750,10 @@
 
        /* determine I2C, DACs and ADCs */
        switch (ice->eeprom.subvendor) {
+       case ICE1712_SUBDEVICE_STDSP24:
+               has_i2c = 1;
+               ice->num_adcs = ice->num_dacs = ice->num_total_dacs =
2;
+               break;  
        case ICE1712_SUBDEVICE_AUDIOPHILE:
                ice->ak4528 = 1;
                /* follow thru */
@@ -3954,6 +3958,7 @@
        case ICE1712_SUBDEVICE_DELTA66:
        case ICE1712_SUBDEVICE_EWS88MT:
        case ICE1712_SUBDEVICE_DMX6FIRE:
+       case ICE1712_SUBDEVICE_STDSP24:
                for (idx = 0; idx < ice->num_dacs; ++idx) {
                        snd_kcontrol_t ctl;
                        memset(&ctl, 0, sizeof(ctl));

which gives me the IPGA scontrol in amixer and the "H/W Out 1+2" and the
DAC 0+1 and ADC 0+1 levels in "Analog Volume" in envy24control.

not that i know what i am doing as i don't have any docs for this
card. I also don't know how to decide wheter the card is a DSP24 Value
or STDSP24 in ice1712.c

christof
-- 
Christof Damian         
Technical Director, guideguide ltd.	            

--UlVJffcvxoiEqYs2
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <alsa-user-admin@lists.sourceforge.net>
Delivered-To: damian@aviator.guideguide.com
Received: from aviator [194.203.206.226]
	by localhost with IMAP (fetchmail-5.9.0)
	for damian@localhost (single-drop); Tue, 05 Feb 2002 12:38:35 +0000 (GMT)
Received: from tr909.mediaconsult.com (tr909 [193.128.6.132])
	by aviator.guideguide.com (Postfix) with ESMTP id 78BCAB888E
	for <damian@aviator.guideguide.com>; Tue,  5 Feb 2002 12:30:05 +0000 (GMT)
Received: by tr909.mediaconsult.com (Postfix)
	id AB1DF735B; Tue,  5 Feb 2002 12:30:04 +0000 (GMT)
Delivered-To: damian@tr909.mediaconsult.com
Received: from usw-sf-list1.sourceforge.net (usw-sf-fw2.sourceforge.net [216.136.171.252])
	by tr909.mediaconsult.com (Postfix) with ESMTP id 65F157355
	for <cdamian@guideguide.com>; Tue,  5 Feb 2002 12:30:04 +0000 (GMT)
Received: from localhost ([127.0.0.1] helo=usw-sf-list1.sourceforge.net)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 16Y4gj-0003cS-00; Tue, 05 Feb 2002 04:27:05 -0800
Received: from alsa.jcu.cz ([160.217.1.49] helo=alsa.alsa-project.org)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 16Y4gR-0003Vq-00
	for <alsa-user@lists.sourceforge.net>; Tue, 05 Feb 2002 04:26:47 -0800
Received: from stratus.london.guideguide.com (proxy.guideguide.com [194.203.206.225])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA07852
	for <alsa-user@alsa-project.org>; Tue, 5 Feb 2002 13:26:44 +0100
Received: by stratus.london.guideguide.com (Postfix, from userid 500)
	id 220454A639; Tue,  5 Feb 2002 12:24:50 +0000 (GMT)
From: Christof Damian <cdamian@guideguide.com>
To: alsa-user@alsa-project.org
Message-ID: <20020205122450.W6030@stratus.london.guideguide.com>
Mail-Followup-To: alsa-user@alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Subject: [Alsa-user] Hoontech DSP24 Value
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
X-BeenThere: alsa-user@lists.sourceforge.net
X-Mailman-Version: 2.0.5
Precedence: bulk
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Id: Advanced Linux Sound Architecture - User <alsa-user.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-user>
X-Original-Date: Tue, 5 Feb 2002 12:24:50 +0000
Date: Tue, 5 Feb 2002 12:24:50 +0000

I recently bought a Hoontech SoundTrack Audio DSP24 Value including
the DSP24 Value Bracket. I had a Audiophile 2496 before, but I wanted
a card with the AK4524 instead of the AK4528, so I could change the
input gain. 

But this gain option isn't showing up with the DSP24 Value either.

The other problem I have is that starting envy24control shows this
messages:

Unable to read Delta S/PDIF output state: No such file or directory
Unable to write Delta S/PDIF Output Defaults: No such file or directory

i just ignore them, but it also seems that envy24control works not as
good with this card as with the 2496, I am not able to route the H/W
in into the Digital Mixer for example.

christof

some info from /proc:
/proc/asound/cards
0 [card0          ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! at 0x9400, irq 7
1 [card1          ]: ICE1712 - Hoontech SoundTrack Audio DSP24
                     Hoontech SoundTrack Audio DSP24 at 0x8800, irq 10

/proc/asound/card1/ice1712 
ICE1712

EEPROM:
  Subvendor        : 0x12141217
  Size             : 28 bytes
  Version          : 1
  Codec            : 0x2f
  ACLink           : 0x80
  I2S ID           : 0x71
  S/PDIF           : 0x3
  GPIO mask        : 0xfc
  GPIO state       : 0x2
  GPIO direction   : 0x3
  AC'97 main       : 0x0
  AC'97 pcm        : 0x0
  AC'97 record     : 0x0
  AC'97 record src : 0x44
  DAC ID #0        : 0x1
  DAC ID #1        : 0x1
  DAC ID #2        : 0x1
  DAC ID #3        : 0x1
  ADC ID #0        : 0x2
  ADC ID #1        : 0x2
  ADC ID #2        : 0x2
  ADC ID #3        : 0x2


-- 
Christof Damian         
Technical Director, guideguide ltd.	            

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--UlVJffcvxoiEqYs2--

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
