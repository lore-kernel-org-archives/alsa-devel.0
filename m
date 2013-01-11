From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/5] ASoC: twl6040: Prevent extra power
 transitions during resume
Date: Fri, 11 Jan 2013 15:44:07 +0100
Message-ID: <50F02537.1000305@ti.com>
References: <1357900355-5055-1-git-send-email-peter.ujfalusi@ti.com>
 <1357900355-5055-3-git-send-email-peter.ujfalusi@ti.com>
 <20130111115207.GW20956@opensource.wolfsonmicro.com> <50F01644.30703@ti.com>
 <20130111134601.GA20956@opensource.wolfsonmicro.com>
 <50F019E9.3030805@ti.com>
 <20130111142403.GC20956@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FD27264F0C
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 15:44:11 +0100 (CET)
In-Reply-To: <20130111142403.GC20956@opensource.wolfsonmicro.com>
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
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/11/2013 03:24 PM, Mark Brown wrote:
> On Fri, Jan 11, 2013 at 02:55:53PM +0100, Peter Ujfalusi wrote:
> =

>> But I wait if you have other comments for the rest for the series.
> =

> The rest of it was fine, I was going to apply them next time I go
> through and applied things.

If it's OK I'll resend the series and replace this patch with a different o=
ne
to remove just the second
twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);
call from resume.

-- =

P=E9ter
