From: Niklas Werner <bergtroll@gmx.li>
Subject: emi 2|6 usb-audio
Date: Fri, 9 Aug 2002 23:41:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208092141.XAA22116@papaschlumpf.wg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all!

Good News (especially to takashi):

Emagic's emi 2|6 works with 6 channels out using a52dec from dvd!
unfortunately there seems to be no way of accesing the 6 channels via the 
.asoundrc-trick from patrick. I can't get any pcmCxD1 or pcmCxD2 device.
alsamixer only shows 2 channels in and 2 channel out.

===============================
cat /proc/asound/emi/stream0   
EMAGIC GmbH Emagic EMI 2|6 : USB Audio                                    
                                                                          
Playback:
  Status: Stop
  Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 10 OUT (ASYNC)
    Rates: 44100, 48000, 96000
  Altset 2
    Format: S16_LE
    Channels: 6
    Endpoint: 10 OUT (ASYNC)
    Rates: 44100, 48000
  Altset 3
    Format: S24_3LE
    Channels: 6
    Endpoint: 10 OUT (ASYNC)
    Rates: 44100, 48000
  Altset 4
    Format: S24_3LE
    Channels: 2
    Endpoint: 10 OUT (ASYNC)
    Rates: 96000

Capture:
  Status: Stop
  Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000, 96000
  Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 12 IN (ASYNC)
    Rates: 44100, 48000, 96000

========================================

But:
cat /proc/asound/devices 
  0: [0- 0]: ctl
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer
 32: [1- 0]: ctl
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture

card0 is my ppc-screamer, card1 is the emi.

Does anybody have an idea, how I must tweak my .asoundrc to get a device 
I can send 6 channels of appropriately formatted data to?
I'm aware that a52dec seems to send sample1Ch1-sample1Ch2-sample1Ch3 ...
I'd like to control the channels seperately, but I'm afraid that won't be 
possible...

Have fun*

Niklas


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
