From: Nima Ghassemi <ngn928@web.de>
Subject: Re: alsa - 0.9.8 (and today's cvs - 16.11.2003) interwave
 problem.
Date: Mon, 17 Nov 2003 11:19:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB8A0CD.10908@web.de>
References: <3FB8F17B.3010505@web.de> <Pine.LNX.4.53.0311161834220.16992@pnote.perex-int.cz> <3FB9E24B.5000602@web.de> <Pine.LNX.4.53.0311171022090.16992@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0311171022090.16992@pnote.perex-int.cz>
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

Well...

still the same...
here's the output again:

Nov 17 11:16:34 sipiyou kernel: >id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Playback Switch' 
id->name= 'Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Playback Volume' 
id->name= 'Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Output Playback 
Switch' id->name= 'Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Output Playback 
Bypass' id->name= 'Capture Volume'
Nov 17 11:16:34 sipiyou kernel: _ctl_find_id return NULL
Nov 17 11:16:34 sipiyou kernel: _snd_ctl_add called (/sound/core/control.c)
Nov 17 11:16:34 sipiyou kernel: _snd_ctl_add:: kcontrol->id == 0
Nov 17 11:16:34 sipiyou kernel: _ctl_find_id called (/sound/core/control.c)
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'PCM Playback Switch' 
id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'PCM Playback Volume' 
id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Line Playback Switch' 
id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Line Playback Volume' 
id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Switch' 
id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Volume' 
id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Switch' 
id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Volume' 
id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Playback Switch' 
id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Playback Volume' 
id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Output Playback 
Switch' id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Output Playback 
Bypass' id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Capture Volume' 
id->name= 'Capture Source'
Nov 17 11:16:34 sipiyou kernel: _ctl_find_id return NULL
Nov 17 11:16:34 sipiyou kernel: _snd_ctl_add called (/sound/core/control.c)
Nov 17 11:16:34 sipiyou kernel: _snd_ctl_add:: kcontrol->id == 0
Nov 17 11:16:34 sipiyou kernel: _ctl_find_id called (/sound/core/control.c)
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'PCM Playback Switch' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'PCM Playback Volume' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Line Playback Switch' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Line Playback Volume' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Switch' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Volume' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Switch' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Volume' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Playback Switch' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Playback Volume' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Output Playback 
Switch' id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Output Playback 
Bypass' id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Capture Volume' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Capture Source' 
id->name= 'Mic Boost'
Nov 17 11:16:34 sipiyou kernel: _ctl_find_id return NULL
Nov 17 11:16:34 sipiyou kernel: _snd_ctl_add called (/sound/core/control.c)
Nov 17 11:16:34 sipiyou kernel: _snd_ctl_add:: kcontrol->id == 0
Nov 17 11:16:34 sipiyou kernel: _ctl_find_id called (/sound/core/control.c)
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'PCM Playback Switch' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'PCM Playback Volume' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Line Playback Switch' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Line Playback Volume' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Switch' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Volume' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Switch' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Volume' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Playback Switch' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Playback Volume' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Output Playback 
Switch' id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Output Playback 
Bypass' id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Capture Volume' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Capture Source' 
id->name= 'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mic Boost' id->name= 
'Loopback Capture Switch'
Nov 17 11:16:34 sipiyou kernel: _ctl_find_id return NULL
Nov 17 11:16:34 sipiyou kernel: _snd_ctl_add called (/sound/core/control.c)
Nov 17 11:16:34 sipiyou kernel: _snd_ctl_add:: kcontrol->id == 0
Nov 17 11:16:34 sipiyou kernel: _ctl_find_id called (/sound/core/control.c)
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'PCM Playback Switch' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'PCM Playback Volume' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Line Playback Switch' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Line Playback Volume' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Switch' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Volume' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Switch' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Aux Playback Volume' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Playback Switch' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Playback Volume' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Output Playback 
Switch' id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mono Output Playback 
Bypass' id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Capture Volume' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Capture Source' 
id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Mic Boost' id->name= 
'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'Loopback Capture 
Switch' id->name= 'Loopback Capture Volume'
Nov 17 11:16:34 sipiyou kernel: _ctl_find_id return NULL
Nov 17 11:16:34 sipiyou kernel: snd-mixer-4231 ok
Nov 17 11:16:34 sipiyou kernel: pcm-chan returns 2
Nov 17 11:16:34 sipiyou kernel: capture = 0 , interwave =1
Nov 17 11:16:34 sipiyou kernel: pcm_dev = 1 channels = 2
Nov 17 11:16:34 sipiyou kernel: snd-pcm-new ok
Nov 17 11:16:34 sipiyou kernel: snd-pcm-set ops ok
Nov 17 11:16:34 sipiyou kernel: snd-pcm-lib-preallocated ok
Nov 17 11:16:34 sipiyou kernel: _snd_ctl_add called (/sound/core/control.c)
Nov 17 11:16:34 sipiyou kernel: _snd_ctl_add:: kcontrol->id == 0
Nov 17 11:16:34 sipiyou kernel: _ctl_find_id called (/sound/core/control.c)
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'PCM Playback Switch' 
id->name= 'PCM Playback Volume'
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, 
&card->controls)-loop start
Nov 17 11:16:34 sipiyou kernel: kctl->id.face = 2, id->iface = 2
Nov 17 11:16:34 sipiyou kernel: kctl->id.device = 0 id->device= 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.subdevice = 0 id->subdevice=0
Nov 17 11:16:34 sipiyou kernel: kctl->id.name = 'PCM Playback Volume' 
id->name= 'PCM Playback Volume'
Nov 17 11:16:34 sipiyou kernel: kctl->id.index = 0 id->index = 0
Nov 17 11:16:34 sipiyou kernel: kctl->id.index + kctl->count <= (?) 1 
id->index = 0
Nov 17 11:16:34 sipiyou kernel: list_for_each(list, &card->controls) 
exit _ctl_find_id
Nov 17 11:16:34 sipiyou kernel: bug here id=0 2
Nov 17 11:16:34 sipiyou kernel: xxxx card = -454434304, kctl = -584178112
Nov 17 11:16:34 sipiyou kernel: pcm-new returns -16
Nov 17 11:16:34 sipiyou kernel: InterWave soundcard not found or device busy

