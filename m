From: Nima Ghassemi <ngn928@web.de>
Subject: Re: alsa - 0.9.8 (and today's cvs - 16.11.2003) interwave
 problem.
Date: Tue, 18 Nov 2003 10:18:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB9E3CA.2010204@web.de>
References: <3FB8F17B.3010505@web.de> <Pine.LNX.4.53.0311161834220.16992@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0311161834220.16992@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav!

here we go:
I added some printk's to these routines:
----------------------------------------------------------------------
int snd_ctl_add(snd_card_t * card, snd_kcontrol_t * kcontrol)
{
        snd_ctl_elem_id_t id;
        unsigned int idx;
        unsigned int dummy;

        printk ("_snd_ctl_add called (/sound/core/control.c)\n");
        snd_runtime_check(card != NULL && kcontrol != NULL, return -EINVAL);
        snd_assert(kcontrol->info != NULL, return -EINVAL);
        id = kcontrol->id;
        printk ("_snd_ctl_add:: kcontrol->id == %d\n",id);
    down_write(&card->controls_rwsem);
        if (_ctl_find_id(card, &id)) {
          printk ("bug here id=%d %d\n",id,-EBUSY);
                up_write(&card->controls_rwsem);
        snd_ctl_free_one(kcontrol);
                return -EBUSY;
                }
        if (card->last_numid > 0x80000000 && card->last_numid +
kcontrol->count < 0x80000000) {
                up_write(&card->controls_rwsem);
                snd_ctl_free_one(kcontrol);
                return -ENOMEM; /* FIXME: find a hole */
        }
        list_add_tail(&kcontrol->list, &card->controls);
           card->controls_count += kcontrol->count;
        kcontrol->id.numid = card->last_numid + 1;
        card->last_numid += kcontrol->count;
        up_write(&card->controls_rwsem);
        for (idx = 0; idx < kcontrol->count; idx++, id.index++, id.numid++)
                snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_ADD, &id);
    return 0;
}
----------------------------------------------------------------------
static snd_kcontrol_t *_ctl_find_id(snd_card_t * card, snd_ctl_elem_id_t
*id)
{
        struct list_head *list;
        snd_kcontrol_t *kctl;

        printk ("_ctl_find_id called (/sound/core/control.c)\n");
        snd_runtime_check(card != NULL && id != NULL, return NULL);
        if (id->numid != 0) {
          printk ("return _ctl_find_numid, id->numid != 0 , but
id->numid is = %X\n",id->numid);
                return _ctl_find_numid(card, id->numid);
        }
        list_for_each(list, &card->controls) {
          printk ("list_for_each(list, &card->controls)-loop start\n");
                kctl = snd_kcontrol(list);
                printk ("kctl->id.face = %X, id->iface =
%X\n",kctl->id.iface,id->iface);
                if (kctl->id.iface != id->iface) {
                        continue;
                }
                printk ("kctl->id.device = %X id->device=
%X\n",kctl->id.device,id->device);
                if (kctl->id.device != id->device) {
                  printk ("id.device not ok\n");
                        continue;
                }
                printk ("kctl->id.subdevice = %X
id->subdevice=%X\n",kctl->id.subdevice,id->subdevice);
                if (kctl->id.subdevice != id->subdevice) {
                        continue;
                }
                printk ("kctl->id.name = '%s' id->name=
'%s'\n",kctl->id.name,id->name);
                if (strncmp(kctl->id.name, id->name,
sizeof(kctl->id.name))) {
                        continue;
                }
                printk ("kctl->id.index = %X id->index =
%X\n",kctl->id.index,id->index);
                if (kctl->id.index > id->index) {
                        continue;
                }
                printk ("kctl->id.index + kctl->count <= (?) %X
id->index = %X\n",kctl->id.index+kctl->count,id->index);
                if (kctl->id.index + kctl->count <= id->index) {
                        continue;
                }
                printk ("list_for_each(list, &card->controls) exit
_ctl_find_id\n");
                return kctl;
        }
        printk ("_ctl_find_id return NULL\n");

        return NULL;
}
------------------------------------------------------------------------------------------
this is my syslog-output:

what bugs me is that the very first syslog message is crippled.

are there any problems with gcc 3.2.3 ?! (or with glibc 2.3.2)

Nov 18 10:05:41 sipiyou kernel: >id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Playback Switch'
id->name= 'Capture Volume'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Playback Volume'
id->name= 'Capture Volume'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Output Playback
Switch' id->name= 'Capture Volume'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Output Playback
Bypass' id->name= 'Capture Volume'
Nov 18 10:05:41 sipiyou kernel: _ctl_find_id return NULL
Nov 18 10:05:41 sipiyou kernel: _snd_ctl_add called (/sound/core/control.c)
Nov 18 10:05:41 sipiyou kernel: _snd_ctl_add:: kcontrol->id == 0
Nov 18 10:05:41 sipiyou kernel: _ctl_find_id called (/sound/core/control.c)
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'PCM Playback Switch'
id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'PCM Playback Volume'
id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Line Playback Switch'
id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Line Playback Volume'
id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Switch'
id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Volume'
id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Switch'
id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Volume'
id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Playback Switch'
id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Playback Volume'
id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Output Playback
Switch' id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Output Playback
Bypass' id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Capture Volume'
id->name= 'Capture Source'
Nov 18 10:05:41 sipiyou kernel: _ctl_find_id return NULL
Nov 18 10:05:41 sipiyou kernel: _snd_ctl_add called (/sound/core/control.c)
Nov 18 10:05:41 sipiyou kernel: _snd_ctl_add:: kcontrol->id == 0
Nov 18 10:05:41 sipiyou kernel: _ctl_find_id called (/sound/core/control.c)
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'PCM Playback Switch'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'PCM Playback Volume'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Line Playback Switch'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Line Playback Volume'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Switch'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Volume'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Switch'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Volume'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Playback Switch'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Playback Volume'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Output Playback
Switch' id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Output Playback
Bypass' id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Capture Volume'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Capture Source'
id->name= 'Mic Boost'
Nov 18 10:05:41 sipiyou kernel: _ctl_find_id return NULL
Nov 18 10:05:41 sipiyou kernel: _snd_ctl_add called (/sound/core/control.c)
Nov 18 10:05:41 sipiyou kernel: _snd_ctl_add:: kcontrol->id == 0
Nov 18 10:05:41 sipiyou kernel: _ctl_find_id called (/sound/core/control.c)
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'PCM Playback Switch'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'PCM Playback Volume'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Line Playback Switch'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Line Playback Volume'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Switch'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Volume'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Switch'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Aux Playback Volume'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Playback Switch'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Playback Volume'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Output Playback
Switch' id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mono Output Playback
Bypass' id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Capture Volume'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Capture Source'
id->name= 'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Mic Boost' id->name=
'Loopback Capture Switch'
Nov 18 10:05:41 sipiyou kernel: _ctl_find_id return NULL
Nov 18 10:05:41 sipiyou kernel: _snd_ctl_add called (/sound/core/control.c)
Nov 18 10:05:41 sipiyou kernel: _snd_ctl_add:: kcontrol->id == 0
Nov 18 10:05:41 sipiyou kernel: _ctl_find_id called (/sound/core/control.c)
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'PCM Playback Switch'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'PCM Playback Volume'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Line Playback Switch'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:41 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:41 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:41 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:41 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:41 sipiyou kernel: kctl->id.name = 'Line Playback Volume'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Aux Playback Switch'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Aux Playback Volume'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Aux Playback Switch'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Aux Playback Volume'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Mono Playback Switch'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Mono Playback Volume'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Mono Output Playback
Switch' id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Mono Output Playback
Bypass' id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Capture Volume'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Capture Source'
id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Mic Boost' id->name=
'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'Loopback Capture
Switch' id->name= 'Loopback Capture Volume'
Nov 18 10:05:42 sipiyou kernel: _ctl_find_id return NULL
Nov 18 10:05:42 sipiyou kernel: snd-mixer-4231 ok
Nov 18 10:05:42 sipiyou kernel: pcm-chan returns 2
Nov 18 10:05:42 sipiyou kernel: capture = 0 , interwave =1
Nov 18 10:05:42 sipiyou kernel: pcm_dev = 1 channels = 2
Nov 18 10:05:42 sipiyou kernel: snd-pcm-new ok
Nov 18 10:05:42 sipiyou kernel: snd-pcm-set ops ok
Nov 18 10:05:42 sipiyou kernel: snd-pcm-lib-preallocated ok
Nov 18 10:05:42 sipiyou kernel: _snd_ctl_add called (/sound/core/control.c)
Nov 18 10:05:42 sipiyou kernel: _snd_ctl_add:: kcontrol->id == 0
Nov 18 10:05:42 sipiyou kernel: _ctl_find_id called (/sound/core/control.c)
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'PCM Playback Switch'
id->name= 'PCM Playback Volume'
Nov 18 10:05:42 sipiyou kernel: list_for_each(list,
&card->controls)-loop start
Nov 18 10:05:42 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 18 10:05:42 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 18 10:05:42 sipiyou kernel: kctl->id.name = 'PCM Playback Volume'
id->name= 'PCM Playback Volume'
Nov 18 10:05:42 sipiyou kernel: kctl->id.index = 0 id->index = 0
Nov 18 10:05:42 sipiyou kernel: kctl->id.index + kctl->count <= (?) 1
id->index = 0
Nov 18 10:05:42 sipiyou kernel: list_for_each(list, &card->controls)
exit _ctl_find_id
Nov 18 10:05:42 sipiyou kernel: bug here id=0 2
Nov 18 10:05:42 sipiyou kernel: bitch card = -454433792, kctl = -551828960
Nov 18 10:05:42 sipiyou kernel: pcm-new returns -16
Nov 18 10:05:42 sipiyou kernel: InterWave soundcard not found or device busy
--------------------------------------------------------------------------------

I did in the meanwhile another test with the latest 4F-OSS stuff
(ftp://www.se.opensound.com/pub/oss/linux/oss398b-linux-v2x.tar.gz).
They're having the same problem with the interwave card (error message
is almost the
same which says that the card is not found or busy...).
Did they copy the alsa-engine and are now charging money for it ?

Nima.


>On Mon, 17 Nov 2003, Nima Ghassemi wrote:
>
>  
>
>>hi,
>>
>>there's some problem which I tracked down to
>>
>>~alsa-driver/sound/core/control.c
>>
>>int snd_ctl_add(snd_card_t * card, snd_kcontrol_t * kcontrol)
>>{
>>        snd_ctl_elem_id_t id;
>>        unsigned int idx;
>>
>>    snd_runtime_check(card != NULL && kcontrol != NULL, return -EINVAL);
>>        snd_assert(kcontrol->info != NULL, return -EINVAL);
>>        id = kcontrol->id;
>>        down_write(&card->controls_rwsem);
>>    if (_ctl_find_id(card, &id)) {
>>                up_write(&card->controls_rwsem);
>>                snd_ctl_free_one(kcontrol);
>>                return -EBUSY;
>>    }
>>[...]
>>
>>the problem lies in _ctl_find_id (card, &id). by commenting the if-block
>>out, everything (as well
>>as the sound-card) works perfectly (as far as I could test it...).
>>    
>>
>
>Can you add some printk's to determine which id is causing the problem so
>we can fix it? Thanks.
>
>						Jaroslav
>
>-----
>Jaroslav Kysela <perex@suse.cz>
>Linux Kernel Sound Maintainer
>ALSA Project, SuSE Labs
>
>
>-------------------------------------------------------
>This SF. Net email is sponsored by: GoToMyPC
>GoToMyPC is the fast, easy and secure way to access your computer from
>any Web browser or wireless device. Click here to Try it Free!
>https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>  
>




-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
