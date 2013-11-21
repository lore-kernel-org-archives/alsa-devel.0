From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Audio Mini Conference Minutes - Edinburgh 21st
 October 2013
Date: Thu, 21 Nov 2013 21:58:10 +0200
Message-ID: <528E65D2.7010507@iki.fi>
References: <1382985876.2334.64.camel@loki>
 <CA+v+29hOBcuH-teW+5si8qj9QD7o3bsMYFj8v-YfKJRM0XVn8w@mail.gmail.com>
 <1384796142.2319.12.camel@loki> <20131121182211.GD8120@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id ABB992610AB
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 20:58:19 +0100 (CET)
In-Reply-To: <20131121182211.GD8120@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, wangxingchao@xiaomi.com, Wang Xingchao <wangxingchao2011@gmail.com>, ruyi@xiaomi.com, Eric Laurent <elaurent@google.com>
List-Id: alsa-devel@alsa-project.org

21.11.2013 20:22, Mark Brown kirjoitti:
> On Mon, Nov 18, 2013 at 05:35:42PM +0000, Liam Girdwood wrote:
>> On Sat, 2013-11-16 at 17:01 +0800, Wang Xingchao wrote:
> 
>>>> We could use offload, on roadmap for Hires audio on android PCM,
>>>> maybe float instead of 24 bit. Need for 192kHz, Probably not use effects.
> 
>>> Does android support HBR audio now? As i know from Dolby guys, no
>>> customers in Android area are buying Dolby TrueHD license, so i guess
>>> the answer is NO. Most of the customers are from AV receivers and
>>> BlueRay players.
> 
>> Afaik, no one is using high Bit rate audio atm, but there is increasing
>> interest amongst Android OEMs.
> 
> There's a few things shipped doing 192kHz/24 bit - the LG G2 was one of
> the first IIRC.

At least Wang Xingchao seems to be talking specifically about HBR in
relation to HDMI specification, i.e. compressed audio, not PCM...

HBR audio is the way high-bitrate (over 6.144Mbps) compressed IEC 61937
streams are bitstreamed through HDMI. The only such formats supported by
IEC 61937 are DTS-HD MA and Dolby TrueHD (MAT), used on e.g. Blu-ray discs.

The only in-tree ALSA driver supporting HDMI HBR is HDA, AFAICS.

>> Most of the x86 and ARM HW will support HBR audio over ASoC PCM DAIs and
>> HDA, but I'm not sure about which HDMI audio devices support HBR in HW
>> atm...
> 
> It should be relatively common I suppose given that video sources have
> tended to use HBR for a long time (even DVDs do it as standard), though
> it's possible the mobile
> chipsets are limited in some way.

Video DVDs only do PCM, AC-3, DTS and MP2.

-- 
-- 
Anssi Hannula
