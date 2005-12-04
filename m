From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001616]: Support for mute led feature
Date: Sun, 4 Dec 2005 07:00:55 +0100
Message-ID: <299f369c8e083cd0275278947a2064c5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A8C4A17B
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2005 07:00:55 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1616> 
======================================================================
Reported By:                jstamp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1616
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.14
======================================================================
Date Submitted:             12-04-2005 07:00 CET
Last Modified:              12-04-2005 07:00 CET
======================================================================
Summary:                    Support for mute led feature
Description: 
The PowerPro G 3:11 (aka the Sabio MW1) uses an ALC880 chip.  It also has a
mute button which is supposed to light up when the audio is muted.

I found out that you can turn on the LED with the following commands:
  snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK, 0x01);
  snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION, 0x01);
  snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0x01);

Setting GPIO_DATA to 0x00 will turn off the LED.

Is there an easy way to incorporate this feature into the driver?

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-05 07:00 jstamp         New Issue                                    
12-04-05 07:00 jstamp         Distribution              => Debian          
12-04-05 07:00 jstamp         Kernel Version            => 2.6.14          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
