From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: aserver, smix
Date: Sat, 01 Mar 2003 16:11:23 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E605D1B.2010207@boosthardware.com>
References: <Pine.LNX.4.44.0302262031060.1114-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

> Note that we have actually the experimental dmix plugin (direct mixing) 
> which works for i386 architecture in CVS. The usage is simple:
> 
> aplay -Dplug:dmix <filename>
> 
> You may pass 'plug:dmix' to any other application.
> 

When I try this I get this error:

~$ aplay -D plug:dmix -f cd track_8.wav
ALSA lib pcm_hw.c:371:(snd_pcm_hw_sw_params) SNDRV_PCM_IOCTL_SW_PARAMS 
failed: Invalid argument
ALSA lib pcm_dmix.c:1378:(snd_pcm_dmix_initialize_slave) unable to 
install sw params
ALSA lib pcm_dmix.c:1534:(snd_pcm_dmix_open) unable to initialize slave

aplay: main:479: audio open error: Invalid argument

Using the example for the .asoundrc file in the original dmix thread is 
the same.

~$ aplay -D dmix -f cd track_8.wav
ALSA lib pcm_hw.c:371:(snd_pcm_hw_sw_params) SNDRV_PCM_IOCTL_SW_PARAMS 
failed: Invalid argument
ALSA lib pcm_dmix.c:1378:(snd_pcm_dmix_initialize_slave) unable to 
install sw params
ALSA lib pcm_dmix.c:1534:(snd_pcm_dmix_open) unable to initialize slave

aplay: main:479: audio open error: Invalid argument


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
