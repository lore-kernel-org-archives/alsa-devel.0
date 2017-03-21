From: Mylene Josserand <mylene.josserand@free-electrons.com>
Subject: Re: [PATCH v3 1/5] ASoC: sun8i-codec: Remove analog
	"HP" widget
Date: Tue, 21 Mar 2017 08:42:24 +0100
Message-ID: <27e4866f-5b08-76df-2cb0-87302da39ec7@free-electrons.com>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-2-mylene.josserand@free-electrons.com>
 <20170320173903.fc2m4euobea3npyq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E3D62668F6
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 08:42:48 +0100 (CET)
In-Reply-To: <20170320173903.fc2m4euobea3npyq@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, wens@csie.org, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 20/03/2017 18:39, Mark Brown wrote:
> On Sat, Mar 18, 2017 at 08:55:05AM +0100, Myl=E8ne Josserand wrote:
>> The "HP" widget is already present and take part to
>> the analog part (sun8i-codec-analog).
>>
>> Remove it from the digital part as it is unnecessary.
>
> I know I said to send against Linus' tree but it turns out this actually
> conflicts with some of the existing fixes, please see my fixes/sunxi
> branch and resend against that.  Sorry for the hassle here.
>

Sure, no problem! I will rebase my V4 on your fixes/sunxi branch.

Best regards,

-- =

Myl=E8ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
