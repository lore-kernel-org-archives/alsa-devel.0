From: James Courtier-Dutton <James@superbug.co.uk>
Subject: A need for support for SPI interfacing in alsa.
Date: Sat, 02 Oct 2004 19:38:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <415EF5B2.6050106@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net [194.217.242.89])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D7F89271
	for <alsa-devel@alsa-project.org>; Sat,  2 Oct 2004 20:38:44 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1CDonN-000PPZ-4A
	for alsa-devel@alsa-project.org; Sat, 02 Oct 2004 18:39:49 +0000
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

More and more sound card manufacturers are moving away from AC97 codecs.
Up until recently, this was not really a problem, but I came across a 
new sound card today. The Creative SB Live! 7.1 24bit.
This is based on the Audigy LS.
  *  GENERAL INFO: Audigy LS
  *    Model: SB0310
  *    P17 Chip: CA0106-DAT
  *    AC97 Codec: STAC 9721
  *    ADC: Philips 1361T (Stereo 24bit)
  *    DAC: WM8746EDS (6-channel, 24bit, 192Khz)
  *
  *  GENERAL INFO: SB Live! 7.1 24bit.
  *    Model: SB0410
  *    P17 Chip: CA0106-DAT
  *    AC97 Codec: None
  *    ADC: WM8775EDS (4 Channel)
  *    DAC: CS4382 (114 dB, 24-Bit, 192 kHz, 8-Channel D/A Converter)

The Audigy LS has a Philips 1361T stereo only ADC.
The SB Live! 7.1 24bit has a WM8775EDS 4 channel ADC.

So, now we will have to be able to talk to the ADC chip over it's 
control channel. This control is done via an SPI bus.
The reason we need support now, is that we need to be able to control 
which inputs the WM8775EDS selects.
The WM8665EDS has a stereo ADC, but can select from 4 stereo inputs.

Does anyone know how we might support SPI interfaces? I don't know much 
about them, and there is only one 32bit register and one interrupt pin 
on the P17 chip to control this.

James


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
