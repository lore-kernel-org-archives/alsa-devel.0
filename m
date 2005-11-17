From: "Theodoros V. Kalamatianos" <thkala@softlab.ece.ntua.gr>
Subject: make check fails for alsa-lib-1.0.10
Date: Thu, 17 Nov 2005 15:11:13 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0511171503140.14100@rhama.deepcore.ngn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

This is a rather minor problem: make check fails for alsa-lib-1.0.10 with 
the following error:


if gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include   -static -Wall -pipe -g -O3 -fomit-frame-pointer -pipe -march=pentium-m  -MT omixer.o -MD -MP -MF ".deps/omixer.Tpo" \
   -c -o omixer.o `test -f 'omixer.c' || echo './'`omixer.c; \
then mv -f ".deps/omixer.Tpo" ".deps/omixer.Po"; \
else rm -f ".deps/omixer.Tpo"; exit 1; \
fi
In file included from omixer.c:7:
../include/pcm.h:398: error: parse error before "snd_config_t"
../include/pcm.h:405: warning: "struct pollfd" declared inside parameter list
../include/pcm.h:405: warning: its scope is only this definition or declaration, which is probably not what you want
../include/pcm.h:406: warning: "struct pollfd" declared inside parameter list
../include/pcm.h:408: error: parse error before '*' token
../include/pcm.h:410: error: parse error before '*' token
../include/pcm.h:811: error: parse error before "snd_timestamp_t"
../include/pcm.h:812: error: parse error before "snd_htimestamp_t"
../include/pcm.h:813: error: parse error before "snd_timestamp_t"
../include/pcm.h:814: error: parse error before "snd_htimestamp_t"
../include/pcm.h:849: error: parse error before "snd_output_t"
../include/pcm.h:850: error: parse error before "snd_output_t"
../include/pcm.h:851: error: parse error before "snd_output_t"
../include/pcm.h:852: error: parse error before "snd_output_t"
../include/pcm.h:853: error: parse error before "snd_output_t"
../include/pcm.h:854: error: parse error before "snd_output_t"
../include/pcm.h:855: error: parse error before "snd_output_t"


It seems that the *_ordinary stuff was removed from everywhere but the 
testsuite. It's not really important, but it should probably be fixed in 
the next release - and bugs unreported are bugs not fixed :-)


Regards,

Theodoros Kalamatianos


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
