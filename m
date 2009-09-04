From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Fri, 4 Sep 2009 18:10:17 +0200
Message-ID: <7c5010d60909040910l2cd54890rc89222b17ca6d8eb@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<7c5010d60909040057m29b68361nd34a4bb1254860e8@mail.gmail.com>
	<7c5010d60909040214k2a673606j6b262ca235ba8a24@mail.gmail.com>
	<s5h8wgv12y1.wl%tiwai@suse.de>
	<7c5010d60909040233n42913563va2ed695bc383274f@mail.gmail.com>
	<s5h3a73109p.wl%tiwai@suse.de> <s5hzl9bypj3.wl%tiwai@suse.de>
	<7c5010d60909040338x69700bf5kef90819625679d1e@mail.gmail.com>
	<s5hpra7ynut.wl%tiwai@suse.de>
	<7c5010d60909040411y76818280p7b7ded46f2df9b64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id ABC9C24505
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 18:10:17 +0200 (CEST)
Received: by fxm3 with SMTP id 3so808034fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 09:10:17 -0700 (PDT)
In-Reply-To: <7c5010d60909040411y76818280p7b7ded46f2df9b64@mail.gmail.com>
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
> Can you sort out two streams?  The mixed output is hard to read..

Sorted by dpcm output follows (found 3 start-stop sequences):

Sep  4 12:50:18 localhost kernel: *** START: dpcm=f5828bd4,
buffer=4096, period=2048, rate=16000, strem=0, number=0
Sep  4 12:50:18 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=48000(48), rest=2000000(2000)
Sep  4 12:50:18 localhost kernel: xxx dpcm=f5828bd4, delta=2,
pos=80000(80), rest=1968000(1968)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=123,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=48000(48), rest=2000000(2000)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=2,
pos=80000(80), rest=1968000(1968)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=123,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=1,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=1,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=1,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=1,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=1,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=1,
pos=80000(80), rest=1968000(1968)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=128000(128), rest=1920000(1920)
Sep  4 12:50:31 localhost kernel: xxx dpcm=f5828bd4, delta=120,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:31 localhost kernel: xxx dpcm=f5828bd4, delta=128,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:31 localhost kernel: xxx dpcm=f5828bd4, delta=4,
pos=64000(64), rest=1984000(1984)
Sep  4 12:50:31 localhost kernel: xxx dpcm=f5828bd4, delta=3,
pos=112000(112), rest=1936000(1936)
Sep  4 12:50:31 localhost kernel: xxx dpcm=f5828bd4, delta=121,
pos=2048000(2048), rest=2048000(2048)
- Show quoted text -
Sep  4 12:50:19 localhost kernel: *** START: dpcm=f5828954,
buffer=4096, period=2048, rate=16000, strem=1, number=0
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2160000(2160), rest=1936000(1936)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=121,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2160000(2160), rest=1936000(1936)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2272000(2272), rest=1824000(1824)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=114,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2160000(2160), rest=1936000(1936)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2272000(2272), rest=1824000(1824)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=114,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2160000(2160), rest=1936000(1936)
Sep  4 12:50:19 localhost kernel: xxx dpcm=f5828954, delta=6,
pos=2256000(2256), rest=1840000(1840)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=115,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2160000(2160), rest=1936000(1936)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=1,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=6,
pos=2272000(2272), rest=1824000(1824)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=114,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=6,
pos=2272000(2272), rest=1824000(1824)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=114,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2160000(2160), rest=1936000(1936)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2272000(2272), rest=1824000(1824)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=114,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=1,
pos=2064000(2064), rest=2032000(2032)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:20 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2288000(2288), rest=1808000(1808)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=113,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2160000(2160), rest=1936000(1936)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2272000(2272), rest=1824000(1824)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=114,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=6,
pos=2272000(2272), rest=1824000(1824)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=114,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=6,
pos=2272000(2272), rest=1824000(1824)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=114,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:21 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2160000(2160), rest=1936000(1936)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2288000(2288), rest=1808000(1808)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=113,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=9,
pos=2192000(2192), rest=1904000(1904)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:22 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=9,
pos=2192000(2192), rest=1904000(1904)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=1,
pos=2320000(2320), rest=1776000(1776)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=111,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2160000(2160), rest=1936000(1936)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2288000(2288), rest=1808000(1808)
Sep  4 12:50:23 localhost kernel: xxx dpcm=f5828954, delta=113,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=9,
pos=2192000(2192), rest=1904000(1904)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=1,
pos=2320000(2320), rest=1776000(1776)
Sep  4 12:50:24 localhost kernel: xxx dpcm=f5828954, delta=111,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2288000(2288), rest=1808000(1808)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=113,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=9,
pos=2192000(2192), rest=1904000(1904)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:25 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2160000(2160), rest=1936000(1936)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2288000(2288), rest=1808000(1808)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=113,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:26 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=1,
pos=2192000(2192), rest=1904000(1904)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:27 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2288000(2288), rest=1808000(1808)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=113,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:28 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=9,
pos=2192000(2192), rest=1904000(1904)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:29 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=9,
pos=2192000(2192), rest=1904000(1904)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=7,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:30 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:31 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
Sep  4 12:50:31 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:31 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2176000(2176), rest=1920000(1920)
Sep  4 12:50:31 localhost kernel: xxx dpcm=f5828954, delta=8,
pos=2304000(2304), rest=1792000(1792)
Sep  4 12:50:31 localhost kernel: xxx dpcm=f5828954, delta=112,
pos=0(0), rest=2048000(2048)
- Hide quoted text -
Sep  4 12:50:31 localhost kernel: xxx dpcm=f5828954, delta=128,
pos=2048000(2048), rest=2048000(2048)
Sep  4 12:50:31 localhost kernel: *** STOP dpcm=f5828954, strem=1, number=0
