From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH V3 4/4] Fabric bindings for STAC9766 on the Efika
Date: Thu, 28 May 2009 16:00:20 +0200
Message-ID: <87eiu972ff.fsf@macbook.be.48ers.dk>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013853.3073.78627.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <20090525013853.3073.78627.stgit@terra> (Jon Smirl's message of
	"Sun\, 24 May 2009 21\:38\:53 -0400")
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

>>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:

Hi,

 Jon> Fabric bindings for STAC9766 AC97 codec on the Efika.
 Jon> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
 Jon> ---
 Jon>  sound/soc/fsl/Kconfig              |    8 +++
 Jon>  sound/soc/fsl/Makefile             |    1 
 Jon>  sound/soc/fsl/efika-audio-fabric.c |   95 ++++++++++++++++++++++++++++++++++++
 Jon>  3 files changed, 104 insertions(+), 0 deletions(-)
 Jon>  create mode 100644 sound/soc/fsl/efika-audio-fabric.c

 Jon> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
 Jon> index 79579ae..f571c6e 100644
 Jon> --- a/sound/soc/fsl/Kconfig
 Jon> +++ b/sound/soc/fsl/Kconfig
 Jon> @@ -47,3 +47,11 @@ config SND_MPC52xx_SOC_PCM030
 Jon>  	help
 Jon>  	  Say Y if you want to add support for sound on the Phytec pcm030 baseboard.
 
 Jon> +config SND_MPC52xx_SOC_EFIKA
 Jon> +	tristate "SoC AC97 Audio support for bbplan Efika and STAC9766"
 Jon> +	depends on PPC_EFIKA
 Jon> +	select SND_SOC_MPC5200_AC97
 Jon> +	select SND_SOC_STAC9766
 Jon> +	help
 Jon> +	  Say Y if you want to add support for sound on the Efika.
 Jon> +

Wouldn't it make more sense to make this default y when it has such
specific dependencies and is so deep down in the tree - Most efika
users probably want to enable this if they have enabled ALSA and
SND_SOC?

-- 
Bye, Peter Korsgaard
