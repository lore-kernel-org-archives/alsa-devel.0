From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Wed, 25 Jul 2012 08:12:24 +0200
Message-ID: <500F8E48.9000007@gmail.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com> <500F1B05.3050107@wwwdotorg.org>
 <500F1BB7.7020504@freescale.com>
 <20120724224440.GD1767@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 602D326021A
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 08:12:26 +0200 (CEST)
Received: by wibhq4 with SMTP id hq4so265670wib.2
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 23:12:28 -0700 (PDT)
In-Reply-To: <20120724224440.GD1767@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com, Timur Tabi <timur@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On 25.07.2012 00:44, Mark Brown wrote:
> On Tue, Jul 24, 2012 at 05:03:35PM -0500, Timur Tabi wrote:
>> Stephen Warren wrote:
>>> The I2C code matches the compatible values from the device tree against
>>> two tables in the kernel. First, the of_match_table that this patch
>>> adds, and then if there's no match it falls back to the I2C device ID
>>> table, and matches that against the DT compatible value with the vendor
>>> prefix stripped off.
> 
>>> So while the second method does work as a fall-back, in the past I've
>>> received guidance (I think from Grant Likely) that we should still add
>>> the of_match_table to drivers in order to be explicit.
> 
>> So you're saying that all I2C device drivers should have an
> 
> It's certainly better to add one, it avoids any ambiguity in part
> numbers (there's at least one other chip vendor (Wondermedia) using wm
> for example).
> 
>> of_match_table()?  If so, then we should probably fix all codec drivers in
>> one patch.
> 
> Meh, it's fine doing it piecemeal really.  It's hardly urgent anyway.

Ok, thanks for all the explanation. So I'll repost a cleaned up version
of the 2nd patch then. Timur, are you ok with that?


Daniel
