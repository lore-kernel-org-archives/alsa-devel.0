From: Pascal Wichmann <pascal.wichmann@pa-w.de>
Subject: Problems with the DP MST audio support patchset
Date: Wed, 29 Mar 2017 12:42:31 +0200
Message-ID: <6800ee6e-31c2-b5eb-fbb2-6826d8c66dc9@pa-w.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web02.pwsrv.de (web02.pwsrv.de [188.68.38.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B0DEE266EF9
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 12:42:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Libin Yang <libin.yang@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Pascal Wichmann <pascal.wichmann@pa-w.de>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hello,

I am not sure whether alsa-devel is the right place for this kind of
question. If it is not, please tell me a better place for them.

I am building my kernel against the drm-tip freedesktop repository which
includes the patches from December 2016 (message id
<1480992519-108079-1-git-send-email-libin.yang@intel.com> and
follow-ups on alsa-devel). I am using a ThinkPad X250 and the ThinkPad
Ultra
Dock with the HDMI output connected to my YAMAHA HTR-2866; this hdmi
output is seen as display port and uses DP MST from the dock.

In principle, everything is working quite well; however, I frequently
recognize two weird behaviours:

* First of all, my audio receiver has 5.1 support. When I
  configure my laptop to send 5.1 audio using alsa or pulseaudio, there
is
  only silence and no audio signal reaches the receiver; however, when I
  choose 7.1 digital surround (which my receiver actually does not suppo
rt
  natively), everything works well and the two additional speakers are
split
  to the existing ones (I do not know whether alsa/the kernel or the
  receiver
  does this, probably it is the receiver).
  This problem is pretty much only esthetical, as everything works fine
  if I use the 7.1 "work-around" (Digital Stereo does work also,
  but obviously does not support the full 5.1 setup)
* The other problem -- which is actually very annoying -- is that there
  frequently is silence though there is audio playing; this happens now
  and then, but when there has been *no* output for a while, it always
  happens a few seconds after starting the new output and lasts for two
  to three seconds.
  During these periods of silence, the icons on my receiver indicating
  that there is an audio source are also gone.
  This problem occurs with 7.1 configuration as well as with Digital
  Stereo.

I am not sure what these problems are caused by and do not know what kin
d
of debug information you may require to get more hints on how to solve
them. Any hints are appreciated.

Thank you for your advice,
Pascal Wichmann
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE/gJ8Tpn0OtJz8hxD6+YIa34W/zYFAljbj5cACgkQ6+YIa34W
/zbIVg//QP4A0wUE2MyaEAenN8nUpNV5ASglRTZ0N5hXBjD+B/sxIMkJdtSynlcB
eBYL90ZLuFHxdfXsltifeY29D7CaHfyqQCeJUfzV+RgUGrlv0wqk2vA9Dfc+RTIT
PBORlyuknqIV14z8vxMGO/1+Po/S8AFplK/QJs9Y+irGAX+CAhBMlVMt8V5rbL+e
oD8KRWgPIwuYShhd0f3tmgqdhRn9RUQgBaYOaq1pXdI/nNDHZuRA021zytkkV4rR
NGG2zOsgrrXo82ac1AAeUXlNczqUCM7UXNLjpVYUQQotEMZd9d6oL5/Iq/bD7Z8i
Z+bzOWymzaaThqarc11UL9ngJr6JsDNXgdDrLgLbkSE1r6Knq66qzOmzZL7qeUDI
1JeCNkmztn82VLovRogQTY8p8Ye7gXwVUPNDocCoeBKgRA6u2VGs+zJljCDOiyT9
cCA+QGMpRMz+KLt82Bt5/vE6TzngUEOZli34wNhf6DaHYo+0j4TpiCZT3roIVlp+
C+tPvDsbt9SfVLKvmoDCKAS8o5wp7+jESAsTEMzssBeN6LYKTWeAJeZHymf17ckb
Y3oub8Wk5bEvZh0AO5q7wqdWMLuTc9BSmJ8eJA0jNV+m9sGKxaTB/qFMfNoJjfFD
yvBBeYvic0btTtOiQAPEia1igNR9vt1hpj5wCI6xNQwSekM1bOQ=
=/6Dp
-----END PGP SIGNATURE-----