>On Tue, 18 Nov 2003, Nima Ghassemi wrote:
>
>  
>
>>Hi Jaroslav!
>>
>>here we go:
>>I added some printk's to these routines:
>>    
>>
>
>Thanks. Please, try this patch:
>
>Index: gus_pcm.c
>===================================================================
>RCS file: /cvsroot/alsa/alsa-kernel/isa/gus/gus_pcm.c,v
>retrieving revision 1.15
>diff -u -r1.15 gus_pcm.c
>--- gus_pcm.c	1 Mar 2003 19:04:29 -0000	1.15
>+++ gus_pcm.c	17 Nov 2003 09:25:09 -0000
>@@ -813,6 +813,15 @@
> 	.put = snd_gf1_pcm_volume_put
> };
>
>+static snd_kcontrol_new_t snd_gf1_pcm_volume_control1 =
>+{
>+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>+	.name = "GPCM Playback Volume",
>+	.info = snd_gf1_pcm_volume_info,
>+	.get = snd_gf1_pcm_volume_get,
>+	.put = snd_gf1_pcm_volume_put
>+};
>+
> static snd_pcm_ops_t snd_gf1_pcm_playback_ops = {
> 	.open =		snd_gf1_pcm_playback_open,
> 	.close =	snd_gf1_pcm_playback_close,
>@@ -880,6 +889,10 @@
> 	strcat(pcm->name, " (synth)");
> 	gus->pcm = pcm;
>
>+	if (gus->codec_flag)
>+		kctl = snd_ctl_new1(&snd_gf1_pcm_volume_control1, gus);
>+	else
>+		kctl = snd_ctl_new1(&snd_gf1_pcm_volume_control, gus);
> 	if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_gf1_pcm_volume_control, gus))) < 0)
> 		return err;
> 	kctl->id.index = control_index;
>
>						Jaroslav
>
>-----
>Jaroslav Kysela <perex@suse.cz>
>Linux Kernel Sound Maintainer
>ALSA Project, SuSE Labs
>  
>



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
