From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Missing symbols since 1.0.14rc1
Date: Thu, 08 Mar 2007 08:14:45 -0800
Message-ID: <1173370485.4531.69.camel@razman.gruemaster.com>
References: <1173308974.4531.19.camel@razman.gruemaster.com>
	<s5hmz2nkewf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmz2nkewf.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-03-08 at 15:07 +0100, Takashi Iwai wrote:
> At Wed, 07 Mar 2007 15:09:34 -0800,
> Tobin Davis wrote:
> > 
> > I had a couple of users report that alsa-driver-1.0.14rc2 and alsa-driver-1.0.14rc3
> > would no longer load due to missing symbols.  I am able to reproduce this on a RedHat
> > Enterprise Linux 4 update 4 kernel (2.6.9-42.0.0.0.1.EL) after modifying ./alsa-driver
> > /include/adriver.h to not typedef gfp_t (Redhat pulled that typedef in starting with
> > 4U3).
> 
> Oh that RH kernel... Since I personally never used RH kernels, it's
> hard to debug.  Could you check whether it has any RH-specific defines
> or such so that we can add another ifdef, e.g. #ifdef
> CONFIG_REDHAT_KERNEL or so...?

No, nothing that I can find.  That of course would be too easy.

> 
> > The error when loading snd.ko is:
> > 
> >     snd:  Unknown symbol sound_class1
> >     FATAL:  Error inserting snd (<path to module>): Unknown symbol in module, or
> >     unknown parameter (see dmesg).
> > 
> > dmesg reports the same thing.
> > 
> > This worked fine in 1.0.14rc1.  I'm looking through the change logs to see what may
> > have broken it.
> 
> Looks like a typo during conversion.  Simply replace from sound_class1
> to sound_class in alsa-driver/acore/sound.c.
> 

The change took place in the "reflect 'struct device *' changes from
2.6, add SND_AC97_BUS kernel dependancy" patch from Dec 15.  Patch ID
3208:965d76adda57.  

The patch you just added, while correcting the typo, now creates a
compiler error:

         CC [M]  /usr/src/alsa/alsa-driver-1.0.14rc2/acore/sound.o
        /usr/src/alsa/alsa-driver-1.0.14rc2/acore/sound.c:72: error:
        conflicting types for 'sound_class'
        /usr/src/alsa/alsa-driver-1.0.14rc2/include/sound/core.h:198:
        error: previous declaration of 'sound_class' was here
        /usr/src/alsa/alsa-driver-1.0.14rc2/acore/sound.c:72: error:
        conflicting types for 'sound_class'
        /usr/src/alsa/alsa-driver-1.0.14rc2/include/sound/core.h:198:
        error: previous declaration of 'sound_class' was here
        /usr/src/alsa/alsa-driver-1.0.14rc2/acore/sound.c: In function
        `snd_open':
        /usr/src/alsa/alsa-driver-1.0.14rc2/acore/sound.c:171: warning:
        assignment discards qualifiers from pointer target type
        /usr/src/alsa/alsa-driver-1.0.14rc2/acore/sound.c:176: warning:
        assignment discards qualifiers from pointer target type
        make[4]: *** [/usr/src/alsa/alsa-driver-1.0.14rc2/acore/sound.o]
        Error 1

And I'm not sure if it will break other distributions or not.  There is
always the off chance that this is also a Redhat backporting issue, rare
as it seams. :) 

I'm looking it over now and will let you know what I find.


-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
