From: "M, Naveen" <naveen.m@intel.com>
Subject: Re: [PATCH RESEND 1/2] ASoC: Intel: kbl: Remove option
 of choosing CH count based on pdata
Date: Fri, 1 Dec 2017 08:53:16 +0000
Message-ID: <FB2313B02793AF4895A2AA46650A59E18C281C51@BGSMSX101.gar.corp.intel.com>
References: <1510740463-21655-1-git-send-email-naveen.m@intel.com>
 <1510740463-21655-2-git-send-email-naveen.m@intel.com>
 <20171129123314.4x4giq4hk2ew2zol@sirena.org.uk>
 <20171130040204.GK32417@localhost>
 <20171130061443.GA31069@nm-B85M-D3Hnaveen.m@intel.com>
 <20171130111511.up2f2te5mc3orkit@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A473D267BA7
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 09:53:25 +0100 (CET)
In-Reply-To: <20171130111511.up2f2te5mc3orkit@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, November 30, 2017 4:45 PM
> To: M, Naveen <naveen.m@intel.com>
> Cc: Koul, Vinod <vinod.koul@intel.com>; alsa-devel@alsa-project.org;
> Bossart, Pierre-louis <pierre-louis.bossart@intel.com>; Prusty, Subhransu S
> <subhransu.s.prusty@intel.com>
> Subject: Re: [PATCH RESEND 1/2] ASoC: Intel: kbl: Remove option of choosing
> CH count based on pdata
> 
> On Thu, Nov 30, 2017 at 11:44:43AM +0530, Naveen M wrote:
> 
> > Regarding the Query:
> > As Vinod mentioned, I'm working on Chrome OS user-space stack that
> > uses customized audio server "CRAS".
> > These patches are verified on a board that has only 2 dmics.
> >
> > Giving the control to CRAS, enables to select the desired dmic using
> > channel-map configuration in user-space.
> > Ex:Rear/Front mic selection for World & Front facing camera scenario
> 
> People do run non-ChromeOS installs on their Chromebooks so we can't just
> assume that there's nobody out there with a regular distro on this hardware -
> a user like this reported the problems with the ABI for topology files breaking
> for example.
Understood the point,
shall discuss and work internally with team and reply back. Thanks
