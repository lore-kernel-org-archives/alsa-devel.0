From: "John E. A." <johnea@cox.net>
Subject: Re: Re: [Alsa-user] cs46xx w/ alsa 0.9.0rc3 on RedHat 7.1
 -sysloging
Date: Tue, 24 Sep 2002 13:14:03 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D90C78B.4EB1C12A@cox.net>
References: <3D8BC3F2.A0FB9ED7@cox.net>
		<3D8C6DF2.60201@cucumelo.org> <s5hfzw1ovdc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Benny Sjostrand <gorm@cucumelo.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> At Sat, 21 Sep 2002 15:02:42 +0200,
> Benny Sjostrand wrote:
> >
> > >
> > >
> > >Sep 20 17:32:48 JOHN-ANDREWS kernel: ALSA
> > >../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:767: BUG? (cpcm->pcm_channel)
> > >(called from d087abc1)
> > >Sep 20 17:32:48 JOHN-ANDREWS kernel: ALSA
> > >../alsa-kernel/core/pcm_lib.c:176: BUG: stream = 0, pos = 0xfffffffa,
> > >buffer size = 0x400, period size = 0x200
> > >
> > >
> > >
> > Have the cs46xx driver ever been tested without
> > CONFIG_SND_CS46XX_NEW_DSP defined ?
> > I believe the the old cs46xx code is broken, i've never tested it my self.
> > The cs46xx_lib.c is becoming dificult to mantain with all #ifdef ...
> > #endif, I would prefer
> > someday remove all the old stuff. Is there any known card that dont work
> > with the
> > new DSP code ??
> 
> i changed the alsa-driver cvs to use the new dsp image as default, so
> we might see more reports in future.
> 
> Takashi

Hello ALSA developers,

Thank You Mr. Sjostrand and Takashisan for your helpful replies!

In order to avoid confusion with other changes that are certainly in cvs
since the rc3 release I uncommented the CONFIG_SND_CS46XX_NEW_DSP
definition in pci/cs46xx/Makefile instead of checking out a completely
new source tree. 

This lead me to a problem with an undefined symbol for snprintf in
snd-cs46xx.o (I'm running a 2.4.2 kernel) which I worked around with a
hack to dsp_spos_scb_lib.c in alsa-kernel/pci/cs46xx:

#define snprintf(buf,size,fmt,args) sprintf(buf,fmt,args)

I found a similar hack in include/asound.h for vsnprintf(), however
adding the above line to this header didn't eliminate the undefined
symbol in snd-cs46xx.o. Apparently asound.h doesn't make in into
dsp_spos_scb_lib.c.

After getting around my library deficiencies I was able to load the
snd-cs46xx module and can report that I no longer have the syslogging
problem I was experiencing with xmms playing mpeg video (playing
internet streaming audio and local mp3 and wav sound files had never
been a problem).

My hardware platform is the integrated sound in an IBM Thinkpad T-20.

It may just be a subjective reaction to getting this new build running,
but I also believe that streaming audio sounds crisper and clearer with
this new driver.

Thank You Once Again for your help! I stand ready to supply any other
configuration information or provide any other meager assistance of
which I'm capable.

John E. A.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
