From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
Date: Tue, 02 Oct 2012 10:48:53 +0300
Message-ID: <506A9C65.5040309@ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
 <20120922153313.GN4495@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
 [74.125.149.203])
 by alsa0.perex.cz (Postfix) with ESMTP id DDE4F260308
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2012 09:47:42 +0200 (CEST)
Received: by oagn12 with SMTP id n12so6191539oag.38
 for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2012 00:47:40 -0700 (PDT)
In-Reply-To: <20120922153313.GN4495@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 09/22/2012 06:33 PM, Mark Brown wrote:
> On Fri, Aug 31, 2012 at 06:20:58PM +0530, Hebbar, Gururaja wrote:
> =

>> +config SND_DAVINCI_HAVE_SRAM
>> +	bool
>> +	default y if ARCH_DAVINCI=3Dy
>> +	default n if ARCH_OMAP=3Dy
>> +
> =

> I've been sitting on this mostly since it seems like a step back from
> multi-platform kernels (which is where we're trying to get to) and I've
> been trying to decide what the best approach is.  I'm thinking that we
> do want a generic API for allocating this stuff, it's a fairly generic
> feature (there's TCMs as well).  =

> =

> Adding ifdefs like this does just doesn't seem good.

I also agree that ifdef is not a good solution.
It is better to have this information passed as device_data and via DT it c=
an
be decided based on the compatible property for the device.

-- =

P=E9ter
