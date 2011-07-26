From: Andrew Murray <amurray@mpcdata.com>
Subject: Supporting an unusual device
Date: Tue, 26 Jul 2011 17:45:44 +0100
Message-ID: <CAJK_gi7MQUbpyOmnPt7gf9E-eygk7=aMiauz9ZmYUw0PyF8HUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BF69124378
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jul 2011 18:45:44 +0200 (CEST)
Received: by wyh21 with SMTP id 21so172736wyh.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2011 09:45:44 -0700 (PDT)
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

Hello,

I'm writing support for a slightly unusual device (which I intend to
share later) and would like feedback on the best approach to take. The
device is for a SOC which has two identical I2C connected codecs. Most
codec drivers contain a snd_soc_dai structure - but as this contains
instance specific data it would be necessary instead to produce
(kmalloc) such structures for each instance (to ensure that both
codecs can be treated and addressed independently). I.e. it seems that
some codec drivers have been written with the assumption that there
will only be one present on a system at any time. My view would be to
implement such functionality (kmalloc'ing snd_soc_dai's) in one of the
various platform specific directories as appropriate - e.g. atmel,
blackfin, davinci, etc. Is this the best way forward? Are there any
examples I've missed which do support multiple instances of the same
codec?

Also - is it recommended to expose these two codecs to the outside
world as two snd_soc_card devices - or a single card with multiple
dai_links?

Thanks,

Andrew Murray
