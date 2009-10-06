From: Mike Frysinger <vapier.adi@gmail.com>
Subject: dev_* output functions and ASoC codecs
Date: Mon, 5 Oct 2009 20:18:03 -0400
Message-ID: <8bd0f97a0910051718w5d97df8dr443917def9da9ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f192.google.com (mail-yw0-f192.google.com
	[209.85.211.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B43E1037EE
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 02:18:23 +0200 (CEST)
Received: by ywh30 with SMTP id 30so3489458ywh.23
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 17:18:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Cai, Cliff" <Cliff.Cai@analog.com>, Barry Song <21cnbao@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

am i doing something wrong or are the dev_* output functions kind of
useless with ASoC codecs ?  it seems like the error output is prefixed
by the generic "soc-audio" but no info related to the exact codec is
included.

as an example, the typical behavior is for the machine driver to call
platform_device_alloc("soc-audio", -1).  this struct device is then
passed down to the relevant subsystem driver register/probe
(i2c/spi/etc...) to the codec driver.  these functions typically then
set the snd_soc_codec's dev member to the allocated platform device.
which means the snd_soc_codec's name member isnt included in decoding.
 so now any dev_* output in the codec driver looks like:
soc-audio soc-audio: some message

if there are multiple codecs, things obviously fall apart quickly.
the question is how to address this.  werent there snd_* output funcs
before ?  or are those now deprecated/dead ?  or perhaps we should
encourage people to stop doing platform_device_alloc("soc-audio") and
start doing platform_device_alloc(snd_soc_card.name) ?

also, there seems to be a semi-common bug in the codec/machine drivers
where they dont actually initialize the dev member.  perhaps it's time
to upgrade the snd_soc_register_codec() check from a KERN_WARNING to a
BUG_ON() ?  clearly the current warning isnt getting its message
through ...
-mike
