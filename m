From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: aserver, smix
Date: Sat, 1 Mar 2003 08:57:04 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303010856420.1351-100000@pnote.perex-int.cz>
References: <3E605D1B.2010207@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E605D1B.2010207@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 1 Mar 2003, Patrick Shirkey wrote:

> Jaroslav Kysela wrote:
> 
> > Note that we have actually the experimental dmix plugin (direct mixing) 
> > which works for i386 architecture in CVS. The usage is simple:
> > 
> > aplay -Dplug:dmix <filename>
> > 
> > You may pass 'plug:dmix' to any other application.
> > 
> 
> When I try this I get this error:
> 
> ~$ aplay -D plug:dmix -f cd track_8.wav
> ALSA lib pcm_hw.c:371:(snd_pcm_hw_sw_params) SNDRV_PCM_IOCTL_SW_PARAMS 
> failed: Invalid argument
> ALSA lib pcm_dmix.c:1378:(snd_pcm_dmix_initialize_slave) unable to 
> install sw params
> ALSA lib pcm_dmix.c:1534:(snd_pcm_dmix_open) unable to initialize slave
> 
> aplay: main:479: audio open error: Invalid argument
> 
> Using the example for the .asoundrc file in the original dmix thread is 
> the same.
> 
> ~$ aplay -D dmix -f cd track_8.wav
> ALSA lib pcm_hw.c:371:(snd_pcm_hw_sw_params) SNDRV_PCM_IOCTL_SW_PARAMS 
> failed: Invalid argument
> ALSA lib pcm_dmix.c:1378:(snd_pcm_dmix_initialize_slave) unable to 
> install sw params
> ALSA lib pcm_dmix.c:1534:(snd_pcm_dmix_open) unable to initialize slave
> 
> aplay: main:479: audio open error: Invalid argument

Are you using latest CVS drivers? Previous drivers are not compatible.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
