From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 1/6] ASoC: rt5651: Add IN3 Boost volume
	control
Date: Mon, 30 Jul 2018 01:58:50 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70284CA61@RTITMBSV02.realtek.com.tw>
References: <20180718205542.12364-1-hdegoede@redhat.com>
 <20180718205542.12364-2-hdegoede@redhat.com>
 <20180719150234.GE27938@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7028430F3@RTITMBSV02.realtek.com.tw>
 <f38e30f0-182b-484e-8de1-a9fd0db4663c@linux.intel.com>
 <ABFD875FF5FB574BA706497D987D48D70284323D@RTITMBSV02.realtek.com.tw>
 <2ea3aaa5-cba7-901b-f0cf-782ce4ebd1c5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 402262676DD
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 03:58:59 +0200 (CEST)
In-Reply-To: <2ea3aaa5-cba7-901b-f0cf-782ce4ebd1c5@redhat.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Hans de Goede [mailto:hdegoede@redhat.com]
> Sent: Friday, July 27, 2018 8:02 PM
> To: Bard Liao; Pierre-Louis Bossart; Mark Brown
> Cc: Liam Girdwood; Oder Chiou; alsa-devel@alsa-project.org; Carlo Caione
> Subject: Re: [alsa-devel] [PATCH 1/6] ASoC: rt5651: Add IN3 Boost volume
> control
> 
> >> isn't this going to break userspace configs if we change the name of
> >> controls?
> >
> > Yes, it should be modified, too.
> 
> Or we just live with the  "Volume" part missing for these 3 and don't
> break users existing setup for no good reason.

Agree.

> 
> Regards,
> 
> Hans
> 
> ------Please consider the environment before printing this e-mail.
