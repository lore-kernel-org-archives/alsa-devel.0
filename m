From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 2/7] MFD: add STM32 DFSDM support
Date: Mon, 30 Jan 2017 19:14:54 +0100
Message-ID: <9d1233ee-d043-4e74-0915-075bb376d817@st.com>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
 <20170124082249.GR16020@dell> <283c0e48-55e2-6516-369d-91dc72d12f73@st.com>
 <20170124113658.GW16020@dell> <a1aaaa20-ac00-b182-f1c1-63152be41135@st.com>
 <20170127101545.g53uah57vgfu55o5@dell>
 <7b3eb38d-4fd1-2006-7423-94f2a7b38b27@st.com>
 <20170129175005.2u25l7zd2anlc6tw@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A524826680A
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2017 19:14:58 +0100 (CET)
In-Reply-To: <20170129175005.2u25l7zd2anlc6tw@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexandre TORGUE <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 01/29/2017 06:50 PM, Mark Brown wrote:
> On Fri, Jan 27, 2017 at 02:45:49PM +0100, Arnaud Pouliquen wrote:
> 
>> Jonathan, Mark, Please could you share your opinion on this
>> topic?
> 
> I really don't have enough visbility of what the hardware or
> software is doing to say much and though there's extensive
> backtrace in here it's not enough to follow.  If it's a generic ADC
> that happens to have audio applications then some relationship with
> IIO might make sense but I don't know how separate the audio and
> general purpose bits of the hardware are.
> 
> Please understand that I get copied in on *lots* of threads about
> MFDs with drivers getting posted repeatedly for whatever revisions
> are needed with little relevance to me so it's very random if I
> even look at these things, much less read them with detail.
> 

In a first step, your comment is enough from my point of view as you
are not disagree with the concept of a relationship between ASOC an IIO.
This confirms that the MFD driver have to be abandoned.

Then details on how to do it is another story, that should trigs some
other discussions...

Thanks and Regards,

Arnaud
