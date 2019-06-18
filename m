From: "scott andrew franco" <samiam@moorecad.com>
Subject: Re: Serious bug calling ALSA lib functions from .so
	vs. .o file
Date: Tue, 18 Jun 2019 08:16:14 -0700
Message-ID: <20190618081614.6c61c97e98fe7bb02193b2d6dca4a85a.a95f05e421.mailapi@email03.godaddy.com>
References: <20190617232429.6c61c97e98fe7bb02193b2d6dca4a85a.19b5fd637d.mailapi@email03.godaddy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p3plwbeout03-03.prod.phx3.secureserver.net
 (p3plsmtp03-03-2.prod.phx3.secureserver.net [72.167.218.215])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3A67F8075C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 17:16:47 +0200 (CEST)
In-Reply-To: <20190617232429.6c61c97e98fe7bb02193b2d6dca4a85a.19b5fd637d.mailapi@email03.godaddy.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
 
The issue:
 
calling across .so (dynamic linking) produces different behavior in ALSA library calls than normal,
and causes ALSA to malfunction.
 
I have minimized my issue to as small a code section as possible. Note the code is from commonly available
internet examples, including Free Electrons "Audio in embedded linux systems".
 
The run is:
 
samiam@samiam-home-pc:~/projects/petit_ami$ gcc -fPIC -c test2.c -o test2.o
samiam@samiam-home-pc:~/projects/petit_ami$ gcc -g3 -Iinclude linux/playwav.c ./test2.so -lasound -o playwav
samiam@samiam-home-pc:~/projects/petit_ami$ ./playwav
alsaplaywave: rate: 1
alsaplaywave: rate: 0
samiam@samiam-home-pc:~/projects/petit_ami$ gcc -g3 -Iinclude linux/playwav.c ./test2.o -lasound -o playwav
samiam@samiam-home-pc:~/projects/petit_ami$ ./playwav
alsaplaywave: rate: 1
alsaplaywave: rate: 1
  
 Note the only difference between the two runs of "playwave" is if the second module, test2, is linked as a .so or
 linked as a .o.
  
 The code is:
 =======================================================================================
 playwav.c
 #include <alsa/asoundlib.h>
#include <stdio.h>
 void alsaplaywave1(void)
 {
 snd_pcm_t *pcm_handle;
 snd_pcm_hw_params_t *params;
 unsigned int val;
 unsigned int rate;
 int r;
 /* open pcm device */
 r = snd_pcm_open(&pcm_handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
 if (r < 0) printf("Cannot open PCM output device");
 snd_pcm_hw_params_alloca(&params); /* get hw parameter block */
 snd_pcm_hw_params_any(pcm_handle, params);
 r = snd_pcm_hw_params_set_access(pcm_handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
 if (r < 0) printf("Cannot set interleaved mode");
 r = snd_pcm_hw_params_set_format(pcm_handle, params, SND_PCM_FORMAT_S16_LE);
 if (r < 0) printf("Cannot set format");
 r = snd_pcm_hw_params_set_channels(pcm_handle, params, 2);
 if (r < 0) printf("Cannot set channels number");
 val = 44100;
 r = snd_pcm_hw_params_set_rate_near(pcm_handle, params, &rate, 0);
 if (r < 0) printf("Cannot set rate");
 snd_pcm_hw_params_get_rate(params, &rate, 0);
 printf("alsaplaywave: rate: %d\n", rate);
 snd_pcm_close(pcm_handle);
 }
 extern void alsaplaywave2(void);
 int main(int argc, char **argv)
 {
 alsaplaywave1();
 alsaplaywave2();
 return 0;
}
  
 ==================================================================================
 test2.c
 #include <alsa/asoundlib.h>
#include <stdio.h>
 void alsaplaywave2(void)
 {
 snd_pcm_t *pcm_handle;
 snd_pcm_hw_params_t *params;
 unsigned int val;
 unsigned int rate;
 int r;
 /* open pcm device */
 r = snd_pcm_open(&pcm_handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
 if (r < 0) printf("Cannot open PCM output device");
 snd_pcm_hw_params_alloca(&params); /* get hw parameter block */
 snd_pcm_hw_params_any(pcm_handle, params);
 r = snd_pcm_hw_params_set_access(pcm_handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
 if (r < 0) printf("Cannot set interleaved mode");
 r = snd_pcm_hw_params_set_format(pcm_handle, params, SND_PCM_FORMAT_S16_LE);
 if (r < 0) printf("Cannot set format");
 r = snd_pcm_hw_params_set_channels(pcm_handle, params, 2);
 if (r < 0) printf("Cannot set channels number");
 val = 44100;
 r = snd_pcm_hw_params_set_rate_near(pcm_handle, params, &rate, 0);
 if (r < 0) printf("Cannot set rate");
 snd_pcm_hw_params_get_rate(params, &rate, 0);
 printf("alsaplaywave: rate: %d\n", rate);
 snd_pcm_close(pcm_handle);
 }
