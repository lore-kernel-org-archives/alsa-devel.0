From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: The best practice to tie platform DAPM widget and
 codec pin
Date: Fri, 12 Sep 2014 16:57:42 +0200
Message-ID: <541309E6.9020809@topic.nl>
References: <CAOMFOmX5FCsxXpoboDLKpnZrBQ52v3jRZQHbJAk2st0gXYrVKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp04.online.nl (smtp04.online.nl [194.134.41.34])
 by alsa0.perex.cz (Postfix) with ESMTP id ED217261A8E
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 16:57:42 +0200 (CEST)
Received: from smtp04.online.nl (localhost [127.0.0.1])
 by smtp04.online.nl (Postfix) with ESMTP id 61072E0F5
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 16:57:42 +0200 (CEST)
Received: from [192.168.1.6] (s55969068.adsl.online.nl [85.150.144.104])
 by smtp04.online.nl (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 16:57:42 +0200 (CEST)
In-Reply-To: <CAOMFOmX5FCsxXpoboDLKpnZrBQ52v3jRZQHbJAk2st0gXYrVKg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/12/2014 06:04 AM, Anatol Pomozov wrote:
> Hi
>
> I bringing up a board that has Realtek 5677 codec. The codec has 6
> gpios and two of them are used by the board. pin3 is used to enable
> headphones amplifier. pin2 is used to gate DMIC clock for 3 of 4 DMICs
> - it allows to leave only one DMIC working in low-power mode.
>
> Now I need to configure the codec that when "Headphones" audio path is
> enabled then pin3 should go high. The same true for DMIC/pin2. I was
> looking for existing similar solutions but cannot find one.
>
> I need something similar to SND_SOC_DAPM_REGULATOR_SUPPLY that allows
> to turn on/off part of the system. But instead of manipulating a
> voltage regulator I just need to set/unset codec's gpio. What would be
> the best way to achieve it?

You can "convert" gpios to supply regulators using a "fixed" regulator 
driver (instantiated in the devicetree, or platform code on older kernels).

>
> The problem here is that codec does not know which of the outputs
> (LOUT1, LOUT2, LOUT3) corresponds to headphones. It is configured as
> audio path in *.dts file.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Mike Looijmans
