From: Matt Flax <flatmax@ieee.org>
Subject: ozone : 763/2808/100
Date: Wed, 22 Oct 2003 15:53:32 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031022055332.GA12533@mffm.ee.unsw.edu.au>
Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id GAA07924
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2003 06:37:20 +0200
Received: from localhost (antivirus-03.services.comms.unsw.EDU.AU [149.171.193.82])
	by smtp3.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h9M4bBO23644
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2003 14:37:11 +1000 (EST)
Received: from maillationax ([149.171.36.140])
	by smtp.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h9M4b8c23575
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2003 14:37:09 +1000 (EST)
Received: from flatmax by maillationax with local (Exim 3.36 #1 (Debian))
	id 1ACBw5-0003Gx-00
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2003 15:53:33 +1000
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi ALSA devs,

I just got an Ozone ... nice external card.... good for live use ...

I get the following error in my /var/log/messages
Oct 21 22:39:45 localhost usb.agent[781]: ... no modules for USB product
763/2808/100

referring to this fix:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg09026.html

should this be added too ? :

{
        USB_DEVICE_VENDOR_SPEC(0x0763, 0x2808),
        .driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
                .vendor_name = "M-Audio",
                .product_name = "Ozone",
                .ifnum = 3,
                .type = QUIRK_MIDI_MIDIMAN,
                .data = & (const snd_usb_midi_endpoint_info_t) {
                        .out_cables = 0x0001,
                        .in_cables  = 0x0001
                }
        }
},

Matt


-- 
http://flatmax.org

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
