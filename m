From: "Paul Hanly \(Hotmail\)" <paulhanly@hotmail.com>
Subject: Re: alsa - 0.9.8 (and today's cvs - 16.11.2003) interwave problem.
Date: Mon, 17 Nov 2003 12:40:18 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BAY2-DAV34GMrbmaMxb000031da@hotmail.com>
References: <3FB8F17B.3010505@web.de> <Pine.LNX.4.53.0311161834220.16992@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Jaroslav Kysela <perex@suse.cz>, Nima Ghassemi <ngn928@web.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I don't know if this is related but under Mdk 9.1 I also get problems with
core:

[root@localhost alsa-driver-0.9.8]# modprobe snd-au8820
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: unresolved symbol
_snd_magic_kcalloc
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: unresolved symbol
snd_hidden_vfree
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: unresolved symbol
snd_magic_kfree
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: unresolved symbol
snd_hidden_kfree
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: unresolved symbol
snd_memory_info_done
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: unresolved symbol
snd_memory_info_init
/lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o: unresolved symbol
snd_hidden_vmalloc
modprobe: insmod /lib/modules/2.4.21-0.13mdk/kernel/sound/acore/snd.o failed
modprobe: insmod snd-au8820 failed

If I:
urpmi kernel-source
it tells me everything is already installed.
If I modprobe or insmod kernel-source it can't find the module
kernel-source.
Please tell me I don't have to recompile the kernel!!!

Cheers
Paul

----- Original Message ----- 
From: "Jaroslav Kysela" <perex@suse.cz>
To: "Nima Ghassemi" <ngn928@web.de>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Monday, November 17, 2003 4:35 AM
Subject: Re: [Alsa-devel] alsa - 0.9.8 (and today's cvs - 16.11.2003)
interwave problem.


> On Mon, 17 Nov 2003, Nima Ghassemi wrote:
>
> > hi,
> >
> > there's some problem which I tracked down to
> >
> > ~alsa-driver/sound/core/control.c
> >
> > int snd_ctl_add(snd_card_t * card, snd_kcontrol_t * kcontrol)
> > {
> >         snd_ctl_elem_id_t id;
> >         unsigned int idx;
> >
> >     snd_runtime_check(card != NULL && kcontrol != NULL, return -EINVAL);
> >         snd_assert(kcontrol->info != NULL, return -EINVAL);
> >         id = kcontrol->id;
> >         down_write(&card->controls_rwsem);
> >     if (_ctl_find_id(card, &id)) {
> >                 up_write(&card->controls_rwsem);
> >                 snd_ctl_free_one(kcontrol);
> >                 return -EBUSY;
> >     }
> > [...]
> >
> > the problem lies in _ctl_find_id (card, &id). by commenting the if-block
> > out, everything (as well
> > as the sound-card) works perfectly (as far as I could test it...).
>
> Can you add some printk's to determine which id is causing the problem so
> we can fix it? Thanks.
>
> Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
>
>
> -------------------------------------------------------
> This SF. Net email is sponsored by: GoToMyPC
> GoToMyPC is the fast, easy and secure way to access your computer from
> any Web browser or wireless device. Click here to Try it Free!
> https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
