From: Janina Sajka <janina@rednote.net>
Subject: Re: No dmix with HDSP Multiface
Date: Wed, 23 Mar 2005 10:59:08 -0500
Message-ID: <20050323155908.GW8178@rednote.net>
References: <20050322180510.GA8180@rednote.net> <s5hfyymqwjo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hfyymqwjo.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai writes:
> At Tue, 22 Mar 2005 13:05:10 -0500,
> Janina Sajka wrote:
> > 
> > I have 1.0.9RC1 compiled and installed--but cannot get dmix to work. Am
> > I going about it wrong? Or are there still known issues with dmix using
> > RME hardware? Mine is a HDSP Multiface. Here's what I get:
> >... snip snip ...
 
> The dmix PCM definition was slightly changed recently.  It no longer
> takes SLAVE argument but CARD, DEV and SUBDEV.  For hw:0,0, it's like
> 	dmix:CARD=0,DEV=0,RATE=48000
> 
> The default card and device are both 0, and the default rate is 48000,
> in the case above, you don't need to pass arguments.  Just run like
> 
> 	% aplay -Dplug:dmix foo.wav

Still no sound, though:

#aplay -Dplug:dmix Any_Dream_Will_Do.wav
ALSA lib pcm_direct.c:741:(snd_pcm_direct_initialize_slave) unable to
install hw params
ALSA lib pcm_dmix.c:728:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:508: audio open error: Device or resource busy

PS: I'm also unable to address the mixer on the Multiface via amixer.
amixer contents includes:

numid=5,iface=HWDEP,name='Mixer'
  ; type=INTEGER,access=rw---,values=3,min=0,max=65536,step=1
  : values=0,0,65535

But, this was set using hdspmixer. I cannot seem to divine what
incantation to use to affect anything on numid=5 from the command line.

Is this possibly related?

				Janina

> 
> 
> Takashi

-- 

Janina Sajka				Phone: +1.202.494.7040
Partner, Capital Accessibility LLC	http://www.CapitalAccessibility.Com

Chair, Accessibility Workgroup		Free Standards Group (FSG)
janina@freestandards.org		http://a11y.org

If Linux can't solve your computing problem, you need a different problem.



-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
