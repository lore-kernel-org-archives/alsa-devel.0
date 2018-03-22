From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - IOPLUG DRAIN 0/2]
Date: Thu, 22 Mar 2018 15:17:10 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FE3E2@HI2EXCH01.adit-jv.com>
References: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>,
 <s5hlgekp3bz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 40B0726739D
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 16:17:18 +0100 (CET)
In-Reply-To: <s5hlgekp3bz.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I don't understand.  The pulse plugin calls pa_stream_drain(), and
> pulse_wait_operation() to wait until the drain finishes.  What does it
> have to do with threading?

As far as I understand you patch io->data->callback->drain() will not be called in nonblocking mode.
+       if (io->data->state == SND_PCM_STATE_DRAINING) {
+               if (io->data->nonblock)
+                       return -EAGAIN;
+
+               if (io->data->callback->drain) {
+                       err = io->data->callback->drain(io->data);
+                       if (err < 0)
+                               return err;
+               }
+       }

Therefore how should call pa_stream_drain() in case of nonblocking mode?

Best regards

Timo
