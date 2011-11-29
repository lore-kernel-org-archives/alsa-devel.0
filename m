From: Martin schmidt <schmidtmartin00@googlemail.com>
Subject: Alsa asynchonus playnback
Date: Tue, 29 Nov 2011 12:28:33 +0100
Message-ID: <CAOONfQtrZGd0itFu5rdcyXgfHU4jM5P5M1uBqkBjWwvqF=LGtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CFA161039FA
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 12:28:33 +0100 (CET)
Received: by eaai13 with SMTP id i13so2922135eaa.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 03:28:33 -0800 (PST)
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

Hello,

I want to play audiodata using alsa and do as it is explained in
http://alsa.opensrc.org/Asynchronous_Playback_%28Howto%29
http://equalarea.com/paul/alsa-audio.html#interruptex
1. open device
2 define a callback

void MyCallback(snd_async_handler_t *pcm_callback)   { ...  }


      err = snd_async_add_pcm_handler(&pcm_callback, pcm_handle,
MyCallback, NULL);
      if(err<0){
          fprintf (stderr, "err = %d --> snd_async_add_pcm_handler:
(%s)\n",err,snd_strerror (err));
      }

return -38 ( function is not implemented )???

i a loop I generate the audiodata

void produce_audiodata(short* left, short *right)
{

 for(int k = 0; k< max;k++){
  audio[2*k]= left[k];
  audio[2*k+1]= right[k];
  }
   Mycallback(...)  is it the right place to call it ?
}

thanks
