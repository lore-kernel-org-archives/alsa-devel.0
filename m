From: Niccolo Rigacci <niccolo@rigacci.org>
Subject: Missing support for via VT8237 and ALC655
Date: Tue, 3 Feb 2004 00:00:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402030000.59929.niccolo@rigacci.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

I have a motherboard based on the VIA KT600 Northbridge and VT8237 
Southbridge. The codec is an ALC655.

I tried the ALSA module snd-via82xx. PCM audio works fine, but several things 
did not work:

- The MIC input does not work, no matter how I set alsamixer
  controls (the OSS driver via82cxxx_audio, instead can properly
  mix the input).

- Capture does not work. I tried to enable capturing from MIC,
  LINE or CD, but no stream is received by arecord. Also OSS
  emulation (/dev/dsp) does not receive any data. I tried to
  set, unmute and caputre any control in alsamixer.
  The OSS dirver via82cxxx_audio can't capture too.

Just to check, on the same system I fitted a snd-maestro3 PCI card, which 
works perfectly mixing and capturing any audio source.

Is there some developing on that VIA chip? Can I do some tasks to help testing 
or coding?

Thanks

-- 
Niccolo Rigacci
Firenze - Italy

War against Iraq? Not in my name!



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
