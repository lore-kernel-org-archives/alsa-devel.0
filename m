From: Bruce Paterson <bruce@tele-ip.com>
Subject: PCM application question: readn
Date: Wed, 03 Jul 2002 18:21:27 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D22B407.4ACC14AA@tele-ip.com>
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


Hi alsa people,

OK, this is probably in the dumb green user category of question but we
are all there at some
time or other !  Nothing in the archives seems to help.

Background:
I am writing a simple linux application which uses a professional
multichannel soundcard: envy24
Originally parts of this program were done under windows, but things
were getting real messy with
the standard windows API when you need more than 2 channels capture.
Alsa 0.9 seems to fit the
bill perfectly, allowing 96000 sample rate on 4 channels with 24 bit
sampling, and even in & out
sync ! 

Where I'm at:
alsa 0.9.0rc2 has been installed sucessfully. aplay works, evny24control
(wonderful!!) works.
Also, if I only playback from my application, it works (as long as I use
plughw:0.0)

Problem 1:
When I try to record I get segmentation fault in
"snd_pcm_route_convert1_one" called indirectly
by my "snd_pcm_readn" call. I would prefer to use readn rather than
readi since it suits my
application better. The capture is opened in blocking mode (whereas my
playback was opened in
non-blocking mode). 
It is possible I have misinterpreted the parameters for "snd_pcm_readn",
but the API doco doesn't
describe "void **bufs" very well. I have assumed I am meant to pass a
pointer to an array of
pointers (array size = #channels configured), which in turn point to
buffers (one for each channel)
each which must be at least as big as ("size" *
#bytes-needed-to-store-sample) bytes. In this current
test I am using 16bit samples, but I'm using the "snd_pcm_format_width"
anyway. I have assumed the
buffers for the channels do not need to be contigueous with each other.
Is this correct ?

Problem 2:
When I try device "hw:0.0" the very first hardware parameter set fails
with unavailable. It's
 snd_pcm_hw_params_set_access(handle, params,
SND_PCM_ACCESS_RW_NONINTERLEAVED); that fails.
I have seen other posts talking about using non-interleaved frames....
surely the ice1712
supports this ??


-- 
Cheers,
Bruce
-------------------------------------------------------------------
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom
they are addressed. If you have received this email in error please
notify the system manager.

    /\\\/\\\/\\\    /   /      Bruce Paterson          
   /  \\\ \\\ \\\  /   /    Senior Design Engineer
  /   /\\\/\\\/\\\/   /   87 Peters Ave, Mulgrave, Vic, 3170
 /   /  \\\ \\\ \\\  /  PO Box 4112, Mulgrave, Vic, 3170, Australia
/   /    \\\/\\\ \\\/   Ph: +61 3 8561 4232   Fax: +61 3 9560 9055
      Tele-IP Ltd.      Email: bruce@tele-ip.com    Icq: #32015991
                        WWW:   http://www.tele-ip.com       VK3TJN
-------------------------------------------------------------------


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
