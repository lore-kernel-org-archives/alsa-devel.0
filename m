From: Linux Coder <linux@thehoytfamily.com>
Subject: Calls from a custom dynamic shared library call the wrong version
 of alsa functions in libasound
Date: Wed, 10 Aug 2005 22:22:15 -0400
Message-ID: <42FAB657.2070307@thehoytfamily.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I had created a library that is a dynamic shared library. Within this 
library, calls are made to the ALSA Lib (libasound) but the wrong 
version of the call is being made. If a single step through, it will 
call __OLD_GET1(...). If my library is not a dynamic shared library then 
the correct call is made.
Am I doing something wrong or is the dynamic linker resolving to the 
wrong version of the ALSA function call and there is not anything I can do?

The following is a useless program that demonstrates the issue

alibtest.h:

#ifndef _ALIBTEST_H_
#define _ALIBTEST_H_

int GetBufferTime(void);

#end

alibtest.cpp:

#include <alib/asoundlib.h>
#include "alibtest.h"

int GetBufferTime(void)
{
  int direction;
  unsigned int buffer_time;
  int err;
  snd_pcm_hw_params_t *params;

  err = 
snd_pcm_hw_params_get_buffer_time_max(params,&buffer_time,&direction);
  return err;
}

alsatest.cpp:

#include "alibtest.h"

int main()
{
  int err;
  err = GetBufferTime();
  return 0;
}

g++ -fPIC -gstabs+ -O0 -Wall alibtest.cpp
g++ -shared -Wl,-soname,libalibtest.so.1 -o libalibtest.so.1.0.1 
alibtest.o -lc
ln -s libalibtest.so.1.0.1 libalibtest.so
ln -s libalibtest.so.1.0.1 libalibtest.so.1
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.
g++ -gstabs+ -O0 -o alsatest alsatest.cpp -lasound -lalibtest -L.

If you the program throught the debugger and step through the 
snd_pcm_hw_params_get_buffer_time_max, it will go to 
__OLD_GET1(snd_pcm_hw_params_get_buffer_time_max, unsigned int, unsigned 
int);

Thus it tries to return the buffer time versus setting the variable 
buffer_time and returning error.

If I do a nm on the shared library, it will show 
snd_pcm_hw_params_get_buffer_time_max. If I make a static library, it 
will show the same thing, but when it is linked, the executable will 
show snd_pcm_hw_params_get_buffer_time_max@@ALSA_0.9.0rc4

Thanks



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
