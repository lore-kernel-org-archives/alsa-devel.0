From: Martin Schreiber <mse00000@gmail.com>
Subject: Re: [BUG] snd_pcm_drop() does not stop the PCM
 immediately
Date: Wed, 14 Mar 2018 17:39:46 +0100
Message-ID: <bdf166af-553f-3f4e-187b-0e5120ffcf19@gmail.com>
References: <32cead2b-d2fc-485f-70e9-e528bc2fe63e@gmail.com>
 <s5hvady8zbk.wl-tiwai@suse.de>
 <332672f7-eabb-73a2-9f76-d03e8c9c253c@gmail.com>
 <s5hk1ue8wft.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------534F57F6FC48AA1E05757557"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 7641626708E
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 17:39:50 +0100 (CET)
Received: by mail-wm0-f49.google.com with SMTP id w128so5341785wmw.0
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 09:39:50 -0700 (PDT)
In-Reply-To: <s5hk1ue8wft.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------534F57F6FC48AA1E05757557
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 03/14/2018 05:16 PM, Takashi Iwai wrote:
>> Does snd_pcm_close() "scratching off the existing data from the mixed
>> buffer"?
> 
> It shouldn't.  There is no corresponding code in the dmix close path
> as far as I read again.  So, if it really does anything better, it's
> somewhere rather in the ALSA timer handling, I suppose.
> 
It does better, see attached alsadrop2.c.
Now the question is why? And could it be implemented in snd_pcm_drop() too?

Martin

--------------534F57F6FC48AA1E05757557
Content-Type: text/x-csrc;
 name="alsadrop2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsadrop2.c"

//alsadrop2 testcase
// compile with 
//gcc -oalsadrop2 -lasound -lpthread -g alsadrop2.c

#include <alsa/asoundlib.h>
#include <pthread.h>
#define samplefrequ 44100

int16_t bufa[samplefrequ]; //1 second f1
int16_t bufb[samplefrequ]; //1 second f2
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
void* buf;
snd_pcm_t *pcm;

void*
threadexe(void* param){
 snd_pcm_sframes_t frameswritten;
 int i1,i2,i3;
 void* buf1;

 i1 = sizeof(bufa)/sizeof(bufa[0]);
 frameswritten = 0;
 i3 = 0;
 
 while (1){
  pthread_mutex_lock(&mutex);
  printf("++waitstart\n");
  pthread_cond_wait(&cond,&mutex);
  printf("!!signaled\n");
  buf1 = buf;
  pthread_mutex_unlock(&mutex);
  frameswritten = snd_pcm_writei(pcm,buf1,i1);
  printf("%d %p %d\n",i3,buf1,frameswritten);
  i3++;
 } 
 return NULL;
}

int pcmopen(char* dev){

 unsigned int rate = samplefrequ;
 snd_pcm_hw_params_t *params = NULL;
 snd_pcm_hw_params_malloc(&params);

 if (snd_pcm_open(&pcm,dev, SND_PCM_STREAM_PLAYBACK, 0)){
  printf("Can not open pcm %s",dev);
  goto error;
 }
 if (!params){
  goto error;
 };
 if (snd_pcm_hw_params_any(pcm, params)<0){
  goto error;
 };
 if (snd_pcm_hw_params_set_access(pcm,params,SND_PCM_ACCESS_RW_INTERLEAVED)){
  goto error;
 };
 if (snd_pcm_hw_params_set_format(pcm,params,SND_PCM_FORMAT_S16_LE)){
  goto error;
 };
 if (snd_pcm_hw_params_set_rate_near(pcm,params,&rate,0)){
  goto error;
 };
 if (snd_pcm_hw_params_set_channels(pcm,params,1)){
  goto error;
 };
 if (snd_pcm_hw_params(pcm,params)){
  goto error;
 };
 if (snd_pcm_prepare(pcm)){
  goto error;
 };
 snd_pcm_nonblock(pcm,0);
 free(params);
 return 0;
error:
 return -1;
}

int main()
{
 int i1,i2;
 char* dev;
 snd_pcm_sframes_t frameswritten;
 pthread_t thread;

 for(i1=0;i1 < samplefrequ;i1++){
  bufa[i1] = 0x4000 * (2*((i1 / 40) % 2)-1);
  bufb[i1] = 0x4000 * (2*((i1 / 41) % 2)-1);
 }

 dev = "sysdefault"; //alsa direct      ->> overlapping sound
// dev = "default";  //over pulsaudio   ->> OK
 if (pcmopen(dev)){
  goto error;
 };
 mutex.__data.__kind = PTHREAD_MUTEX_RECURSIVE; 
 
 if (pthread_create(&thread,NULL,&threadexe,NULL)){
  goto error;
 }
 while(1){
  pthread_mutex_lock(&mutex);
  if (buf == bufa){
   buf = bufb;
  }
  else{
   buf = bufa;
  }
  pthread_mutex_unlock(&mutex);
  printf("--- %p signal\n",buf);
  pthread_cond_signal(&cond);
  usleep(700000);
  printf("<<<close\n");
  snd_pcm_close(pcm);
  if (pcmopen(dev)){
   goto error;
  };
/*
  printf("<<<drop\n");
  snd_pcm_drop(pcm);
  snd_pcm_drain(pcm);
 */
  i2 = snd_pcm_prepare(pcm);
  printf("<<<prepare %d\n",i2);
 }
 return 0;
error:
 return 1;
}
--------------534F57F6FC48AA1E05757557
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------534F57F6FC48AA1E05757557--
