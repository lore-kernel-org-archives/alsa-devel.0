From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Get correct usage_count value
 to load firmware
Date: Tue, 14 Jul 2015 18:17:42 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718D35869@ORSMSX113.amr.corp.intel.com>
References: <1436897626-118574-1-git-send-email-yang.a.fang@intel.com>
 <20150714181615.GH11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 136AD2652CC
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 20:17:45 +0200 (CEST)
In-Reply-To: <20150714181615.GH11162@sirena.org.uk>
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
To: 'Mark Brown' <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Mirche, Dinesh" <dinesh.mirche@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>, "Sreeramalu,
 Shilpa" <shilpa.sreeramalu@intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, July 14, 2015 11:16 AM
> To: Fang, Yang A
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Koul, Vinod; Nujella,
> Sathyanarayana; kevin.strasser@linux.intel.com; Sripathi, Srinivas;
> Sreeramalu, Shilpa; Mirche, Dinesh; stable@vger.kernel.org
> Subject: Re: [PATCH] ASoC: Intel: Get correct usage_count value to load
> firmware
> 
> On Tue, Jul 14, 2015 at 11:13:46AM -0700, yang.a.fang@intel.com wrote:
> 
> > +#ifdef PM_CONFIG
> > +#define GET_USAGE_COUNT(dev) (atomic_read(&dev-
> >power.usage_count))
> > +#else
> > +#define GET_USAGE_COUNT(dev) 1
> > +#endif
> 
> PM_CONFIG?
Sorry for the typo. Will fix that.
