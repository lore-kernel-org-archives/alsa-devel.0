From: Janina Sajka <janina@rednote.net>
Subject: Re: No dmix with HDSP Multiface
Date: Mon, 28 Mar 2005 16:12:48 -0500
Message-ID: <20050328211248.GG7520@rednote.net>
References: <20050322180510.GA8180@rednote.net> <s5hfyymqwjo.wl@alsa2.suse.de> <20050323155908.GW8178@rednote.net> <s5hy8cel1mx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hy8cel1mx.wl@alsa2.suse.de>
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
Cc: Janina Sajka <janina@rednote.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Takashi Iwai writes:
> At Wed, 23 Mar 2005 10:59:08 -0500,
> Janina Sajka wrote:
> > 
> > Takashi Iwai writes:
> > > At Tue, 22 Mar 2005 13:05:10 -0500,
> > > Janina Sajka wrote:
> > > > 
> > > > I have 1.0.9RC1 compiled and installed--but cannot get dmix to work. Am
> > > > I going about it wrong? Or are there still known issues with dmix using
> > > > RME hardware? Mine is a HDSP Multiface. Here's what I get:
> > > >... snip snip ...
> >  
> > > The dmix PCM definition was slightly changed recently.  It no longer
> > > takes SLAVE argument but CARD, DEV and SUBDEV.  For hw:0,0, it's like
> > > 	dmix:CARD=0,DEV=0,RATE=48000
> > > 
> > > The default card and device are both 0, and the default rate is 48000,
> > > in the case above, you don't need to pass arguments.  Just run like
> > > 
> > > 	% aplay -Dplug:dmix foo.wav
> > 
> > Still no sound, though:
> > 
> > #aplay -Dplug:dmix Any_Dream_Will_Do.wav
> > ALSA lib pcm_direct.c:741:(snd_pcm_direct_initialize_slave) unable to
> > install hw params
> 
> You need to specify FORMAT=S32_LE in the case of HDSP.
> Add the following to ~/.asoundrc:
> 
> mydmix {
> 	type plug
> 	slave.pcm "dmix:FORMAT=S32_LE"
> }		
> 
> 
> Takashi
Regret to say still no response:

aplay -Dplug:dmix Any_Dream_Will_Do.wav
ALSA lib pcm_direct.c:741:(snd_pcm_direct_initialize_slave) unable to
install hw params
ALSA lib pcm_dmix.c:728:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:508: audio open error: Device or resource busy
[root@concerto

Perhaps I misunderstand .asoundrc? Since that's very possible, I'm
attaching my current. Works to play directly and via spdif, but not
dmix
Thanks.
.


-- 

Janina Sajka				Phone: +1.202.494.7040
Partner, Capital Accessibility LLC	http://www.CapitalAccessibility.Com

Chair, Accessibility Workgroup		Free Standards Group (FSG)
janina@freestandards.org		http://a11y.org

If Linux can't solve your computing problem, you need a different problem.


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".asoundrc"

pcm.hdsp {
        type hw
        card 0
}
ctl.hdsp {
        type hw
        card 0
}

pcm.hdsp_analog {
        type plug
        ttable.0.0 1
        ttable.1.1 1
        ttable.2.2 1
        ttable.3.3 1
        ttable.4.4 1
        ttable.5.5 1
        ttable.6.6 1
        ttable.7.7 1
        slave.pcm hdsp
}


pcm.hdsp_spdif {
    type plug
    ttable.0.16 1
    ttable.1.17 1
    slave.pcm hdsp
}

mydmix {
        type plug
        slave.pcm "dmix:FORMAT=S32_LE"
}
 

--J2SCkAp4GZ/dPZZf--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
