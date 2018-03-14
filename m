From: Martin Schreiber <mse00000@gmail.com>
Subject: [BUG] snd_pcm_drop() does not stop the PCM immediately
Date: Wed, 14 Mar 2018 15:59:07 +0100
Message-ID: <32cead2b-d2fc-485f-70e9-e528bc2fe63e@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------442793E6072C157F66FD9F43"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B6042670BE
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 15:59:11 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id q83so4687996wme.5
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 07:59:11 -0700 (PDT)
Received: from [192.168.1.40]
 (73.244.106.92.dynamic.wline.res.cust.swisscom.ch. [92.106.244.73])
 by smtp.googlemail.com with ESMTPSA id 11sm241059edv.89.2018.03.14.07.59.09
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Mar 2018 07:59:09 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------442793E6072C157F66FD9F43
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,
The documentation states:
"
This function stops the PCM immediately. The pending samples on the
buffer are ignored.
"
This does not work for the device "sysdefault" where a piece of the old
sound and the new sound overlap, see attached alsadrop1.c testprogram.
It is OK with the "default" device which is wired over Pulseaudio,
uncomment alsadrop1.c:55 in order to test.
The project is here:
https://gitlab.com/mseide-msegui/mseuniverse/tree/master/testcase/audio/c/alsadrop

Environment: openSUSE Leap 42.3, see attached alsa-info.tar.gz.

Martin

--------------442793E6072C157F66FD9F43
Content-Type: application/gzip;
 name="alsa-info.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="alsa-info.tar.gz"

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
--------------442793E6072C157F66FD9F43
Content-Type: text/x-csrc;
 name="alsadrop1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsadrop1.c"

//alsadrop1 testcase
// compile with 
//gcc -oalsadrop1 -lasound -lpthread -g alsadrop1.c

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

int main()
{
 int i1,i2;
 char* dev;
 snd_pcm_hw_params_t *params = NULL;
 unsigned int rate = samplefrequ;
 snd_pcm_sframes_t frameswritten;
 pthread_t thread;

 for(i1=0;i1 < samplefrequ;i1++){
  bufa[i1] = 0x4000 * (2*((i1 / 40) % 2)-1);
  bufb[i1] = 0x4000 * (2*((i1 / 41) % 2)-1);
 }

 dev = "sysdefault"; //alsa direct      ->> overlapping sound
// dev = "default";  //over pulsaudio   ->> OK
 if (snd_pcm_open(&pcm,dev, SND_PCM_STREAM_PLAYBACK, 0)){
  printf("Can not open pcm %s",dev);
  goto error;
 }
 snd_pcm_hw_params_malloc(&params);
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
  printf("<<<drop\n");
  snd_pcm_drop(pcm);
  snd_pcm_drain(pcm);
  i2 = snd_pcm_prepare(pcm);
  printf("<<<prepare %d\n",i2);
 }
 return 0;
error:
 return 1;
}
--------------442793E6072C157F66FD9F43
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------442793E6072C157F66FD9F43--
