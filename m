From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: problems: flushing during snd_pcm_wait()
Date: Fri, 11 Oct 2002 01:25:19 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA59BDF.7030904@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello
I have an application that has many different threads.
The sound card's PCM buffer is full during playback, and one thread is 
currently in snd_pcm_wait() waiting for enough space to appear in the 
buffer before doing the next snd_pcm_write().
A different thread wants to flush the buffer. There are two types of 
flush: -
1) Immeadiately empty the buffer.
2) Stop accepting snd_pcm_write() commands until the current buffer has 
drained.

Can someone please tell me which API calls I should make to get the 
buffer to flush properly.
I am currently doing things like: -
int flush() {
 <snip...>
      if ((result=snd_pcm_reset(this->audio_fd)) < 0) {
        printf("audio_alsa_out: Reset call failed err=%d\n",result);
      }
      if ((result=snd_pcm_drain(this->audio_fd)) < 0) {
        printf("audio_alsa_out: Drain call failed err=%d\n",result);
      }
      if ((result=snd_pcm_prepare(this->audio_fd)) < 0) {
        printf("audio_alsa_out: Prepare call failed err=%d\n",result);
      }
}

But this is causing all sorts of problems, one of which is that the 
application hangs, and has to be killed with -9, and the audio hardware 
ring buffer is left playing a repeated sound even with: -
/proc/asound/card0/pcm0p/sub0# cat status
closed

Cheers
James





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
