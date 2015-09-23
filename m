From: Uli Franke <uli.franke@weiss.ch>
Subject: Dummy module and sample rates
Date: Wed, 23 Sep 2015 13:43:37 +0200
Message-ID: <56029069.60700@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server11.hostfactory.ch (server11.hostfactory.ch
 [62.146.13.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA342652F8
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 13:43:39 +0200 (CEST)
Received: from [192.168.1.112] (165.90.0.85.dynamic.wline.res.cust.swisscom.ch
 [85.0.90.165])
 by server11.hostfactory.ch (Postfix) with ESMTPA id 210AB600C8CCF
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 13:43:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

I fiddled around with the Dummy module and it seems to be the thing
we're looking for. I observed a rather strange behavior though:

I set the hw params sample rate to 44k1 without error, but a subsequent
call of snd_pcm_start returns EPIPE. When setting hw params sample rate
to 4k this does not happen. Did I miss anything?

Regards
Uli

____
uli@ankerklause:~/.../dlna/wdmr$ modinfo snd-dummy
filename:
/lib/modules/3.16.0-46-generic/kernel/sound/drivers/snd-dummy.ko
license:        GPL
description:    Dummy soundcard (/dev/null)
author:         Jaroslav Kysela <perex@perex.cz>
srcversion:     BB2C5716F580F3D7D0F53D1
depends:        snd-pcm,snd
intree:         Y
vermagic:       3.16.0-46-generic SMP mod_unload modversions 686
signer:         Magrathea: Glacier signing key
sig_key:        6C:3B:5C:5E:34:A0:6D:7D:5F:7D:A3:D0:50:98:75:D9:6C:6D:E6:C4
sig_hashalgo:   sha512
parm:           index:Index value for dummy soundcard. (array of int)
parm:           id:ID string for dummy soundcard. (array of charp)
parm:           enable:Enable this dummy soundcard. (array of bool)
parm:           model:Soundcard model. (array of charp)
parm:           pcm_devs:PCM devices # (0-4) for dummy driver. (array of
int)
parm:           pcm_substreams:PCM substreams # (1-128) for dummy
driver. (array of int)
parm:           fake_buffer:Fake buffer allocations. (bool)
parm:           hrtimer:Use hrtimer as the timer source. (bool)
