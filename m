From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/6] ASoC/mpc5200: Add fudge factor to
	value reported by .pointer()
Date: Sat, 7 Nov 2009 11:19:54 -0700
Message-ID: <fa686aa40911071019y6be8283bu8d36d96420deefab@mail.gmail.com>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083448.18908.80366.stgit@angua>
	<20091107181153.GA31789@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id F40AB24677
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 19:20:15 +0100 (CET)
Received: by yxe34 with SMTP id 34so1736401yxe.16
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 10:20:14 -0800 (PST)
In-Reply-To: <20091107181153.GA31789@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 7, 2009 at 11:11 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Nov 07, 2009 at 01:34:55AM -0700, Grant Likely wrote:
>> ALSA playback seems to be more reliable if the .pointer() hook reports
>> a value slightly into the period, rather than right on the period
>> boundary. =A0This patch adds a fudge factor of 1/4 the period size
>> to better estimate the actual position of the DMA engine in the
>> audio buffer.
>
> It occurs to me that in terms of dealing with what's going on here this
> probably is achieving exactly the same effect as Jon's code in that it
> tells ALSA that things are a bit ahead of where the buffer started.

Possibly, but I can both reproduce and eliminate the problem Jon is
seeing regardless of whether or not this patch, so I'm not yet
convinced.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
