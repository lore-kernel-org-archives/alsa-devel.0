From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 5/6] ARM: DaVinci: ASoC: Add
	mcasp	support for DM646x
Date: Wed, 3 Jun 2009 13:12:37 +0100
Message-ID: <20090603121236.GA25676@sirena.org.uk>
References: <1243501868-28565-1-git-send-email-chaithrika@ti.com>
	<20090530162647.GA19692@sirena.org.uk>
	<00ee01c9e43a$fa552550$eeff6ff0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 585312433E
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 14:12:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <00ee01c9e43a$fa552550$eeff6ff0$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chaithrika <chaithrika@ti.com>
Cc: 'Naresh Medisetty' <naresh@ti.com>, alsa-devel@alsa-project.org, 'Steve Chen' <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, 'Pavel Kiryukhin' <pkiryukhin@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 04:33:51PM +0530, chaithrika wrote:

> > Why is the McASP driver using platform data called
> > 'evm_snd_patform_data'?
> > This suggests that there's some abstraction problem with the separation
> > between the machine and McASP drivers.

> The platform data consists of information specific to EVM and SoC 
> and is used by the platform driver (McASP driver) to get relevant 
> data. Therefore it seems right to use the platform data here.
> Please let me know your opinion.

It's not the *use* of platform data, it's the fact that you are calling
this *EVM* platform data.  This suggests an abstraction issue somewhere
along the line - presumably not all machines with these processors are
EVMs.  Some of the other issues myself and David identified suggest that
there are some issues there.

If this is system-specific configuration data purely for the McBSP port
it shouldn't mention the EVMs in the name.
