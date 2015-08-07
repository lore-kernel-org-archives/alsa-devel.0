From: "Bayyavarapu, Maruthi" <Maruthi.Bayyavarapu@amd.com>
Subject: Re: [PATCH 12/12] ASoC: AMD: add ACP PCM driver
	runtime PM
Date: Fri, 7 Aug 2015 09:41:17 +0000
Message-ID: <8A8837939561D241AC8141C31522BA6829B81FD1@SCYBEXDAG02.amd.com>
References: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
 <1438871112-25946-12-git-send-email-alexander.deucher@amd.com>
 <20150806192646.GJ20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0141.outbound.protection.outlook.com [65.55.169.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 52AEB260421
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 11:41:27 +0200 (CEST)
In-Reply-To: <20150806192646.GJ20873@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Alex Deucher <alexdeucher@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I will send a another patch-set, with patches  combined, as suggested.

Regards,
Maruthi

-----Original Message-----
From: Mark Brown [mailto:broonie@kernel.org] 
Sent: 07 August 2015 00:57
To: Alex Deucher
Cc: airlied@gmail.com; dri-devel@lists.freedesktop.org; alsa-devel@alsa-project.org; tiwai@suse.de; perex@perex.cz; lgirdwood@gmail.com; Bayyavarapu, Maruthi
Subject: Re: [PATCH 12/12] ASoC: AMD: add ACP PCM driver runtime PM

On Thu, Aug 06, 2015 at 10:25:12AM -0400, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
> 
> Added runtime PM functionality to AMD I2S driver. This uses 
> functionality from ACP IP methods.

Just add this (and the previous patch) in the driver.  The patches are so tiny it's not adding much to split them out like this and it's actually harder to review this one when it's split from the system suspend code.
