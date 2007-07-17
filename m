From: Pavel Kysilka <pavelk@bsys.cz>
Subject: Re: cs46xx thinkpad resume fix - #bug1946
Date: Wed, 18 Jul 2007 00:26:42 +0200
Message-ID: <20070717222642.GA28159@prog3>
References: <20070714155552.GA2896@prog3> <s5h8x9gya3m.wl%tiwai@suse.de>
	<s5hps2rwbgy.wl%tiwai@suse.de>
Reply-To: Pavel Kysilka <pavelk@bsys.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rak.bsys.cz (bsys.cz [88.86.106.116])
	by alsa0.perex.cz (Postfix) with ESMTP id EAECB1037FB
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jul 2007 00:26:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hps2rwbgy.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue Jul 17, 2007 at 12:50:21PM +0200, Takashi Iwai wrote:

  Hi Takashi,

good news below.

> At Mon, 16 Jul 2007 11:24:45 +0200,
> I wrote:
> > 
> > 
<cut/>
> > Oh, thanks for hunting this long-standing bug!
> > 
> > I think, however, it cannot be applied as it is.
> > First, snd_cs46xx_start_dsp() calls cs46xx_dsp_load_module(), and the
> > latter function isn't designed for the PM resume.  We'd need a special
> > resume function just for clearing area & reloading the dsp images
> > according to the already loaded DSP modules.
> > 
> > Second, __devinit prefix for snd_cs46xx_start_dsp() has to be removed
> > if it's called from the PM handler.
> 
> Looking at the code more deeply, I suspect whether it really works
> when CONFIG_SND_CS46XX_NEW_DSP=y.  snd_cs46xx_start_dsp() involves
> with many calls that add SCBs and co, which will eventually overflow.
> 
> I made a patch blindly to do the resume work in a saner way, but of
> course, it's totally untested.  Could you check whether it works?

Patch works perfectly.

Tested option:
- kernel compiled with and without CONFIG_SND_CS46XX_NEW_DSP=y
- play pcm stream, suspend, resume and pcm stream is playing
- play pcm stream, stop playing pcm stream, suspend, resume and play pcm stream

If you need log from resume from notebook, I'll send you this log.

> 
> 
> thanks,
> 
> Takashi
> 

 Many thanks
    Pavel


________ Information from NOD32 ________
This message was checked by NOD32 Antivirus System for Linux Mail Servers.
http://www.eset.com
