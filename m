From: "scott andrew franco" <samiam@moorecad.com>
Subject: Re: Serious bug calling ALSA lib functions from .so
 vs. .o file
Date: Tue, 18 Jun 2019 11:59:19 -0700
Message-ID: <20190618115919.6c61c97e98fe7bb02193b2d6dca4a85a.e791232afd.mailapi@email03.godaddy.com>
References: <20190618113358.6c61c97e98fe7bb02193b2d6dca4a85a.ed0e6629be.mailapi@email03.godaddy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p3plwbeout03-04.prod.phx3.secureserver.net
 (p3plsmtp03-04-2.prod.phx3.secureserver.net [72.167.218.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15B02F80CC4
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 20:59:52 +0200 (CEST)
In-Reply-To: <20190618113358.6c61c97e98fe7bb02193b2d6dca4a85a.ed0e6629be.mailapi@email03.godaddy.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

PS. I really appreciate the help, I have spent more than a week on this, it is a serious blocking issue.
 
I've gone over the example I posted quite carefully. I recommend you try the example out. You just need the
two source files below (test2.c and playwav.c). and execute the commands shown below.
 
The fact that it fails only in the .so file can explain why this bug hasn't affected more user code, since most
people don't call alsa from another library. However, it does not explain everything since I believe there must
be a few users who do put the calling code in a library.
 
Thanks,
 
Scott Franco
 
--------- Original Message --------- Subject: RE: Re: [alsa-devel] Serious bug calling ALSA lib functions from .so vs. .o file
From: "scott andrew franco" <samiam@moorecad.com>
Date: 6/18/19 11:33 am
To: "Jaroslav Kysela" <perex@perex.cz>
Cc: alsa-devel@alsa-project.org

 Hi, and thanks for the reply.
 
>I think that you must link .so to -lasound, too.
 
This was done and shows in the command line example below, IE,
 
 samiam@samiam-home-pc:~/projects/petit_ami$ gcc -fPIC -c test2.c -o test2.o
> samiam@samiam-home-pc:~/projects/petit_ami$ gcc -g3 -Iinclude linux/playwav.c ./test2.so -lasound -o playwav
> samiam@samiam-home-pc:~/projeclufthansa check reservationts/petit_ami$ ./playwav
> alsaplaywave: rate: 1
> alsaplaywave: rate: 0
> samiam@samiam-home-pc:~/projects/petit_ami$ gcc -g3 -Iinclude linux/playwav.c ./test2.o -lasound -o playwav
> samiam@samiam-home-pc:~/projects/petit_ami$ ./playwav
> alsaplaywave: rate: 1
> alsaplaywave: rate: 1
 
Note that in both the "succeeds" case and the "fails" case carry the -lasound option. It would not compile
if not.
 
Scott Franco
 
--------- Original Message --------- Subject: Re: [alsa-devel] Serious bug calling ALSA lib functions from .so vs. .o file
From: "Jaroslav Kysela" <perex@perex.cz>
Date: 6/18/19 11:18 am
To: "scott andrew franco" <samiam@moorecad.com>
Cc: alsa-devel@alsa-project.org

Dne 18. 06. 19 v 17:16 scott andrew franco napsal(a):
 > Hello,
 > 
 > The issue:
 > 
 > calling across .so (dynamic linking) produces different behavior in ALSA library calls than normal,
 > and causes ALSA to malfunction.
 > 
 > I have minimized my issue to as small a code section as possible. Note the code is from commonly available
 > internet examples, including Free Electrons "Audio in embedded linux systems".
 
 It seems like a linker issue. I think that you must link .so to -lasound, too.
 (add -lasound to the command producing your .so library to satisfy the
 versioned symbols)
 
 Jaroslav
 
 > 
 > The run is:
 > 
 > samiam@samiam-home-pc:~/projects/petit_ami$ gcc -fPIC -c test2.c -o test2.o
 > samiam@samiam-home-pc:~/projects/petit_ami$ gcc -g3 -Iinclude linux/playwav.c ./test2.so -lasound -o playwav
 > samiam@samiam-home-pc:~/projeclufthansa check reservationts/petit_ami$ ./playwav
 > alsaplaywave: rate: 1
 > alsaplaywave: rate: 0
 > samiam@samiam-home-pc:~/projects/petit_ami$ gcc -g3 -Iinclude linux/playwav.c ./test2.o -lasound -o playwav
 > samiam@samiam-home-pc:~/projects/petit_ami$ ./playwav
 > alsaplaywave: rate: 1
 > alsaplaywave: rate: 1
 > 
 > Note the only difference between the two runs of "playwave" is if the second module, test2, is linked as a .so or
 > linked as a .o.
 > 
 > The code is:
 > =======================================================================================
 > playwav.c
 > #include <alsa/asoundlib.h>
 > #include <stdio.h>
 > void alsaplaywave1(void)
 > {
 > snd_pcm_t *pcm_handle;
 > snd_pcm_hw_params_t *params;
 > unsigned int val;
 > unsigned int rate;
 > int r;
 > /* open pcm device */
 > r = snd_pcm_open(&pcm_handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
 > if (r < 0) printf("Cannot open PCM output device");
 > snd_pcm_hw_params_alloca(&params); /* get hw parameter block */
 > snd_pcm_hw_params_any(pcm_handle, params);
 > r = snd_pcm_hw_params_set_access(pcm_handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
 > if (r < 0) printf("Cannot set interleaved mode");
 > r = snd_pcm_hw_params_set_format(pcm_handle, params, SND_PCM_FORMAT_S16_LE);
 > if (r < 0) printf("Cannot set format");
 > r = snd_pcm_hw_params_set_channels(pcm_handle, params, 2);
 > if (r < 0) printf("Cannot set channels number");
 > val = 44100;
 > r = snd_pcm_hw_params_set_rate_near(pcm_handle, params, &rate, 0);
 > if (r < 0) printf("Cannot set rate");
 > snd_pcm_hw_params_get_rate(params, &rate, 0);
 > printf("alsaplaywave: rate: %d\n", rate);
 > snd_pcm_close(pcm_handle);
 > }
 > extern void alsaplaywave2(void);
 > int main(int argc, char **argv)
 > {
 > alsaplaywave1();
 > alsaplaywave2();
 > return 0;
 > }
 > 
 > ==================================================================================
 > test2.c
 > #include <alsa/asoundlib.h>
 > #include <stdio.h>
 > void alsaplaywave2(void)
 > {
 > snd_pcm_t *pcm_handle;
 > snd_pcm_hw_params_t *params;
 > unsigned int val;
 > unsigned int rate;
 > int r;
 > /* open pcm device */
 > r = snd_pcm_open(&pcm_handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
 > if (r < 0) printf("Cannot open PCM output device");
 > snd_pcm_hw_params_alloca(&params); /* get hw parameter block */
 > snd_pcm_hw_params_any(pcm_handle, params);
 > r = snd_pcm_hw_params_set_access(pcm_handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
 > if (r < 0) printf("Cannot set interleaved mode");
 > r = snd_pcm_hw_params_set_format(pcm_handle, params, SND_PCM_FORMAT_S16_LE);
 > if (r < 0) printf("Cannot set format");
 > r = snd_pcm_hw_params_set_channels(pcm_handle, params, 2);
 > if (r < 0) printf("Cannot set channels number");
 > val = 44100;
 > r = snd_pcm_hw_params_set_rate_near(pcm_handle, params, &rate, 0);
 > if (r < 0) printf("Cannot set rate");
 > snd_pcm_hw_params_get_rate(params, &rate, 0);
 > printf("alsaplaywave: rate: %d\n", rate);
 > snd_pcm_close(pcm_handle);
 > }
 > _______________________________________________
 > Alsa-devel mailing list
 > Alsa-devel@alsa-project.org
 > https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
 > 
 
 
 -- 
 Jaroslav Kysela <perex@perex.cz>
 Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
 _______________________________________________
 Alsa-devel mailing list
 Alsa-devel@alsa-project.org
 https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
