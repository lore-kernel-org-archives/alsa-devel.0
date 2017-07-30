From: tsepp2001@t-online.de
Subject: Fwd: Fwd: Re:  Basic questions
Date: Sun, 30 Jul 2017 18:43:44 +0200
Message-ID: <9e815030-6fd1-bee3-6527-aae39c272198@t-online.de>
References: <8adce38a-2792-264c-7938-fa7b1c5789b0@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 7420C266C9B
 for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2017 18:43:48 +0200 (CEST)
Received: from fwd26.aul.t-online.de (fwd26.aul.t-online.de [172.20.26.131])
 by mailout05.t-online.de (Postfix) with SMTP id 82927420D25C
 for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2017 18:43:47 +0200 (CEST)
In-Reply-To: <8adce38a-2792-264c-7938-fa7b1c5789b0@t-online.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

thank you. In blocking-mode it works. Then i will follow the 
non-blocking mode. I modified first the callback:

void playback_callback (snd_pcm_sframes_t nframes)
{
     snd_pcm_sframes_t avail;

     avail = snd_pcm_avail_update(handle);
     while (avail >= period_size)
     {
         snd_pcm_writei(handle, buffer_alsa , nframes);
         avail = snd_pcm_avail_update(handle);
         std::cout << "      Avail:  " << avail << std::endl;
     }
}

...
called it at the end:
playback_callback(period_size);

and I get (for "avail"):

Frames:  6894888
buffer_size (frames):  2048
buffer_time (frames):  46439
period_size (frames):  256
period_time (usec):  5804
periods (count):  8
Avail:  1282
Avail:  1027
Avail:  772
Avail:  517
Avail:  261
Avail:  6

the same mistake...

Regards
Thomas



tsepp2001@t-online.de  wrote:
> Am I right to use async mode

No.  It is not supported by all devices, and almost impossible to use
correctly.

> to get lowest latency times

Latency depends on the buffer size, and how fast your code can react to
the notification that some space is available.

> and using pause/play/stop?

You probably want to use non-blocking mode.


Regards,
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
