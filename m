From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Fri, 4 Sep 2009 00:47:57 +0200
Message-ID: <7c5010d60909031547gaafc0der9afd7ab0d1239d3a@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<s5hws4gox1l.wl%tiwai@suse.de>
	<7c5010d60909031003l317d7325s9082a30c418a28f8@mail.gmail.com>
	<s5hzl9bc3mo.wl%tiwai@suse.de>
	<7c5010d60909031127m51a91cceqbe48f3115a0ef6d2@mail.gmail.com>
	<s5h1vmnde4b.wl%tiwai@suse.de>
	<7c5010d60909031252v25a71577s3655297e47aa6fa2@mail.gmail.com>
	<s5hfxb3k8v8.wl%tiwai@suse.de>
	<7c5010d60909031503k36a30855h6115e4689d1dd0f4@mail.gmail.com>
	<7c5010d60909031543v4291a332ge415f91f3412dda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 497DE1038B6
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 00:47:58 +0200 (CEST)
Received: by fxm3 with SMTP id 3so325937fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 15:47:57 -0700 (PDT)
In-Reply-To: <7c5010d60909031543v4291a332ge415f91f3412dda@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 4, 2009 at 12:03 AM, Giovanni
Maruzzelli<gmaruzz.lists@gmail.com> wrote:
> I'll test it and report back here.

Still we have big problems....


