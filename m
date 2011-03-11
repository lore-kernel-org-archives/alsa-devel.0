From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH RFC] arm: mini2440: Fix uda134x codec problem.
Date: Fri, 11 Mar 2011 13:23:37 +0100
Message-ID: <AANLkTintYQ=qO3PALBL-bkiYKQFw0+JiW3=-oZmkRhZ1@mail.gmail.com>
References: <1299703580-3957-1-git-send-email-marek.belisko@open-nandra.com>
	<20110311121704.GF1760@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110311121704.GF1760@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ben-linux@fluff.org, perex@perex.cz, tiwai@suse.de, lrg@slimlogic.co.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 11, 2011 at 1:17 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 09, 2011 at 09:46:20PM +0100, Marek Belisko wrote:
>> ASoC audio for mini2440 platform in current kenrel doesn't work.
>> First problem is samsung_asoc_dma device is missing in initializatio=
n.
>> Next problem is with codec. Codec is initialized but never probed
>
> Applied, thanks. =C2=A0With changes like this you should really split=
 things
> up into a small patch series - if you ever find yourself writing
> "Next problem..." or "Also..." then going on to describe a separate
> change that's a sign that you should be writing a separate patch.
You're right. I think sending whole patch to help understand what
I'm trying to do (because wasn't sure). You apply just asoc part right?
Thanks for comments!
>

regards,

marek

--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
