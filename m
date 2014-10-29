From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ALSA: doc: Add missing headers and
 compress stuff to alsa-driver-api.tmpl
Date: Wed, 29 Oct 2014 11:18:38 +0530
Message-ID: <20141029054838.GY28745@intel.com>
References: <1414507545-13362-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 21A742604AE
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 07:28:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1414507545-13362-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2014 at 03:45:44PM +0100, Takashi Iwai wrote:
> Some header files have kereldoc comments but are not referred
> properly.  Let's add them.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  Documentation/DocBook/alsa-driver-api.tmpl | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/DocBook/alsa-driver-api.tmpl b/Documentation/DocBook/alsa-driver-api.tmpl
> index 0230a96f0564..13f8b241f042 100644
> --- a/Documentation/DocBook/alsa-driver-api.tmpl
> +++ b/Documentation/DocBook/alsa-driver-api.tmpl
> @@ -57,6 +57,7 @@
>  !Esound/core/pcm.c
>  !Esound/core/pcm_lib.c
>  !Esound/core/pcm_native.c
> +!include/sound/pcm.h
>       </sect1>
>       <sect1><title>PCM Format Helpers</title>
>  !Esound/core/pcm_misc.c
> @@ -64,6 +65,10 @@
>       <sect1><title>PCM Memory Management</title>
>  !Esound/core/pcm_memory.c
>       </sect1>
> +     <sect1><title>PCM DMA Engine API</title>
> +!Esound/core/pcm_dmaengine.c
> +!Iinclude/sound/dmaengine_pcm.h
> +     </sect1>
>    </chapter>
>    <chapter><title>Control/Mixer API</title>
>       <sect1><title>General Control Interface</title>
> @@ -91,12 +96,19 @@
>  !Esound/core/info.c
>       </sect1>
>    </chapter>
> +  <chapter><title>Compress Offload</title>
> +     <sect1><title>Compress Offload API</title>
> +!Esound/core/compress_offload.c
> +!Iinclude/sound/compress_driver.h
Was include/uapi/sound/compress_offload.h and compress_params.h added
somewhere else, if not can you pls add those as well

-- 
~Vinod



> +     </sect1>
> +  </chapter>
>    <chapter><title>Miscellaneous Functions</title>
>       <sect1><title>Hardware-Dependent Devices API</title>
>  !Esound/core/hwdep.c
>       </sect1>
>       <sect1><title>Jack Abstraction Layer API</title>
>  !Esound/core/jack.c
> +!Iinclude/sound/jack.h
>       </sect1>
>       <sect1><title>ISA DMA Helpers</title>
>  !Esound/core/isadma.c
> -- 
> 2.1.2
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
