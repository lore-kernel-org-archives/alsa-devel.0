From: "Paul Kavan" <pkavan@gmail.com>
Subject: Period Size in hw_params
Date: Thu, 12 Jul 2007 12:28:57 -0500
Message-ID: <61c0054e0707121028h506477e4n3f2a0a0e3c330581@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DC4424340
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 19:28:58 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so260435mue
	for <alsa-devel@alsa-project.org>; Thu, 12 Jul 2007 10:28:57 -0700 (PDT)
Content-Disposition: inline
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

I finally have my basic audio applications working. I divided it into
capture and playback and began with playback as I had a nice sinewave I
could use to playback. Anyway, I think my hangup with getting the thing
working was with the buffer and period information. My apps now do this:

int periods = 2;  /* Number of periods */
snd_pcm_uframes_t periodsize = 1000; /* Periodsize (bytes) */

 /* Set number of periods */
  if (snd_pcm_hw_params_set_periods(pcm_handle, hwparams, periods, 0) < 0) {
    fprintf(stderr, "Error setting periods.\n");
    return(-1);
  }
  /* Set buffer size */
  size = periodsize * periods;
  if (snd_pcm_hw_params_set_buffer_size(pcm_handle, hwparams, (size)>>2) <
0) {
    fprintf(stderr, "Error setting buffer size.\n");
    return(-1);
  }

I borrowed the period size from using aplay -v and seeing what it used.
Setting number of periods to 2 was a little bit of guess work based on what
others seem to use. I have looked at the alsa documentation and cannot see
how I could have determined these numbers would have worked without trial
and error. Can anyone either give me a explanation of how to determine these
or a pointer to some decent documentation that talks about this?

Thanks.

Paul

-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
