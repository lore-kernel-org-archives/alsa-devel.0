From: Gerald Grabner <gerald.grabner@gmx.net>
Subject: hw_params from shared library problem
Date: Mon, 26 Jun 2006 23:11:23 +0200
Message-ID: <44A04D7B.1070002@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi everybody,

I'm wondering how to correctly build a shared library using alsa
pcm. Setting the hardware parameters in a function which is part of a
shared library produces an error, snd_pcm_hw_params gives "invalid
argument". The example below with three primitive files (main file,
header and function code) illustrates the problem. With a static
library, everything works fine.

My system: gcc 3.4.6 on Gentoo with alsa 1.0.11.

Does anybody have an idea about the cause of this problem or how to 
solve it?

Many thanks,
Gerald

***

main.c:
   #include "object.h"
   int main()
   {
     object () ;
     return 0;
   }

object.h:
   void object();

object.c:
   #include <alsa/asoundlib.h>
   #include "object.h"
   void object ()
   {
     snd_pcm_t* pcm;
     snd_pcm_hw_params_t* hwparams;
     int rc;
     unsigned int rate = 44100;
     unsigned int channels = 2;
     int dir = 0;
     if ( snd_pcm_open(&pcm, "default", SND_PCM_STREAM_PLAYBACK, 0) < 0 )
       printf("Cannot open pcm.\n");
     snd_pcm_hw_params_alloca(&hwparams);
     snd_pcm_hw_params_any(pcm, hwparams);
     snd_pcm_hw_params_set_access(pcm, hwparams, 
SND_PCM_ACCESS_RW_INTERLEAVED);
     snd_pcm_hw_params_set_format(pcm, hwparams, SND_PCM_FORMAT_S16_LE);
     snd_pcm_hw_params_set_channels (pcm, hwparams, channels);
     snd_pcm_hw_params_set_rate_near(pcm, hwparams, &rate, &dir);
     rc = snd_pcm_hw_params(pcm, hwparams) ;
     if ( rc < 0 )
       printf("Error setting hw params: %s.\n", snd_strerror(rc));
   }

Compilation:
   gcc -c -fPIC object.c
   gcc -shared -fPIC -o libTest.so object.o
   gcc -o main main.c -L. -lTest -lasound

Output:
   Error setting hw params: Invalid argument.

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
