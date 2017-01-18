From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 0/3] ucm: Add support for component
	devices
Date: Wed, 18 Jan 2017 04:00:02 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F881A1C714@shsmsx102.ccr.corp.intel.com>
References: <cover.1479446217.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 74E0E266BEB
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 05:00:08 +0100 (CET)
In-Reply-To: <cover.1479446217.git.mengdong.lin@linux.intel.com>
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
To: "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Koul,
 Vinod" <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Please kindly leave me a message if there is any open issues. I'll reply after the Chinese New Year.

Thanks and Happy New Year!
Mengdong

> -----Original Message-----
> From: mengdong.lin@linux.intel.com [mailto:mengdong.lin@linux.intel.com]
> Sent: Friday, November 18, 2016 1:28 PM
> To: alsa-devel@alsa-project.org
> Cc: tiwai@suse.de; broonie@kernel.org; perex@perex.cz;
> liam.r.girdwood@linux.intel.com; Koul, Vinod <vinod.koul@intel.com>; Lin,
> Mengdong <mengdong.lin@intel.com>; Mengdong Lin
> <mengdong.lin@linux.intel.com>
> Subject: [PATCH v2 0/3] ucm: Add support for component devices
> 
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> Sound cards are defined by machines. And off-soc codecs and DSPs
> embedded in DSP can be taken as the components and resued by different
> machines/ sound cards. This series allows codec and SOC vendors to install
> UCM configuration files for a specific codec or DSP, and sound card verb files
> can include these conf files of components.
> 
> Component devices will not be exposed to applications for backward
> compatibility. So audio servers like PulseAudio and CRAS still only see the
> machine devices.
> 
> History:
> v2: Use an array to define component directories. Document syntax to
>     enable/disable a component device. Hide cdev defined by the parent
>     device in ucm manager for executing a component sequence.
> 
> Mengdong Lin (3):
>   ucm: Skip component directories when scanning sound card configuration
>     files
>   ucm: Parse sequence of component devices
>   ucm: Execute sequence of component devices
> 
>  src/ucm/main.c      |  88 +++++++++++++++++++++++++++++-
>  src/ucm/parser.c    | 154
> +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  src/ucm/ucm_local.h |  19 +++++++
>  src/ucm/utils.c     |   1 +
>  4 files changed, 259 insertions(+), 3 deletions(-)
> 
> --
> 2.7.4
