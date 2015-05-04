From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Add Cherrytrail &
 Braswell machine driver cht_bsw_max98090_ti
Date: Mon, 4 May 2015 14:40:45 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718CC9FB2@ORSMSX113.amr.corp.intel.com>
References: <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
 <1430505723-75442-1-git-send-email-yang.a.fang@intel.com>
 <1430505723-75442-2-git-send-email-yang.a.fang@intel.com>
 <20150504121749.GO15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 39709260565
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 16:41:14 +0200 (CEST)
In-Reply-To: <20150504121749.GO15510@sirena.org.uk>
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
 Srinivas" <srinivas.sripathi@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Jain, Praveen K" <praveen.k.jain@intel.com>, "Diwakar,
 Praveen" <praveen.diwakar@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Iriawan,
 Denny" <denny.iriawan@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>, "dgreid@chromium.org" <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, May 04, 2015 5:18 AM
> To: Fang, Yang A
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Koul, Vinod; Diwakar,
> Praveen; dgreid@chromium.org; kevin.strasser@linux.intel.com; Jain,
> Praveen K; Iriawan, Denny; Nujella, Sathyanarayana; Sripathi, Srinivas
> Subject: Re: [PATCH v2 2/2] ASoC: Intel: Add Cherrytrail & Braswell machine
> driver cht_bsw_max98090_ti
> 
> On Fri, May 01, 2015 at 11:42:03AM -0700, yang.a.fang@intel.com wrote:
> > From: "Fang, Yang A" <yang.a.fang@intel.com>
> >
> > Add machine driver for two Intel Cherryview-based platforms,
> > Cherrytrail and Braswell. This machine driver will support max98090
> > codec as primary codec. it can also support TI jack detect chip as aux
> > device if platform supports it.
> 
> Applied, thanks - but this seems like it was against something other than
> mainline since it didn't immediately apply.

Hi Mark,
Thanks. yes I posted another intel machine driver https://patchwork.kernel.org/patch/6264231/
On 4/23 you only applied but still did not published. May I ask again is that patch still in your local?
Current patch is applied against that machine driver. 

Thanks,
Yang

 
