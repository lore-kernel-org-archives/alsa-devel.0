From: "chaithrika" <chaithrika@ti.com>
Subject: Re: [PATCH v3 5/6] ARM: DaVinci: ASoC: Add
	mcasp	support for DM646x
Date: Thu, 4 Jun 2009 15:27:49 +0530
Message-ID: <000001c9e4fa$eb726730$c2573590$@com>
References: <1243501868-28565-1-git-send-email-chaithrika@ti.com>
	<20090530162647.GA19692@sirena.org.uk>
	<00ee01c9e43a$fa552550$eeff6ff0$@com>
	<20090603121236.GA25676@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E759103937
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 11:59:29 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n549xNj0003415
	for <alsa-devel@alsa-project.org>; Thu, 4 Jun 2009 04:59:28 -0500
Received: from tidmzi-ftp.india.ext.ti.com (localhost [127.0.0.1])
	by dflp53.itg.ti.com (8.13.8/8.13.8) with SMTP id n549xLEi020800
	for <alsa-devel@alsa-project.org>; Thu, 4 Jun 2009 04:59:22 -0500 (CDT)
Received: from symphonyindia.ti.com (symphony-ftp [192.168.247.11])
	by tidmzi-ftp.india.ext.ti.com (Postfix) with SMTP id 3FA4C3886B
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2009 15:26:43 +0530 (IST)
In-Reply-To: <20090603121236.GA25676@sirena.org.uk>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'Naresh Medisetty' <naresh@ti.com>, alsa-devel@alsa-project.org, 'Steve Chen' <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, 'Pavel Kiryukhin' <pkiryukhin@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 17:42:37, Mark Brown wrote:
> On Wed, Jun 03, 2009 at 04:33:51PM +0530, chaithrika wrote:
> 
> > > Why is the McASP driver using platform data called
> > > 'evm_snd_patform_data'?
> > > This suggests that there's some abstraction problem with the
separation
> > > between the machine and McASP drivers.
> 
> > The platform data consists of information specific to EVM and SoC 
> > and is used by the platform driver (McASP driver) to get relevant 
> > data. Therefore it seems right to use the platform data here.
> > Please let me know your opinion.
> 
> It's not the *use* of platform data, it's the fact that you are calling
> this *EVM* platform data.  This suggests an abstraction issue somewhere
> along the line - presumably not all machines with these processors are
> EVMs.  Some of the other issues myself and David identified suggest that
> there are some issues there.
> 
> If this is system-specific configuration data purely for the McBSP port
> it shouldn't mention the EVMs in the name.
> 

OK. I will rename the structure to 'snd_platform_data'. 

Thanks, 
Chaithrika
