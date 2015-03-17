From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
 algorism to multiplex PCM samples
Date: Wed, 18 Mar 2015 00:49:55 +1100
Message-ID: <55083103.5030704@gmail.com>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506E7EE.6060300@gareus.org> <55070409.8090107@sakamocchi.jp>
 <55070F3B.7000509@gareus.org> <55075D65.20406@sakamocchi.jp>
 <55082E06.6010008@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D7D5264F23
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 14:50:04 +0100 (CET)
Received: by pdbni2 with SMTP id ni2so10309242pdb.1
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 06:50:03 -0700 (PDT)
In-Reply-To: <55082E06.6010008@gareus.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robin Gareus <robin@gareus.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi, others,

Can we include my mixer control into the driver?
I think it is important to include the clock source selector switch as
an alsamixer setting.  Every other serious soundcard allows clock source
selection.

I tested 003R+ with Robin's suggestion of hacking the state to be
statically initialised to zero (which won't work for multi devices),
and the results were great: dead silence on channel 1 when playing into
channel 18.  This small hack means that Robin's update to 003amdtp
should work flawlessly when integrated into the driver properly.

Takashi:  I am also reporting that ADAT sync, SPDIF sync both work using
my clock source selector control.  In fact, without the sync to external
device, there are many dropouts in the 1394 streams.
How can we address this issue?

Regards,
Damien
