From: Kris Modrak <u9514439@anu.edu.au>
Subject: Rate Conversion
Date: Thu, 27 Jun 2002 18:29:36 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1ACCF0.5F1AC04A@anu.edu.au>
Reply-To: u9514439@anu.edu.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

I am writing a PCM application and wish to play a .wav file that has a
sampling rate of 8kHz on a hardware setup that only supports sampling
frequencies of 44.1 or 48kHz.

Does anyone know how to implement this?

I have tried setting up a rate plugin in my .asoundrc file

pcm.r8 {
        type rate               # Rate PCM
        slave slave_rate8000Hz  # Slave name
}

pcm_slave.slave_rate8000Hz {
        pcm "hw:0,0"
        rate 8000
}

But when using this device I am unable to set the rate to 8000 using
snd_pcm_hw_params_set_rate_near ();

I tried using the r8 device with aplay (version 0.9.0beta12) and get the
following error

> aplay -Dr8 s1.wav
Playing WAVE 's1.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
aplay: set_params:717: Broken configuration for this PCM: no
configurations available

I know it is possible to play the file because it works when I play it
from a netscape window.

Thanks in advance
Kris Modrak


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
