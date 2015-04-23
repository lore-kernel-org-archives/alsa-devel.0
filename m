From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: alsa-driver-build on kernel 3.13
Date: Thu, 23 Apr 2015 11:37:56 +0800
Message-ID: <CAN8ccib4-DuPjAChuwbfNkOeEqXwwHGueScqWCE2AmN4k8yLkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 97D2A265ADE
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 05:37:57 +0200 (CEST)
Received: by oiko83 with SMTP id o83so4772155oik.1
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 20:37:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Do  alsa-driver-build still support on kernel 3.13 ?

Some of the modules have been built but not installed on Ubuntu 14.04 LTS


[    7.547726] snd_hda_codec: Unknown symbol snd_hdac_get_connections (err
0)
[    7.547733] snd_hda_codec: Unknown symbol snd_hdac_power_up_pm (err 0)
[    7.547749] snd_hda_codec: Unknown symbol snd_hdac_regmap_read_raw (err
0)
[    7.547762] snd_hda_codec: Unknown symbol snd_hdac_power_down (err 0)
[    7.547768] snd_hda_codec: Unknown symbol snd_hdac_make_cmd (err 0)
[    7.547783] snd_hda_codec: Unknown symbol snd_hdac_regmap_init (err 0)
[    7.547797] snd_hda_codec: Unknown symbol snd_hdac_refresh_widgets (err
0)
[    7.547824] snd_hda_codec: Unknown symbol snd_hdac_bus_exit (err 0)
[    7.547832] snd_hda_codec: Unknown symbol _snd_hdac_read_parm (err 0)
[    7.547845] snd_hda_codec: Unknown symbol
snd_hdac_bus_exec_verb_unlocked (err 0)
[    7.547849] snd_hda_codec: Unknown symbol snd_hdac_override_parm (err 0)
[    7.547857] snd_hda_codec: Unknown symbol snd_hdac_device_register (err
0)
[    7.547862] snd_hda_codec: Unknown symbol snd_hdac_regmap_update_raw
(err 0)
[    7.547878] snd_hda_codec: Unknown symbol snd_hdac_bus_init (err 0)
[    7.547886] snd_hda_codec: Unknown symbol snd_hdac_read_parm_uncached
(err 0)
[    7.547892] snd_hda_codec: Unknown symbol snd_hdac_device_unregister
(err 0)
[    7.547896] snd_hda_codec: Unknown symbol snd_hdac_device_init (err 0)
[    7.547908] snd_hda_codec: Unknown symbol snd_hdac_power_down_pm (err 0)
[    7.547924] snd_hda_codec: Unknown symbol snd_hdac_regmap_write_raw (err
0)
[    7.547933] snd_hda_codec: Unknown symbol snd_hdac_regmap_exit (err 0)
[    7.547943] snd_hda_codec: Unknown symbol snd_hda_bus_type (err 0)
[    7.547949] snd_hda_codec: Unknown symbol snd_hdac_device_exit (err 0)
[    7.547956] snd_hda_codec: Unknown symbol snd_hdac_get_sub_nodes (err 0)
[    7.547964] snd_hda_codec: Unknown symbol snd_hdac_exec_verb (err 0)
[    7.547973] snd_hda_codec: Unknown symbol snd_array_new (err 0)
[    7.547981] snd_hda_codec: Unknown symbol snd_array_free (err 0)
[    7.547994] snd_hda_codec: Unknown symbol snd_hdac_power_up (err 0)
[    7.548197] snd_hda_codec: Unknown symbol snd_hdac_get_connections (err
0)
[    7.548202] snd_hda_codec: Unknown symbol snd_hdac_power_up_pm (err 0)
[    7.548214] snd_hda_codec: Unknown symbol snd_hdac_regmap_read_raw (err
0)
[    7.548225] snd_hda_codec: Unknown symbol snd_hdac_power_down (err 0)
[    7.548231] snd_hda_codec: Unknown symbol snd_hdac_make_cmd (err 0)
[    7.548244] snd_hda_codec: Unknown symbol snd_hdac_regmap_init (err 0)
[    7.548256] snd_hda_codec: Unknown symbol snd_hdac_refresh_widgets (err
0)
[    7.548281] snd_hda_codec: Unknown symbol snd_hdac_bus_exit (err 0)
[    7.548287] snd_hda_codec: Unknown symbol _snd_hdac_read_parm (err 0)
[    7.548298] snd_hda_codec: Unknown symbol
snd_hdac_bus_exec_verb_unlocked (err 0)
[    7.548302] snd_hda_codec: Unknown symbol snd_hdac_override_parm (err 0)
[    7.548310] snd_hda_codec: Unknown symbol snd_hdac_device_register (err
0)
[    7.548315] snd_hda_codec: Unknown symbol snd_hdac_regmap_update_raw
(err 0)
[    7.548330] snd_hda_codec: Unknown symbol snd_hdac_bus_init (err 0)
[    7.548338] snd_hda_codec: Unknown symbol snd_hdac_read_parm_uncached
(err 0)
[    7.548343] snd_hda_codec: Unknown symbol snd_hdac_device_unregister
(err 0)
[    7.548347] snd_hda_codec: Unknown symbol snd_hdac_device_init (err 0)
[    7.548357] snd_hda_codec: Unknown symbol snd_hdac_power_down_pm (err 0)
[    7.548372] snd_hda_codec: Unknown symbol snd_hdac_regmap_write_raw (err
0)
[    7.548380] snd_hda_codec: Unknown symbol snd_hdac_regmap_exit (err 0)
[    7.548389] snd_hda_codec: Unknown symbol snd_hda_bus_type (err 0)
[    7.548395] snd_hda_codec: Unknown symbol snd_hdac_device_exit (err 0)
[    7.548402] snd_hda_codec: Unknown symbol snd_hdac_get_sub_nodes (err 0)
[    7.548410] snd_hda_codec: Unknown symbol snd_hdac_exec_verb (err 0)
[    7.548418] snd_hda_codec: Unknown symbol snd_array_new (err 0)
[    7.548426] snd_hda_codec: Unknown symbol snd_array_free (err 0)
[    7.548438] snd_hda_codec: Unknown symbol snd_hdac_power_up (err 0)
