From: "scott andrew franco" <samiam@moorecad.com>
Subject: Building the alsa library
Date: Sat, 15 Jun 2019 13:41:03 -0700
Message-ID: <20190615134103.6c61c97e98fe7bb02193b2d6dca4a85a.50a60f16a4.mailapi@email03.godaddy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p3plwbeout03-04.prod.phx3.secureserver.net
 (p3plsmtp03-04-2.prod.phx3.secureserver.net [72.167.218.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 558CFF80764
 for <alsa-devel@alsa-project.org>; Sat, 15 Jun 2019 22:41:41 +0200 (CEST)
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

Hi,
 
I have been trying to solve a difficult issue using the ALSA library. To solve it, I need to be able to
debug into the ALSA library.
 
I tried to build it from the sources, from the alsa-lib-1.1.9 library source to be specific.
 
Problems:
 
Using the build procedure in the INSTALL file, it appeared to build but I could not find a libasound.so file
anywhere.
 
I also tried the recommended procedure for static linking, also from the INSTALL file. That gives a 
./src/.libs/libasound.a file (indeed, this gets generated on a dynamic link as well, which I don't understand).
 However, linking with that produces (after adding back a few missing libs):
 samiam@samiam-linux-pc:~/scratch$ ./hello
This is a test program
ALSA lib conf.c:3558:(snd_config_hooks_call) Cannot open shared library libasound_module_conf_pulse.so (/usr/lib/alsa-lib/libasound_module_conf_pulse.so: libasound_module_conf_pulse.so: cannot open shared object file: No such file or directory)
ALSA lib pcm.c:2564:(snd_pcm_open_noupdate) Unknown PCM default
Program complete
 IE., it is linking pulse audio? Or do I need another .a file from the library collection?
 Notes: here is the .a files from the alsa-lib build:
 samiam@samiam-linux-pc:~/projects/alsa/alsa-lib-1.1.9$ find . -name *.a
./src/pcm/.libs/libpcm.a
./src/seq/.libs/libseq.a
./src/rawmidi/.libs/librawmidi.a
./src/ucm/.libs/libucm.a
./src/timer/.libs/libtimer.a
./src/topology/.libs/libtopology.a
./src/hwdep/.libs/libhwdep.a
./src/mixer/.libs/libmixer.a
./src/control/.libs/libcontrol.a
./src/.libs/libasound.a
 Here is the test file I am building (hello.c):
 #include <stdio.h>
#include <alsa/asoundlib.h>
 int main(void)
 {
 snd_pcm_t *pcm_handle;
 printf("This is a test program\n");
 snd_pcm_open(&pcm_handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
 printf("Program complete\n");
 
}
 Here is the line used to compile it:
 gcc -static -o hello hello.c libasound.a -pthread -lm -ldl
 Thanks in advance.
 Scott Franco
