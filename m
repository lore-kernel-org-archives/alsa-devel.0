From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH v2 5/6] sound/usb: pcm changes to use media
 token api
Date: Sat, 25 Oct 2014 08:57:42 -0200
Message-ID: <20141025085742.43e20bb5.m.chehab@samsung.com>
References: <cover.1413246370.git.shuahkh@osg.samsung.com>
 <cf1059cc2606f20d921e5691e3d59945a19a7871.1413246372.git.shuahkh@osg.samsung.com>
 <543FB374.8020604@metafoo.de> <543FC3CD.8050805@osg.samsung.com>
 <s5h38aow1ub.wl-tiwai@suse.de> <543FD1EC.5010206@osg.samsung.com>
 <s5hy4sgumjo.wl-tiwai@suse.de> <543FD892.6010209@osg.samsung.com>
 <s5htx34ul3w.wl-tiwai@suse.de> <54467EFB.7050800@xs4all.nl>
 <s5hbnp5z9uy.wl-tiwai@suse.de> <5446989A.3010000@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from usmailout2.samsung.com (mailout2.w2.samsung.com
 [211.189.100.12])
 by alsa0.perex.cz (Postfix) with ESMTP id D94D52605F6
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 12:57:52 +0200 (CEST)
Received: from uscpsbgm2.samsung.com
 (u115.gpu85.samsung.co.kr [203.254.195.115]) by mailout2.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NDZ00CD5YGEKE40@mailout2.w2.samsung.com> for
 alsa-devel@alsa-project.org; Sat, 25 Oct 2014 06:57:51 -0400 (EDT)
In-reply-to: <5446989A.3010000@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, dheitmueller@kernellabs.com, Takashi Iwai <tiwai@suse.de>, gregkh@linuxfoundation.org, ramakrmu@cisco.com, linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, linux@eikelenboom.it, prabhakar.csengg@gmail.com, crope@iki.fi, laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com, akpm@linux-foundation.org, tim.gardner@canonical.com, olebowle@gmx.com, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

Sorry to enter into this thread so late. Last week was a full week, due to the
4 conferences I paticiapated, and last week I needed to fill lots of trip
reports. Also, I have another trip to give two speeches.

Em Tue, 21 Oct 2014 11:32:10 -0600
Shuah Khan <shuahkh@osg.samsung.com> escreveu:

> Here is what I propose for patch v3:
> - make it a module under media
> - collapse tuner and audio tokens into media token

I'm a little skeptical about this. Merging tuner and audio tokens seems
weird on my eyes, as there are actually two different hardware resources
we need to lock, and we may be locking them on different places.

> - change names (get rid of abbreviated tkn stuff)
> - Make other changes Takashi/Lars pointed out in pcm
> - hold token in pcm open/close

I agree with Hans here: blocking at open/close will likely cause too
much harm, as PA is unable to give an special treatment to media devices.

Ok, a media-aware logic at PA wouldn't be technically hard to be added,
but not sure if the PA maintainers would even consider this hypothesis.

> - add a bitfield to struct v4l2_fh to handle
>   the v4l specific multiple ownership cases.
> - v4l-core and au0828-videp patches will see changes.
> - dvb patch should still be good (crossing fingers)

Regards,
Mauro
