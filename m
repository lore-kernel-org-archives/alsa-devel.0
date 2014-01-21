From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Tue, 21 Jan 2014 00:35:11 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376B7CDC48@SW-EX-MBX01.diasemi.com>
References: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
 <20140109121353.GG31886@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CC9BE@SW-EX-MBX01.diasemi.com>
 <20140109202446.GQ12858@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCB98@SW-EX-MBX01.diasemi.com>
 <20140113211858.GK29039@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCF27@SW-EX-MBX01.diasemi.com>
 <20140114195159.GW15567@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CD24A@SW-EX-MBX01.diasemi.com>
 <20140117172025.GW17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.148])
 by alsa0.perex.cz (Postfix) with ESMTP id B5F01261ACB
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 01:35:14 +0100 (CET)
In-Reply-To: <20140117172025.GW17314@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 17 Jan 2014 17:20:25 +0000, Mark Brown wrote:

> it's really common for device vendors to say that their device or code
> is special in some way and can't do the standard things but this rarely
> turns out to be true.  It is therefore really important to do things
> like highlight specific technical things that mean new approaches are
> needed (like the fact that the addresses are independently controllable
> for the functions on this device) otherwise it is very easy for it to
> look like a common pattern is being repeated.

Certainly wasn't trying to con anyone here. Do wish I'd brought that feature
up a lot earlier though as it would've saved us both time.
 
> What I would suggest doing is writing a binding document for the device
> (which seems to be missing anyway) and sending that along with patches
> changing both the MFD and CODEC compatible strings and IDs and adding
> comments saying that this is intentional to ensure that nobody cleans
> this up again.

Ok, I'll look into that. I guess it makes sense to write one document for the
PMIC and one for the CODEC as well, given their individual nature?
