From: Guild Jackson <guildjackson@yahoo.com>
Subject: How to open a device using ALSA API
Date: Fri, 2 Jul 2004 10:16:48 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040702171648.91434.qmail@web50402.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi all

I am quite new using the ALSA sound API and have been
trying to open the sound card with the following
function:
#define AUDIO_DEVICE "/dev/dsp"

if ((err = snd_pcm_open (&capture_handle,
AUDIO_DEVICE, SND_PCM_STREAM_CAPTURE, 0)) < 0) {
			fprintf (stderr, "cannot open audio device %s
(%s)\n", 
				 argv[1],
				 snd_strerror (err));
			exit (1);
		}

But I´ve got the following problem when running it:

$ ./captureAlsa
ALSA lib pcm.c:1972:(snd_pcm_open_noupdate) Unknown
PCM /dev/dsp
cannot open audio device (null) (No such file or
directory)

I think I am not configuring correctly the audio
device
card.
Does anyone know how to configure properly the
parameters to open correctly the sound card?
I´ve seen something about it in ecasound-2.3.3
aplication that uses the ALSA driver but all I have
found was:

err = snd_pcm_open(&audio_fd_repp, 
			 (char*)device_name.c_str(),
			 pcm_stream_rep,
			 SND_PCM_NONBLOCK);

I tried to figure out what is the device_name.c_str()
but I can´t find this function in the ecasound cpp
files.
Does anyone have a simple example that shows how to
open the sound card with ALSA?

Thanks in advance and best regards

Guild





__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
