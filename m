From: "Brandon Yates" <Brandon.Yates@adaptivedigital.com>
Subject: Plug In Creation - aplay can't find existing .so
Date: Tue, 10 Jun 2014 13:55:39 -0400
Message-ID: <B02206F4ACA2904A8270028316B8DAFF01149EA3@mercury.corp.adaptivedigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.9]) by alsa0.perex.cz (Postfix) with ESMTP id A7686265527
 for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2014 19:55:41 +0200 (CEST)
Content-class: urn:content-classes:message
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

Hello,

I am working on a new pcm plugin. At this point it is basically just a
Hello World plugin, to make sure I have the tools working and understand
the workflow.  I created a simple file which is just basically:

#include <alsa/asoundlib.h>
#include <alsa/pcm_external.h>
SND_PCM_PLUGIN_DEFINE_FUNC(my_mod)
{	
   printf("hello world\n");
   return 0;
}
SND_PCM_PLUGIN_SYMBOL(my_mod);


I compiled this as a shared lib named  'libasound_module_pcm_my_mod.so'
and copied it to '/usr/lib/i386-linux-gnu/alsa-lib/'

I edited my ~/.asoundrc to create a new device that uses this plugin.
Then I try to use it with `aplay --device=my_mod_test out.pcm`

I get the error message

ALSA lib dlmisc.c:254:(snd1_dlobj_cache_get) Cannot open shared library
/usr/lib/i386-linux-gnu/alsa-lib/libasound_module_pcm_my_mod.so
aplay: main:682: audio open error: No such device or address


But this file actually does exist, I just copied it there.


Any idea why this happens?

Thanks much,
Brandon
