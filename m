From: Michael <katakis@freenet.de>
Subject: capture problem with maestro2
Date: Fri, 04 Mar 2005 18:26:47 +0100
Message-ID: <42289A57.1090005@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I have a capture problem with ALSA on a 2.6.10 kernel with a maestro2 
soundcard. Teamspeak doesn't work and i get this line in my teamspeak 
log file:

04-03-05 12:14:33,11835,ERROR,All,TOSSioThread.execute,Exception 
EOSSException: OSS error in InputSound: Invalid argument


I examined the problem and found out that with the following changes, 
everything works fine.

diff -rup sound/core/pcm_lib.c sound_new/core/pcm_lib.c
--- sound/core/pcm_lib.c        2005-03-04 12:14:00.951071880 +0100
+++ sound_new/core/pcm_lib.c    2005-03-04 12:23:19.734123944 +0100
@@ -2561,8 +2561,6 @@ snd_pcm_sframes_t snd_pcm_lib_read(snd_p
                }
        }
 #endif
-       if (runtime->access != SNDRV_PCM_ACCESS_RW_INTERLEAVED)
-               return -EINVAL;
        return snd_pcm_lib_read1(substream, (unsigned long)buf, size, 
nonblock, snd_pcm_lib_read_transfer);
 }


The function "snd_pcm_lib_read" gets called from the oss-emulation 
layer. But since the maestro2 only supports non-interleaved capture it 
returns EINVAL. Suprisingly, if the check for 
"SNDRV_PCM_ACCESS_RW_INTERLEAVED" is removed,  mono and stereo recording 
works! I don't know why.
Maybe someone with more ALSA insight could take a look at it and find a 
cleaner solution.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
