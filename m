From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: snd-aloop PCM Slave Channels
Date: Tue, 14 Sep 2010 21:33:56 +0800
Message-ID: <AANLkTi=KvkkaXsXrL+Do7-=P0CZhH9pGcwCuQ-Z3KZuy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 10957103881
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 15:33:57 +0200 (CEST)
Received: by bwz4 with SMTP id 4so5997429bwz.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2010 06:33:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

it seem there is a bug in snd-aloop

those IFACE_PCM "PCM Slave Channels" controls return 48000


 static int loopback_channels_get(struct snd_kcontrol *kcontrol,
                                  struct snd_ctl_elem_value *ucontrol)
 {
         struct loopback *loopback = snd_kcontrol_chip(kcontrol);
-         ucontrol->value.integer.value[0]
=loopback->setup[kcontrol->id.subdevice][kcontrol->id.device].rate;
+        ucontrol->value.integer.value[0]
=loopback->setup[kcontrol->id.subdevice][kcontrol->id.device].channels;
         return 0;
 }

BTW , AFAIK dmix/dsnoop only work with subdevice 0 and there are 8
subdevices by default

How can the application access Loopback.pcm.default ?

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=72c7260ce624adcb40377bc2093cd4d965b9b22e;hp=91c9c8f1b85e69b4bdc94a777d2767c4906c3f47
