From: pavelni@volny.cz
Subject: Re: [linux-audio-dev] initial (incomplete) version of ALSA Audio API (Pavel Nikitenko)
Date: Mon, 25 Mar 2002 18:43:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a704720d7dcd2230d3d7ef513612b6a9@www1.mail.volny.cz>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
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

Hi all,
Thanks for your tutorial Paul Davis...
I found some errors:
#include <alsa/asoundlib.h>
Opening devices at mini capture example should be:
	   int err;
           if ((err = snd_pcm_open (&capture_handle, argv[1],
SND_PCM_STREAM_CAPTURE, 0)) < 0) {                  fprintf (stderr,
"cannot open audio device %s\n", argv[1]);                  exit
(1);
           }
Opening devices at miniplayback example should be:
	   int err;
	   if ((err = snd_pcm_open(&playback_handle, argv[1],
SND_PCM_STREAM_PLAYBACK, 0)) < 0) {                  fprintf (stderr,
"cannot open audio device %s\n", argv[1]);                  exit
(1);
           }
This 3 errors are at minifullduplex too.

Seting rate should be this way (examles: playback, capture, duplex):
snd_pcm_hw_params_set_rate_near (capture_handle, hw_params, 44100,
0);

And playback (mini playback, mini full duplex):
snd_pcm_writei(playback_handle, buf, sizeof (buf));

Record (minicapture, mini full duplex):
snd_pcm_readi (capture_handle, buf, sizeof (buf));

mini Full duplex example:
You have there two buffers:            char pbuf[4096]; char
cbuf[4096]; and you write to pbuf and capture to cbuf but these two
buffers have not any connection so it cannot work. So I used only one
buffer for both.

Both mini playback and mini capture work very well (after my
corrections) but I have problem to get work full duplex, althougth my
card it supports.
So I little experiment and found out (after changing order of
playback and capture and setting char pbuf[44000])  that it records
only one times and then it plays the same. (Next records do no
capture nothing and playback plays  still the first record). Could
you help me to get full duplex to work?                              
                                                               Pavel
Nikitenko					http://ampcast.com/mrpiano
