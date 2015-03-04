From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [ALSA-UTILS][PATCH] Add support for cplay and
 crecord
Date: Wed, 4 Mar 2015 21:40:13 +0530
Message-ID: <20150304161013.GU2613@intel.com>
References: <1425483360-1806-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E574726510B
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 17:13:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1425483360-1806-1-git-send-email-qais.yousef@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2015 at 03:36:00PM +0000, Qais Yousef wrote:
> cplay and crecord use compress offload API to play and record compressed audio.
> 
> They're based on cplay and crec from tinycompress library using LGPL license.
> 
> For now cplay only supports playing mp3 files.
> 
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
> I renamed crec to crecord also to match aplay and arecord, hopefully
> you don't mind Vinod.
No thats fine..

> 
> This patch is dependent on my other patch that adds support for compress offload
> to alsa-lib.
And where is that, should have preceded this
> 
> I needed to include <sound/compress_params.h> in cplay.c and crec.c
> but I couldn't find an example of any C file which directly includes <sound/*.h>
> The norm seems to be to just include <alsa/asoundlib.h>. Do I need to
> redefine structs from <sound/compress_params.h> to newly added <alsa/compress.h>?
> <alsa/pcm.h> seems to redefine structs from <sound/asound.h>.
These are kernel headers and should be in your include path if you have
those installed
> 
> I could only test cplay but have no means to test crecord at the moment.
> 
>  Makefile.am       |   3 +
>  configure.ac      |   6 +-
>  cplay/Makefile.am |  14 ++
>  cplay/cplay.c     | 294 +++++++++++++++++++++++++++++++++++
>  cplay/crec.c      | 449 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  cplay/tinymp3.h   |  72 +++++++++
>  6 files changed, 837 insertions(+), 1 deletion(-)
>  create mode 100644 cplay/Makefile.am
>  create mode 100644 cplay/cplay.c
>  create mode 100644 cplay/crec.c
>  create mode 100644 cplay/tinymp3.h

Okay here is where we need discussion on the future course. If we do this
then we end up in two code bases, something I would not encourage!

On the other hand if we add the make file changes to tinycompress or if
required split this into two, lib and tools and then package lib part into
alsa-lib and players into tools, that way we can have single code base. That
was my intent behind ensuring that this is dual licensed.

Takashi, is that something we could achieve? I think last time we discussed
this topic you seemed okay with this, only thing was tinycompress lacks
proper make support which we can add

-- 
~Vinod
