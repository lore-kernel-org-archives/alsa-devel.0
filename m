From: Nima Ghassemi <ngn928@web.de>
Subject: alsa - 0.9.8 (and today's cvs - 16.11.2003) interwave problem.
Date: Mon, 17 Nov 2003 17:04:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB8F17B.3010505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,

there's some problem which I tracked down to

~alsa-driver/sound/core/control.c

int snd_ctl_add(snd_card_t * card, snd_kcontrol_t * kcontrol)
{
        snd_ctl_elem_id_t id;
        unsigned int idx;

    snd_runtime_check(card != NULL && kcontrol != NULL, return -EINVAL);
        snd_assert(kcontrol->info != NULL, return -EINVAL);
        id = kcontrol->id;
        down_write(&card->controls_rwsem);
    if (_ctl_find_id(card, &id)) {
                up_write(&card->controls_rwsem);
                snd_ctl_free_one(kcontrol);
                return -EBUSY;
    }
[...]

the problem lies in _ctl_find_id (card, &id). by commenting the if-block 
out, everything (as well
as the sound-card) works perfectly (as far as I could test it...).

this is the error-message I get when I leave eveything as it is:
----------------------------------------
root@sipiyou :/tmp/alsa/alsa-driver> modprobe snd-interwave
/lib/modules/2.4.22/kernel/sound/isa/gus/snd-interwave.o: init_module: 
No such device
Hint: insmod errors can be caused by incorrect module parameters, 
including invalid IO or IRQ parameters
/lib/modules/2.4.22/kernel/sound/isa/gus/snd-interwave.o: insmod 
/lib/modules/2.4.22/kernel/sound/isa/gus/snd-interwave.o failed
/lib/modules/2.4.22/kernel/sound/isa/gus/snd-interwave.o: insmod 
snd-interwave failed
----------------------------------------
/etc/modules.conf:
options snd-interwave index=0 id="GusPnP" enable=1 port=0x220 irq=11 
dma1=5 dma2=7

this is my config:
- devfs
- kernel 2.4.22
- amd interwave (ultrasound pnp)


Nima.


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
