From: Cristian Morales Vega <cmorve69@yahoo.es>
Subject: snd_pcm_writei() return value
Date: Thu, 21 May 2009 19:26:04 +0200
Message-ID: <8235e6f40905211026x15a45c05p3061cfb323b329a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FDC4244B2
	for <alsa-devel@alsa-project.org>;
	Thu, 21 May 2009 19:26:06 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1424624ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 21 May 2009 10:26:04 -0700 (PDT)
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

Hi,

I have an stupid doubt... The snd_pcm_writei() documentation says:
"If the blocking behaviour is selected, then routine waits until all
requested bytes are played or put to the playback ring buffer. The
count of bytes can be less only if a signal or underrun occurred."
and at the same time it says "-EPIPE   an underrun occurred" is a
possible return value.
Then snd_pcm_recover() documentation says:
"This functions handles -EINTR (interrupted system call), -EPIPE
(overrun or underrun) and -ESTRPIPE (stream is suspended) error codes
trying to prepare given stream for next I/O."

So if I want to write the full content of a buffer, would this be valid?:

while(buffer.length > 0) {
  snd_pcm_sframes_t written = snd_pcm_writei(device.handle,
buffer.data, buffer.length);
  if(written < 0)
    snd_pcm_recover(device.handle, written, 1);
  else
    buffer.length = 0;
}


"The count of bytes can be less only if a signal ... occurred." makes
me think that if a signal interrups snd_pcm_writei() it will return a
value between 0 and buffer.length, but "This functions handles -EINTR
(interrupted system call)" makes me think that it will always return
-EINTR.

"The count of bytes can be less only if a ... underrun occurred.",
even if technically correct, also seems to be against the "-EPIPE   an
underrun occurred" return value.


So, in the previous code, "if(written < 0)" should be changed by
"if(written < buffer.length)"? Anyway, how snd_pcm_recover() handles
an -EINTR? If only half the data has been written it can't modify
buffer.data to point to the last sample written+1. Perhaps I need a
full:

uint32_t *buffer_ptr = buffer.data;

while(buffer.length > 0) {
  snd_pcm_sframes_t written = snd_pcm_writei(device.handle,
buffer_ptr, buffer.length);
  if(written < 0) {
    snd_pcm_recover(device.handle, written, 1);
  } else if(written <= buffer.length) {
    buffer.length -= written;
    buffer_ptr += written;
  }
}

? And still, in this case an interrupt would be handled by
snd_pcm_recover() (written < 0) or by the "else" code?


Thanks.
