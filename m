From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Thu, 9 Jan 2014 14:22:48 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376B7CC9BE@SW-EX-MBX01.diasemi.com>
References: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
 <20140109121353.GG31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.176])
 by alsa0.perex.cz (Postfix) with ESMTP id A174E261AB2
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 15:22:51 +0100 (CET)
In-Reply-To: <20140109121353.GG31886@sirena.org.uk>
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

On Wed, 9 Jan 2014 12:14:53 +0000, Mark Brown wrote:

> Hrm, you hadn't mentioned the rename in that thread.  I do note that the
> change was from KPIT Cummins who submitted the drivers for this chip for
> you guys and appear to be doing updates too...

I said at the beginning of that thread that we would be taking responsibility
of the driver and KPIT Cummins are no longer involved with this work. At that
point the change to the PMIC I2C id name had already been made (by KPIT) and was
in the kernel. I refer you to this mail in the thread, and to the last paragraph
where I make the proposal of changing the codec I2C Id name to tidy things up:

http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066138.html

> > the I2C Id names and avoid this but you would not agree. The codec
> > part can be standalone and by doing what you've done here means that
> > customers would need to now add additional, unnecessary code to be
> > able to use just the codec driver.  This is not right to me.
> 
> No, users will not have to do any extra work - if anything they have to
> do marginally less with only registering one device.  As discussed this
> is the way Linux handles things (which is also the rationale in the
> changelog for the PMIC rename).  Looking at the changelogs I'd not be
> surprised if the rename was done due to the author getting caught out by
> the non-standard way the driver was done.

Use JUST the codec driver. No PMIC. For some chips, 'the way Linux handles
things' makes sense, but not here. I don't want to re-cover old ground though as
we spent long enough over this last time.

What I would like to highlight, and it's something that concerns me more, is
that someone went into the kernel and changed the I2C Id name for no good
reason, and didn't test if their submission worked correctly (I am of course
well aware in the original submission from KPIT there was a conflict in the I2C
Id name, but that was rectified, and would've been tidied up further had it been
permitted). On top of that you are also leaving it in an unusable state with
your change. If we direct customers to the drivers in the mainline kernel, the
codec cannot be simply instantiated as before, and certainly won't be
instantiated from the MFD code. How is this acceptable?
