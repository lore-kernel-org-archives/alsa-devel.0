From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Need help with WM8960
Date: Thu, 13 Sep 2012 11:13:03 +0800
Message-ID: <20120913024245.GA4467@opensource.wolfsonmicro.com>
References: <5051160C.2010802@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C8C032616E3
 for <Alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 05:13:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5051160C.2010802@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 12, 2012 at 06:09:00PM -0500, Timur Tabi wrote:

> The first problem is that I get this:

> 	wm8960 0-001a: No platform data supplied

> What kind of platform data is the driver expecting, and how do I get it
> that data?  I don't seem to need any platform data to make the code work.

So, it should be fairly clear from the code that its looking for a
struct wm8960_data.  You can actually leave this totally blank but it's
important that the capless setting is correct one way or another - you
need to look at the schematic and check to see if there are capacitors
on the output not.

> You can see that he disables the DAPM controls for DACL, DACR, ADCL, and
> ADCR, and forces those bits set in the wm8960_probe function.  There's
> also a comment that documents some limitations.  What is the proper way to
> implement this change?

I'm not entirely sure why the user is doing this - unfortuantely they
just bodged the driver without reporting the issue.  The first issue
does not make much sense, the issues described are system level issues
that are unrelated to the ADC for the most part (for example, things
related to the micbias generally depend on the micbias enable).  Without
more information it's hard to comment.  The second sounds like they
missed the LRCM bit, I'll just add the ability to control that from
platform data.

> Third, in order to actually hear audio, I had to unmute the "Left Output
> Mixer PCM" and "Right Output Mixer PCM".  Is this something that the
> machine driver should do automatically?  And if so, how?

No, it's something that the application should do.  
