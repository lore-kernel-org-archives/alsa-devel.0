From: Rene Herman <rene.herman@gmail.com>
Subject: isa_bus: gusclassic
Date: Sun, 18 Feb 2007 20:48:19 +0100
Message-ID: <45D8AD83.4000704@gmail.com>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Good day.

===
gusclassic: port to isa_bus infrastructure

Signed-off-by: Rene Herman <rene.herman@gmail.com>
===

snd_gusclassic_init() is no more -- the flags are already initialized to 
0 as part of the snd_gus_card structure itself and while I sort of 
expect that the C standard won't have many positive things to say about 
initializing bitfields through a kzalloc(), the code relies on this for 
other flags as well. The joystick_dac value is set directly in probe() 
now (I saw it's the same in all gus variants so should probably at some 
point be moved to snd_gus_create).

This has been tested, and works the same as before, which is to say not 
quite right.

It plays okay through ALSA's OSS emulation, but native ALSA complains:

   ALSA lib pcm.c:2017:(snd_pcm_open_conf) Invalid type for PCM
   default definition (id: default, value: cards.pcm.default)
   ALSA snd_pcm_open error: Invalid argument

Using "hw:0" gets:

   ALSA snd_pcm_hw_params_set_access error: Invalid argument

and "plughw:0" gets:

   ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
   find an usable access for 'plughw:0'
   ALSA snd_pcm_hw_params_set_access error: Invalid argument

Although I'm familiar with the ALSA kernel side, I can't say the same 
about the userland or the interaction between the two and this looks 
like it might be a problem at that level. So I thought I'd just ask 
you... ;-)

(but as said, patch is good to go)

Rene.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
