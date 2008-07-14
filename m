From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper
	for matching bus and codec drivers
Date: Mon, 14 Jul 2008 11:11:25 -0600
Message-ID: <fa686aa40807141011s1b2efff5vdc1d0bd04e42c953@mail.gmail.com>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714141606.GA22478@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EAD3243C9
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 19:11:28 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so866578and.80
	for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2008 10:11:27 -0700 (PDT)
In-Reply-To: <20080714141606.GA22478@polina.dev.rtsoft.ru>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 14, 2008 at 8:16 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Sat, Jul 12, 2008 at 02:39:29AM -0600, Grant Likely wrote:
>> --- /dev/null
>> +++ b/sound/soc/soc-of.c
>
> It's quite inconvenient to spread the firmware-specific bits over the
> whole kernel source tree. So, can we place this in driver/of/, just as
> we did for i2c, spi and gpio?

This isn't any more specific than say how device drivers are specific
for particular devices.  This is an ASoC machine driver and should
live with all the other ASoC machine drivers.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
