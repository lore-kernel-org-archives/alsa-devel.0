From: Moshe Yudkowsky <speech@pobox.com>
Subject: Re: ViaVoice or ALSA bug?
Date: Thu, 10 Jul 2003 10:23:59 -0500
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.0.20030710101314.020f2980@dns.bl.com>
References: <20030709154341.GA7479@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <20030709154341.GA7479@alinoe.com>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Carlo Wood <carlo@alinoe.com>, alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net, xvoice@yahoogroups.com
List-Id: alsa-devel@alsa-project.org

Oh, ho! Speech recognition *and* ALSA -- right up my alley.

Do you get no recognition at all? Or just poor recognition?

If poor recognition, have you tried creating a dummy user and seeing if you 
can train up that new user? If the spectral characteristics of the input 
are different under ALSA -- yeah, they shouldn't be, but clearly it happens 
--  then you might need to retrain  to get any accuracy.

If you have no recognition whatsoever, I suspect an issue with configuring 
ViaVoice to recognize the micorophone input. First, I'd try "arecord" to 
see if I can use *any* program to capture speech. I have found that I can't 
get any recordings working on my machine (Via 8235, Asus A7V8X) unless I 
use a battery-powered microphone.

"arecord -l" (lower-case L) should give you legit recording inputs.

I personally find that "esd" doesn't work with ALSA 0.9.4, and I kill esd 
servers that are running. I use OSS or ALSA directly, through their 
respective modules (for xmms, for example) or through the /dev/dsp input if 
the program I'm using only has OSS.

If esd if off, I'll hazard a guess there's a problem with ViaVoice. I am 
guessing that you've configured ViaVoice to use /dev/dsp. The only other 
thing that comes to mind is that ViaVoice may require 8 kHz or 11 kHz PCM 
input, and with ALSA you can sometimes manage to create 44 kHz  or 48 kHz 
inputs. You might need to fiddle with the default configuration of your 
inputs, using asound.state, to feed ViaVoice the correct 16 bit, 8 or 11 
kHz that it probably requires.


HTH,
  Moshe

At 17:43 2003-07-09 +0200, Carlo Wood wrote:
>Dear ALSA developers,
>
>Ok, I fixed the previous problem; now running the
>latest kernel + latest modules (and alsa 0.9.4).
>
>The REAL problem I have is the following:
>
>Recording has always been extremely hard to impossible
>with linux - one of the applications that I REALLY
>cannot get working is the speech recognition tool of
>IBM: ViaVoice.
>
>I downloaded the commercial sound drivers from Front4
>and with that it works perfectly.  In the past I've also
>got this to work with the OSS/Free stuff.
>
>However... with ALSA, it has never has worked; and I've tried
>a lot of things :(.
>
>I can't see this anymore being anything else but a bug
>in ALSA.  The problem however is to find WHY it doesn't
>work (and then fix it).
>
>I'd like to get some guidance with that.
>
>My setup is as follows:
>
>1) It works (recording speech with microphone) when using
>    the Front4 commercial sound drivers.
>2) With ALSA, playback works and I hear myself back over
>    the speakers when I talk into the microphone.  I even
>    can let it 'sing around' by capturing Mic (of course) and
>    turning on max. "AC97" and "Capture == Igain".  Also
>    "AC97 Capture" was set to the maximum.  In fact, I turned
>    EVERYTHING on to the maximum with alsamixer, unmuted
>    everything and captured Mic [1]... No recording.
>
>I am willing to get to the bottom of this, but I am out
>of ideas right now :/
>
>Please help.
>
>--
>Carlo Wood <carlo@alinoe.com>
>
>
>-------------------------------------------------------
>This SF.Net email sponsored by: Parasoft
>Error proof Web apps, automate testing & more.
>Download & eval WebKing and get a free book.
>www.parasoft.com/bulletproofapps
>_______________________________________________
>Alsa-user mailing list
>Alsa-user@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-user


-- 
  Moshe Yudkowsky
  Disaggregate
  2952 W Fargo
  Chicago, IL 60645 USA

  <http://www.Disaggregate.com>



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
