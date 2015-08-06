From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: query on upstream ASoC driver split across SOUND
 and DRM subsystems
Date: Thu, 6 Aug 2015 14:25:03 +0000
Message-ID: <A3397C8B8B789E45844E7EC5DEAD89D06E8DFC07@satlexdag05.amd.com>
References: <8A8837939561D241AC8141C31522BA68291E33F9@SCYBEXDAG01.amd.com>
 <20150803161905.GA20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0108.outbound.protection.outlook.com [207.46.100.108])
 by alsa0.perex.cz (Postfix) with ESMTP id 5585D2604C7
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2015 16:25:17 +0200 (CEST)
In-Reply-To: <20150803161905.GA20873@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "Bayyavarapu, Maruthi" <Maruthi.Bayyavarapu@amd.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Vemuri,
 Murali-krishna" <Murali-krishna.Vemuri@amd.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, August 03, 2015 12:19 PM
> To: Bayyavarapu, Maruthi
> Cc: tiwai@suse.de; perex@perex.cz; lgirdwood@gmail.com; alsa-
> devel@alsa-project.org; Deucher, Alexander; Vemuri, Murali-krishna
> Subject: Re: query on upstream ASoC driver split across SOUND and DRM
> subsystems
> 
> On Fri, Jul 31, 2015 at 06:07:51PM +0000, Bayyavarapu, Maruthi wrote:
> 
> Please fix your mailer to word wrap within paragraphs, it makes your
> mails much easier to read and reply to.
> 
> > I want to send AMD ASoC driver for review.
> 
> Please just send the driver for review using the standard process
> covered in SubmittingPatches.
> 
> > This driver has a dependency with AMD's 'DRM' subsystem components,
> > which are not upstreamed yet.  Please suggest, whether this ASoC
> > driver can be upstreamed via 'DRM' tree or any alternate approach is
> > preferred.
> 
> When sending the code for the two subsystems please make it clear (eg,
> in the covering letter) that there are dependencies, it may make sense
> to send one patch series to both ASoC and DRM.  Exactly how this is
> handled will depend on the nature of the dependencies and the code,
> we'll work it out as part of the review.

Thanks,  I'm going to work with Maruthi to send out the complete patch set.

Alex
