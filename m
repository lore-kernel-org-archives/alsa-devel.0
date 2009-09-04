From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Fri, 4 Sep 2009 13:10:00 +0200
Message-ID: <7c5010d60909040410r7bfc3d3byc32fb4a9570ec378@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<7c5010d60909040057m29b68361nd34a4bb1254860e8@mail.gmail.com>
	<7c5010d60909040214k2a673606j6b262ca235ba8a24@mail.gmail.com>
	<s5h8wgv12y1.wl%tiwai@suse.de>
	<7c5010d60909040233n42913563va2ed695bc383274f@mail.gmail.com>
	<s5h3a73109p.wl%tiwai@suse.de> <s5hzl9bypj3.wl%tiwai@suse.de>
	<7c5010d60909040338x69700bf5kef90819625679d1e@mail.gmail.com>
	<7c5010d60909040354g19f072d8ra24e3d1f3372a4de@mail.gmail.com>
	<s5hskf3ynzo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id D252424358
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 13:10:01 +0200 (CEST)
Received: by bwz25 with SMTP id 25so589165bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 04:10:00 -0700 (PDT)
In-Reply-To: <s5hskf3ynzo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 4, 2009 at 12:59 PM, Takashi Iwai<tiwai@suse.de> wrote:
> Can you sort out two streams? =A0The mixed output is hard to read..

Sorted by dpcm output follows (found 3 start-stop sequences):

Sep  4 12:50:18 localhost kernel: *** START: dpcm=3Df5828bd4,
buffer=3D4096, period=3D2048, rate=3D16000, strem=3D0, number=3D0
Sep  4 12:50:18 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D48000(48), rest=3D2000000(2000)
Sep  4 12:50:18 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D2,
pos=3D80000(80), rest=3D1968000(1968)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D123,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D48000(48), rest=3D2000000(2000)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D2,
pos=3D80000(80), rest=3D1968000(1968)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D123,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D1,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D1,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D1,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D1,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D1,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D1,
pos=3D80000(80), rest=3D1968000(1968)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D128000(128), rest=3D1920000(1920)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D120,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D4,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D3,
pos=3D112000(112), rest=3D1936000(1936)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D121,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828bd4, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:31 localhost kernel: *** STOP dpcm=3Df5828bd4, strem=3D0, numb=
er=3D0









Sep  4 12:50:31 localhost kernel: *** START: dpcm=3Df7bb28d4,
buffer=3D4096, period=3D2048, rate=3D16000, strem=3D0, number=3D0
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D2,
pos=3D32000(32), rest=3D2016000(2016)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D2,
pos=3D64000(64), rest=3D1984000(1984)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D124,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D2,
pos=3D32000(32), rest=3D2016000(2016)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D3,
pos=3D80000(80), rest=3D1968000(1968)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D123,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D2,
pos=3D32000(32), rest=3D2016000(2016)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D3,
pos=3D80000(80), rest=3D1968000(1968)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D123,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D2,
pos=3D32000(32), rest=3D2016000(2016)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D3,
pos=3D80000(80), rest=3D1968000(1968)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D123,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:32 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D1,
pos=3D16000(16), rest=3D2032000(2032)
Sep  4 12:50:33 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D2064000(2064), rest=3D2032000(2032)
Sep  4 12:50:33 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D127,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:33 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:33 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:33 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:33 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:33 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:33 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:34 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:34 localhost kernel: xxx dpcm=3Df7bb28d4, delta=3D128,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:34 localhost kernel: *** STOP dpcm=3Df7bb28d4, strem=3D0, numb=
er=3D0








Sep  4 12:50:19 localhost kernel: *** START: dpcm=3Df5828954,
buffer=3D4096, period=3D2048, rate=3D16000, strem=3D1, number=3D0
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2160000(2160), rest=3D1936000(1936)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D121,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2160000(2160), rest=3D1936000(1936)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2272000(2272), rest=3D1824000(1824)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D114,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2160000(2160), rest=3D1936000(1936)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2272000(2272), rest=3D1824000(1824)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D114,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2160000(2160), rest=3D1936000(1936)
Sep  4 12:50:19 localhost kernel: xxx dpcm=3Df5828954, delta=3D6,
pos=3D2256000(2256), rest=3D1840000(1840)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D115,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2160000(2160), rest=3D1936000(1936)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D1,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D6,
pos=3D2272000(2272), rest=3D1824000(1824)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D114,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D6,
pos=3D2272000(2272), rest=3D1824000(1824)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D114,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2160000(2160), rest=3D1936000(1936)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2272000(2272), rest=3D1824000(1824)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D114,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D1,
pos=3D2064000(2064), rest=3D2032000(2032)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:20 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2288000(2288), rest=3D1808000(1808)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D113,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2160000(2160), rest=3D1936000(1936)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2272000(2272), rest=3D1824000(1824)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D114,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D6,
pos=3D2272000(2272), rest=3D1824000(1824)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D114,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D6,
pos=3D2272000(2272), rest=3D1824000(1824)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D114,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:21 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2160000(2160), rest=3D1936000(1936)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2288000(2288), rest=3D1808000(1808)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D113,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D9,
pos=3D2192000(2192), rest=3D1904000(1904)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D9,
pos=3D2192000(2192), rest=3D1904000(1904)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D1,
pos=3D2320000(2320), rest=3D1776000(1776)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D111,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2160000(2160), rest=3D1936000(1936)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2288000(2288), rest=3D1808000(1808)
Sep  4 12:50:23 localhost kernel: xxx dpcm=3Df5828954, delta=3D113,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D9,
pos=3D2192000(2192), rest=3D1904000(1904)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D1,
pos=3D2320000(2320), rest=3D1776000(1776)
Sep  4 12:50:24 localhost kernel: xxx dpcm=3Df5828954, delta=3D111,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2288000(2288), rest=3D1808000(1808)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D113,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D9,
pos=3D2192000(2192), rest=3D1904000(1904)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:25 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2160000(2160), rest=3D1936000(1936)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2288000(2288), rest=3D1808000(1808)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D113,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:26 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D1,
pos=3D2192000(2192), rest=3D1904000(1904)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:27 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2288000(2288), rest=3D1808000(1808)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D113,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:28 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D9,
pos=3D2192000(2192), rest=3D1904000(1904)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:29 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D9,
pos=3D2192000(2192), rest=3D1904000(1904)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D7,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:30 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2176000(2176), rest=3D1920000(1920)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828954, delta=3D8,
pos=3D2304000(2304), rest=3D1792000(1792)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828954, delta=3D112,
pos=3D0(0), rest=3D2048000(2048)
Sep  4 12:50:31 localhost kernel: xxx dpcm=3Df5828954, delta=3D128,
pos=3D2048000(2048), rest=3D2048000(2048)
Sep  4 12:50:31 localhost kernel: *** STOP dpcm=3Df5828954, strem=3D1, numb=
er=3D0
