From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa - 0.9.8 (and today's cvs - 16.11.2003) interwave
 problem.
Date: Sun, 16 Nov 2003 18:35:13 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0311161834220.16992@pnote.perex-int.cz>
References: <3FB8F17B.3010505@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FB8F17B.3010505@web.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nima Ghassemi <ngn928@web.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Nov 2003, Nima Ghassemi wrote:

> hi,
>
> there's some problem which I tracked down to
>
> ~alsa-driver/sound/core/control.c
>
> int snd_ctl_add(snd_card_t * card, snd_kcontrol_t * kcontrol)
> {
>         snd_ctl_elem_id_t id;
>         unsigned int idx;
>
>     snd_runtime_check(card != NULL && kcontrol != NULL, return -EINVAL);
>         snd_assert(kcontrol->info != NULL, return -EINVAL);
>         id = kcontrol->id;
>         down_write(&card->controls_rwsem);
>     if (_ctl_find_id(card, &id)) {
>                 up_write(&card->controls_rwsem);
>                 snd_ctl_free_one(kcontrol);
>                 return -EBUSY;
>     }
> [...]
>
> the problem lies in _ctl_find_id (card, &id). by commenting the if-block
> out, everything (as well
> as the sound-card) works perfectly (as far as I could test it...).

Can you add some printk's to determine which id is causing the problem so
we can fix it? Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
