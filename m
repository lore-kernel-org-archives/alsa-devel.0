From: Ivan Sorokin <vanyacpp@gmail.com>
Subject: valgrind error in snd_tlv_get_dB_range
Date: Sun, 19 Jan 2014 14:16:11 +0400
Message-ID: <52DBA5EB.3070104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f175.google.com (mail-lb0-f175.google.com
 [209.85.217.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FF38261688
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2014 11:08:05 +0100 (CET)
Received: by mail-lb0-f175.google.com with SMTP id p9so1811562lbv.6
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2014 02:08:05 -0800 (PST)
Received: from [10.77.16.222] ([83.243.72.90])
 by mx.google.com with ESMTPSA id np10sm11034350lbb.7.2014.01.19.02.08.04
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 19 Jan 2014 02:08:04 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

One program (qasmixer -- alsa mixer) on my system prints lots of 
valgrind errors.

The first one is this:

==25716== Conditional jump or move depends on uninitialised value(s)
==25716==    at 0x4E72307: snd_tlv_get_dB_range (tlv.c:170)
==25716==    by 0x4E8A746: get_dB_range (simple_none.c:1162)
==25716==    by 0x4E8A7E7: get_dB_range_ops (simple_none.c:1176)
==25716==    by 0x4E85590: snd_mixer_selem_get_playback_dB_range 
(simple.c:298)
==25716==    by 0x472B2B: 
QSnd::Mixer_Simple_Elem::set_snd_mixer_selem_id(_snd_mixer_selem_id*) 
(mixer_simple_elem.cpp:161)
==25716==    by 0x4724B8: 
QSnd::Mixer_Simple_Elem::Mixer_Simple_Elem(QObject*, _snd_mixer*, 
_snd_mixer_selem_id*) (mixer_simple_elem.cpp:31)
==25716==    by 0x479F17: 
QSnd::Mixer_Simple::create_mixer_elem(_snd_mixer_elem*) 
(mixer_simple.cpp:318)
==25716==    by 0x4797B3: QSnd::Mixer_Simple::create_mixer_elems() 
(mixer_simple.cpp:217)
==25716==    by 0x4795DF: QSnd::Mixer_Simple::open(QString const&) 
(mixer_simple.cpp:178)
==25716==    by 0x4D4754: Tray_Mixer::load_mixer() (tray_mixer.cpp:222)
==25716==    by 0x4D4505: 
Tray_Mixer::set_mdev_setup(Tray_Mixer_MDev_Setup*) (tray_mixer.cpp:137)
==25716==    by 0x4DB863: Desktop_Items::tray_mixer_create() 
(desktop_items.cpp:504)
==25716==  Uninitialised value was created by a heap allocation
==25716==    at 0x4C2CD7B: malloc (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==25716==    by 0x4E8A572: init_db_range (simple_none.c:1114)
==25716==    by 0x4E8A70D: get_dB_range (simple_none.c:1159)
==25716==    by 0x4E8A7E7: get_dB_range_ops (simple_none.c:1176)
==25716==    by 0x4E85590: snd_mixer_selem_get_playback_dB_range 
(simple.c:298)
==25716==    by 0x472B2B: 
QSnd::Mixer_Simple_Elem::set_snd_mixer_selem_id(_snd_mixer_selem_id*) 
(mixer_simple_elem.cpp:161)
==25716==    by 0x4724B8: 
QSnd::Mixer_Simple_Elem::Mixer_Simple_Elem(QObject*, _snd_mixer*, 
_snd_mixer_selem_id*) (mixer_simple_elem.cpp:31)
==25716==    by 0x479F17: 
QSnd::Mixer_Simple::create_mixer_elem(_snd_mixer_elem*) 
(mixer_simple.cpp:318)
==25716==    by 0x4797B3: QSnd::Mixer_Simple::create_mixer_elems() 
(mixer_simple.cpp:217)
==25716==    by 0x4795DF: QSnd::Mixer_Simple::open(QString const&) 
(mixer_simple.cpp:178)
==25716==    by 0x4D4754: Tray_Mixer::load_mixer() (tray_mixer.cpp:222)
==25716==    by 0x4D4505: 
Tray_Mixer::set_mdev_setup(Tray_Mixer_MDev_Setup*) (tray_mixer.cpp:137)

I compiled libasound2 from the latest git from 
git://gitorious.org/alsa/alsa-lib.git with -g -O0, so you can see line 
numbers.

As I understand the problem is that init_db_range initialize invalid 
rec->db_info, because snd_hctl_elem_tlv_read failed to fully initialize tlv:

> 	tlv = malloc(tlv_size);                  // line 1114
> 	if (! tlv)
> 		return -ENOMEM;
> 	if (snd_hctl_elem_tlv_read(ctl, tlv, tlv_size) < 0)
> 		goto error;
> 	db_size = snd_tlv_parse_dB_info(tlv, tlv_size, &dbrec);
> 	if (db_size < 0)
> 		goto error;
> 	rec->db_info = malloc(db_size);
> 	if (!rec->db_info)
> 		goto error;
> 	memcpy(rec->db_info, dbrec, db_size);
> 	free(tlv);

I tried to trace problem in snd_hctl_elem_tlv_read, but I failed to do 
so due to lack of experience with alsa-lib.

Could someone more experienced with alsa-lib look at the problem?
