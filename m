From: "Olivier Guillion - Myriad" <olivier@myriad-online.com>
Subject: ALSA calls don't work from a shared library
Date: Wed, 24 Aug 2011 13:36:08 +0200
Message-ID: <4E54E228.12224.FC4C70@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.planet-service.fr (smtp.planet-service.fr [83.167.45.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 38A6110393A
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 13:36:04 +0200 (CEST)
Content-description: Mail message body
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

I opened a thread yesterday called "ALSA calls don't work within  Mozilla plug-
ins", but after more testing, I realize that it is a more global problem, so I 
submit another request for help with a proper title.

It seems that several  ALSA functions either crash or return unpredictable 
values when called from a dynamic library (.so).

I created a very short program that opens a pcm device, sets the sample rate to 


44100 and reads the sample rate back to ensure it's correct :
---------------
#include "alsa/asoundlib.h"
static char displayString[1024];

char * ALSATest(void)
{
int err;
snd_pcm_t * handle;
snd_pcm_hw_params_t *params;
unsigned int  val,val2;
char status[1024];

err = snd_pcm_open(&handle, "plughw:0,0",SND_PCM_STREAM_PLAYBACK, 0);
if(err>=0)
     {
     snd_pcm_hw_params_alloca(&params);
     snd_pcm_hw_params_any(handle, params);
     val=44100;
     err=snd_pcm_hw_params_set_rate_near(handle,params, &val, NULL);
     val2=0;
     err|=snd_pcm_hw_params_get_rate(params, &val2, NULL);
     if(val!=44100 || val2!=44100 || err!=0)
        sprintf(status,"ALSA is not working (val2=%d err=%d)",val2,err);
     else
        strcpy(status,"ALSA is OK");
 snd_pcm_close(handle);
 }
else
    strcpy(status,"device cannot be opened");
sprintf(displayString,"ALSA %s\nStatus:%s",snd_asoundlib_version(),status);
return(displayString);
}
-------------

If I call this function directly from the main program, it works well (I get 
"ALSA is OK").
Then if I compile it as a shared library (mysharedlib.so), and in another 
project I write:

---------------
#include <dlfcn.h>
#include "alsa/asoundlib.h"

typedef char * (*ALSAProc)(void);

int main()
{
void *lib_handle;
void *fn;
char * str;

lib_handle=dlopen("mysharedlib.so",RTLD_NOW);
if (lib_handle)
    {
    fn=dlsym(lib_handle,"ALSATest");

     if(fn) str=((ALSAProc)fn)();
     else str="function not found";
     }
else   str="lib not found";

fprintf(stderr,"%s\n",str);

if(lib_handle) dlclose(lib_handle); 
    return 0;
}
-------------

I get unpredictable results.
Either;
- it crashes in snd_pcm_hw_params_any (in the subroutine 
snd_pcm_hw_params_refine) 
or 
- it outputs "ALSA is not working (val2=0 err=2147483647)"
or
- it outputs ALSA is not working (val2=2147483647 err=2147483647)"

Does anyone have an idea of what could cause this behaviour?

Olivier
