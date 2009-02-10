From: kallipygos@inbox.lv
Subject: using ALSA one call
Date: Tue, 10 Feb 2009 14:30:14 +0200
Message-ID: <1234269014.49917356f0157@mail.inbox.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shark3.inbox.lv (shark3.inbox.lv [89.111.3.83])
	by alsa0.perex.cz (Postfix) with ESMTP id DF0B6103814
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 13:30:21 +0100 (CET)
Received: from localhost (w15 [10.0.1.25])
	by shark3-plain-b64d2.inbox.lv (Postfix) with ESMTP id 37DF3182
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 14:30:15 +0200 (EET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Developers.

My name is Alf  and i new in this list .
I physics student , and i write some sound programs under linux.
Big sorry for my english , in school i learn only deutsch.

So far i used old /dev/dsp open funntion also under ALSA.

/*--OSD--*/#define RATE 44100   /* the sampling rate */
/*--OSD--*/#define SIZE 16      /* sample size: 8 or 16 bits */
/*--OSD--*/#define CHANNELS 2   /* 1 = mono 2 = stereo */
/*--OSD--*/void open_sound_device_wr(void)
/*--OSD--*/{//  fdo = open("/dev/dsp", O_RDWR );
/*--OSD--*/  fdo = open("/dev/dsp", O_WRONLY );
/*--OSD--*/  if (fdo < 0) {       perror("open of /dev/dsp failed");    exit(1);  }
/*--OSD--*/
/*--OSD--*/  arg = SIZE;      //// sample size
/*--OSD--*/  status = ioctl(fdo, SOUND_PCM_WRITE_BITS, &arg);
/*--OSD--*/  if (status == -1)     perror("SOUND_PCM_WRITE_BITS ioctl failed");
/*--OSD--*/  if (arg != SIZE)      perror("unable to set sample size");
/*--OSD--*/
/*--OSD--*/  arg = CHANNELS;  //// mono or stereo
/*--OSD--*/  status = ioctl(fdo, SOUND_PCM_WRITE_CHANNELS, &arg);
/*--OSD--*/  if (status == -1)     perror("SOUND_PCM_WRITE_CHANNELS ioctl failed");
/*--OSD--*/  if (arg != CHANNELS)  perror("unable to set number of channels");
/*--OSD--*/
/*--OSD--*/  arg = RATE;      //// sampling rate
/*--OSD--*/  status = ioctl(fdo, SOUND_PCM_WRITE_RATE, &arg);
/*--OSD--*/  if (status == -1)    perror("SOUND_PCM_WRITE_WRITE ioctl failed");
/*--OSD--*/}
----

Now i wana try da same with ALSA ,
for example all parameters put in one struckture and then simple call 
one  universal alsa_open funktion.
Is it posssible with ALSA ? 
Is here copy-paste example/function for fast, comfortable and easy ALSA use ?

for example so :
====
#include "alsa/asoundlib.h"
...
alsa_parm_struckt.device    = "default";  // "hw:0,0"; "hw:1,0";
alsa_parm_struckt.play_capt = SND_PCM_STREAM_PLAYBACK;
alsa_parm_struckt.format    = SND_PCM_FORMAT_S16_LE;
alsa_parm_struckt.access    = SND_PCM_ACCESS_RW_INTERLEAVED;
//alsa_parm_struckt.samplerate = 48000;
alsa_parm_struckt.samplerate = 44100;
alsa_parm_struckt.channelz  =2;
alsa_parm_struckt.bytes_per_sample = 2;
alsa_parm_struckt.latency   = 0; // ??
alsa_parm_struckt.nonblock  = 1; // ??
... other parameters set ...
...
alsa_open_function( & handle , & alsa_parm_struckt [ , ...] );

  and after this write data blocks 
 frames_2_write = ...
 for(;;)
 {
  ...
  frames = snd_pcm_writei(handle, buffer, frames_2_write );
  ...
 }
====

OK , this example works 
http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm__min_8c-example.html
but only if  samplerate = 48000; 
if  samplerate = 44100 - then not :(
44k file play in 48k mode :D  it sounds funnee :D

I remixed this program so that it read data from wave file.

gcc  pcm_min01.c -lasound -O2  -o pcm_min01 
./pcm_min01  '/mnt/hda2/Booty Luv - Shine/Booty Luv - Shine (Ian Carey remix).wav'
i gotta this :
ALSA lib pcm.c:7160:(snd_pcm_set_params) Rate doesn't match (requested 44100Hz, get 0Hz)
Playback open error: Invalid argument

With aplay no problems, it is played in da correct speed.
--
 aplay '/mnt/hda2/Booty Luv - Shine/Booty Luv - Shine (Ian Carey remix).wav'
Playing WAVE '/mnt/hda2/Booty Luv - Shine/Booty Luv - Shine (Ian Carey remix).wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
--



Any ideas/examples/... welcome
Tnx in advance

Alf





====




----