Sep  4 00:35:45 localhost kernel: giovanni line: 306, pos=0,
jiffies=117963666, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:45 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117963719, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117963794, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117963794, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117963802, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117963802, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117963810, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117963810, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=0,
jiffies=117963847, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=0,
jiffies=117963847, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=64,
jiffies=117963851, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=64,
jiffies=117963851, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=128,
jiffies=117963855, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=128,
jiffies=117963855, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=0,
jiffies=117963922, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117963975, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964050, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964050, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117964058, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117964059, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117964066, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117964066, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=0,
jiffies=117964103, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=0,
jiffies=117964103, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=64,
jiffies=117964107, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=64,
jiffies=117964107, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=128,
jiffies=117964111, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=128,
jiffies=117964111, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=0,
jiffies=117964178, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964231, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964306, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964306, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117964314, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117964314, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117964322, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117964322, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=0,
jiffies=117964359, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=0,
jiffies=117964359, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=64,
jiffies=117964363, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=64,
jiffies=117964363, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=128,
jiffies=117964367, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=128,
jiffies=117964367, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=0,
jiffies=117964434, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964487, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964562, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964562, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117964570, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117964570, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2288,
jiffies=117964577, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2288,
jiffies=117964577, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=0,
jiffies=117964615, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=16,
jiffies=117964616, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=80,
jiffies=117964620, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=80,
jiffies=117964620, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=144,
jiffies=117964624, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=144,
jiffies=117964624, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=0,
jiffies=117964690, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:46 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964743, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964818, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964818, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117964826, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117964826, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2288,
jiffies=117964833, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2288,
jiffies=117964833, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117964871, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117964871, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=64,
jiffies=117964875, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=64,
jiffies=117964875, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=112,
jiffies=117964878, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=128,
jiffies=117964879, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=128,
jiffies=117964879, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117964946, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117964999, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117965074, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117965074, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117965082, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117965082, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117965090, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117965090, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965127, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965127, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=64,
jiffies=117965131, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=64,
jiffies=117965131, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=128,
jiffies=117965135, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=128,
jiffies=117965135, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965202, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117965255, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117965330, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117965330, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117965338, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117965338, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117965346, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117965346, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965383, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965383, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=64,
jiffies=117965387, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=64,
jiffies=117965387, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=128,
jiffies=117965391, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=128,
jiffies=117965391, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965458, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117965511, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117965586, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117965586, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117965594, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117965594, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117965603, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117965603, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965639, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965639, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=64,
jiffies=117965643, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=64,
jiffies=117965643, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=128,
jiffies=117965647, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=128,
jiffies=117965647, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965714, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:47 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117965767, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117965842, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117965842, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117965850, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117965850, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117965859, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117965859, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965895, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965895, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=64,
jiffies=117965899, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=64,
jiffies=117965899, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=128,
jiffies=117965903, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=128,
jiffies=117965903, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117965970, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966023, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966098, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966098, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117966106, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117966106, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117966115, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117966115, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966151, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966151, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=64,
jiffies=117966155, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=64,
jiffies=117966155, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=128,
jiffies=117966159, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=128,
jiffies=117966159, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966226, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966279, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966354, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966354, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117966363, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117966363, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117966371, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117966371, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966407, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966407, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=64,
jiffies=117966411, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=64,
jiffies=117966411, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=128,
jiffies=117966415, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=128,
jiffies=117966415, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966482, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966535, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966610, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966610, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117966619, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117966619, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117966627, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117966627, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966663, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966663, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=64,
jiffies=117966667, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=64,
jiffies=117966667, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=128,
jiffies=117966671, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=128,
jiffies=117966671, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:48 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966738, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966791, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966866, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117966866, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117966875, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117966875, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2336,
jiffies=117966884, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2336,
jiffies=117966884, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966919, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966919, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=64,
jiffies=117966923, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=64,
jiffies=117966923, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=128,
jiffies=117966927, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=128,
jiffies=117966927, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117966994, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967047, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967122, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967122, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117967131, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117967131, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117967139, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117967139, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117967175, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117967175, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=48,
jiffies=117967178, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=64,
jiffies=117967179, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=112,
jiffies=117967182, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=112,
jiffies=117967182, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117967250, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967303, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967378, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967378, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2160,
jiffies=117967385, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2160,
jiffies=117967385, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117967394, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117967394, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117967431, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117967431, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=48,
jiffies=117967434, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=48,
jiffies=117967434, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=112,
jiffies=117967438, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=112,
jiffies=117967438, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117967506, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967559, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967634, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967634, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117967642, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117967643, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117967650, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117967650, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117967687, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117967687, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=48,
jiffies=117967690, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=64,
jiffies=117967691, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=112,
jiffies=117967694, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=112,
jiffies=117967694, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:49 localhost kernel: giovanni line: 306, pos=0,
jiffies=117967762, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967815, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967890, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117967890, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117967898, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117967898, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117967907, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117967907, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=0,
jiffies=117967943, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=0,
jiffies=117967943, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=48,
jiffies=117967946, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=64,
jiffies=117967947, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=112,
jiffies=117967950, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=112,
jiffies=117967950, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968018, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968071, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968146, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968146, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117968154, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117968154, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117968163, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117968163, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968199, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968199, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=48,
jiffies=117968202, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=48,
jiffies=117968202, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=112,
jiffies=117968206, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=112,
jiffies=117968206, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968274, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968327, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968402, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968402, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117968410, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117968410, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117968419, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117968419, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968455, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968455, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=48,
jiffies=117968458, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=64,
jiffies=117968459, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=112,
jiffies=117968462, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=112,
jiffies=117968462, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968530, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968583, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968658, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968658, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117968666, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117968666, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117968674, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=2304,
jiffies=117968674, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968711, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968711, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=48,
jiffies=117968714, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=48,
jiffies=117968714, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=112,
jiffies=117968718, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:50 localhost kernel: giovanni line: 306, pos=112,
jiffies=117968718, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968786, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968839, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968914, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117968914, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117968923, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117968923, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117968931, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117968931, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968967, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117968967, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=64,
jiffies=117968971, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=64,
jiffies=117968971, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=112,
jiffies=117968974, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=112,
jiffies=117968974, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117969042, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117969095, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117969170, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117969170, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117969179, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2192,
jiffies=117969179, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117969187, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117969187, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117969223, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117969223, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=64,
jiffies=117969227, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=64,
jiffies=117969227, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=112,
jiffies=117969230, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=112,
jiffies=117969230, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117969298, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117969351, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117969426, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117969426, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117969434, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117969434, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117969443, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117969443, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117969479, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117969479, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=64,
jiffies=117969483, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=64,
jiffies=117969483, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=128,
jiffies=117969487, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=128,
jiffies=117969487, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117969554, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117969607, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117969682, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117969682, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117969690, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2176,
jiffies=117969690, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117969699, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=2320,
jiffies=117969699, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117969735, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=0,
jiffies=117969735, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=64,
jiffies=117969739, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=64,
jiffies=117969739, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=112,
jiffies=117969742, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:51 localhost kernel: giovanni line: 306, pos=112,
jiffies=117969742, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:52 localhost kernel: giovanni line: 306, pos=0,
jiffies=117969810, buffer_size=4096, period_size=2048, rate=16000
Sep  4 00:35:52 localhost kernel: giovanni line: 306, pos=2048,
jiffies=117969863, buffer_size=4096, period_size=2048, rate=16000
