From: Karsten Noe <kn@daimi.au.dk>
Subject: sound input stops
Date: Mon, 25 Oct 2004 16:57:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1098716224.5089.2.camel@rip.daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi

I have problems with a piece of software, that is supposed to read input
from a microphone and analyze the data.

The problem is that sometimes it starts as it should, and other times it
does not. Also I read a maximum of 2048 samples at the time, and if the
number of samples returned by snd_pcm_avail_update gets larger than this
value, the software also fails.

Stripped for error handling, the initialization looks like this:

snd_pcm_open(&capture_handle,"plughw:0,1",               
SND_PCM_STREAM_CAPTURE, 0);

snd_pcm_hw_params_malloc (&hw_params);

snd_pcm_hw_params_any (capture_handle, hw_params);

snd_pcm_hw_params_set_access (capture_handle, hw_params,
SND_PCM_ACCESS_RW_INTERLEAVED);

snd_pcm_hw_params_set_format (capture_handle, hw_params,   
SND_PCM_FORMAT_FLOAT_LE);

unsigned int val = sampleRate;

snd_pcm_hw_params_set_rate_near  (capture_handle, hw_params, &val, 0);

snd_pcm_hw_params_set_channels (capture_handle, hw_params, 1);

snd_pcm_hw_params (capture_handle, hw_params);

snd_pcm_hw_params_free (hw_params);

snd_pcm_prepare (capture_handle);

Now a thread is running that continuously does something like the
following:

while (true)
{
  count = snd_pcm_avail_update(capture_handle);
  if (count<0) {count=0;}

  if (count>2048) {count=2048;}

  snd_pcm_readi (capture_handle, inputBuffer, count);

  .... Analyze data in inputBuffer ....
}

The problem is that sometimes this loop stops updating the inputBuffer.
In these cases, count stays the same  after wards for every iteration at
a low value (count<50).

As long as count is large, there is no problem, but when is goes low, I
get no new input..

Please tell me what I am doing wrong.

Thanks 

Karsten



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
