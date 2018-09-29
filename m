From: Sundar Nagarajan <sun.nagarajan@gmail.com>
Subject: Fwd: Help with sound on Cherry Trail laptop with
	ES8316 sound chip
Date: Fri, 28 Sep 2018 21:54:43 -0700
Message-ID: <CALnajPBdaOxm7ACLSz=Gx1K+G-Z0Oo5Qjf8TU7en4kWoyOB_OQ@mail.gmail.com>
References: <CALnajPAyW3xL9ntcDT5r69_3NigVch-hYGeo0G2hV_A+g1_WhQ@mail.gmail.com>
 <20180927221408.GC20825@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000838abd0576fb5f76"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C2982678CC
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2018 06:54:55 +0200 (CEST)
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so6451140lfa.4
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 21:54:55 -0700 (PDT)
In-Reply-To: <20180927221408.GC20825@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

--000000000000838abd0576fb5f76
Content-Type: text/plain; charset="UTF-8"

Hello,

I have (separate) issues with two different Cherry Trail laptops that
have the ES8316 chipset for sound.

I already posted the following issues on Pierre Bossart's Intel UCM
repository(https://github.com/plbossart/UCM):

Issue 42: RDP Thinbook 1430 laptop (ES8316): Can't select between
built-in speakers and headphone output
(https://github.com/plbossart/UCM/issues/42)

Pierre's input was as follows:
    The UCM file you are using gives the clue already:
    #Codec IC has only 1 analog out, switching SPK/HP is done externally,
    #probably by means of some analog switch controlled by gpio
    There is nothing we can do at the UCM level, this has to be
handled at a lower level (i.e. the kernel)

In addition, on a different laptop, I have a different problem with
the ES3816 chipset.

Issue 41: No sound on speakers on Chuwi Hi12 laptop - headphone sound
works (es8316) (https://github.com/plbossart/UCM/issues/41)

I reached out to Mark Brown, Daniel Drake and David Yang who were
listed on the kernel.org commit for the ytcht_es8316.c driver
(https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/sound/soc/intel/boards/bytcht_es8316.c?h=next-20180718&id=a03bdaa565cbf23fa86697727a7d2bf1465e7a03)
and Mark suggested reaching out to you folks.

What is the right place for me to post my issues to get your ideas and help?
I have access to these machines, and I can compile kernels and perform
testing, collect logs etc.

Regards,
Sundar


---------- Forwarded message ---------
From: Mark Brown <broonie@kernel.org>
Date: Thu, Sep 27, 2018 at 3:14 PM
Subject: Re: Help with sound on Cherry Trail laptop with ES8316 sound chip
To: Sundar Nagarajan <sun.nagarajan@gmail.com>
Cc: Daniel Drake <drake@endlessm.com>, David Yang <yangxiaohua@everest-semi.com>


On Wed, Sep 26, 2018 at 12:53:44PM -0700, Sundar Nagarajan wrote:
> )I found your email from the kernel.org commit log for the
> bytcht_es8316.c driver
> (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/sound/soc/intel/boards/bytcht_es8316.c?h=next-20180718&id=a03bdaa565cbf23fa86697727a7d2bf1465e7a03.

> I have (separate) issues with two different Cherry Trail laptops that
> have the ES8316 chipset. I posted the following issues on Pierre
> Bossart's Intel UCM repository(https://github.com/plbossart/UCM):

He's on sabbatical at the minute FWIW.

> What is the right place for me to post my issues to get your ideas and help?

You'd be best contacting the Intel maintainers about x86 specific
issues:

INTEL ASoC DRIVERS
M:      Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
M:      Liam Girdwood <liam.r.girdwood@linux.intel.com>
M:      Jie Yang <yang.jie@linux.intel.com>
L:      alsa-devel@alsa-project.org (moderated for non-subscribers)
S:      Supported
F:      sound/soc/intel/

That includes Pierre but also a few other people, hopefully at least one
of them will be able to help or point you to someone who can.  You
should also copy in the alsa-devel list (alsa-devel@alsa-project.org) in
case someone else can help and so people can google the discussion
later, though that'll mean your e-mail address ends up in the archives
so you might not be happy with that.

--000000000000838abd0576fb5f76
Content-Type: text/plain; charset="US-ASCII"; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
Content-ID: <16623ad04da61a8e03b1>
X-Attachment-Id: 16623ad04da61a8e03b1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFFekJBQUJDZ0FkRmlFRXJlWm9xbWRY
R0xXZjRwL3FKTmFMY2wxVWg5QUZBbHV0Vmk4QUNna1FKTmFMY2wxVQ0KaDlERCtnZitJVE84SnF3
N2lMa0JVaTR5ZXZaR0FrNVhWRHJKZkNEaWpvZHcyZzdhTXoxa2lXd09XYlMweDVINg0KQngrdmN4
TVcvSDNKZ0ErQnhzYmxpV1FoL2lTcnN2cjM4emJrdG41cjdLTERROTRtQ0lUQ2tSUmhqSTN2Z1pi
dA0KdVZCMHk0UGhWenphWUhkRGVONWx3U0UvaEE3NGdFQzhoMXpDbi9UTDQxbnoyZ2RQTUE0QjRO
RFBNYnB1aXJVaw0KKzRnQmkxUENleldqMjBoUWY3NHJzR002aWpCRHNxZVcwNy9YMVUwTzRDTkJw
UUY3THNBUnJyTkVONmFiSmQ5QQ0KSmY5KzhySVhYdjI4OGI4d0J1bmtiaWlpUXFDRUtuMlQ5QkNJ
aVNXc1N0TThXT3NHQTg3a0R5cHBhcC9zT2xaNQ0KVWl4aEkzb2xlbW1GYm1YdUh0SndFWUtaRmxr
UmNBPT0NCj1KV0g1DQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==
--000000000000838abd0576fb5f76
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--000000000000838abd0576fb5f76--
