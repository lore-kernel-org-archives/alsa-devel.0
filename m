From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v3 0/2] ALSA controls management using
 index/device/sub-devices fields
Date: Mon, 28 Nov 2016 22:05:11 +0900
Message-ID: <8f04b173-61e9-c495-4858-c54922845b5e@sakamocchi.jp>
References: <1480325634-23320-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 75875266B0F
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 14:05:17 +0100 (CET)
In-Reply-To: <1480325634-23320-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Nov 28 2016 18:33, Arnaud Pouliquen wrote:
> V3:
> I changed "RFC" prefix to "PATCH", hoping  that patchset is enough mature in term
> of code and discussions, to be considered as a potential patch...
>
> Previous discussions summary:
>  - topic of  the patchset:
>  	Patch concerns ASoc DAI drivers.
>         Aim is to be able to instantiate PCM control using device field according
>         to the associated PCM char device.  For this, a relationship between DAIs PCM
>         control and PCM char device needs to be establish.
>         => Proposal is to add field in DAI driver struct to declare PCM controls that
> 	need to be linked to PCM character device on DAI link probing.
>
>   - Limitation of the patchset:
>   	This patchset seems only a first step as 2 concerns are been highlighted:
>          - Patch is limited to "static" DAI-link. This not responds to backend (no_pcm dai links) and
>          some none-DAI codecs, that could register PCm controls.
>          In theses cases it is not possible to establish relationship during probe.
>          	=> No solution proposed for time beeing.
>
>          - This patchset does not fix conflict of 2 "identical" PCM controls declared by 2 drivers.
>           For instance, a conflict can exist between a  PCM control created in DAI driver
>           and the same control declared in a codec driver.  As index field is forced to 0, prefix
>           should be used in codec.
>         	=> To discuss solution in a separate thread as issue already present without this patchset
>                 	several approaches seem possible like using index field ( control auto indexation in
>                         ASoC) or prefix in Naming.

Enough information for reviewers, very nice ;)

>  Changes:
>  - [PATCH v3 1/2] ASoC: core: allow DAI PCM controls bound to PCM device
>  	Code optimization based on Takashi Sakamoto suggestion
>  - [RFC V2 3/3]   ASoC: hdmi-codec: Example of PCM control bound to PCM device for multi
> 	patch suppressed as it was send as example in previous version. Patch is valid but
>         can have impact on existing drivers as control device field value is updated
>   - [PATCH v3 2/2] ASoC: sti: bind pcm controls to pcm device.
>  	No change vs V2
>
> V2:
> http://www.spinics.net/lists/alsa-devel/msg57045.html
>
> Aim of this version is to continue discussion on DAI PCM control focused on ASoC drivers.
> In this V2  implementation in Soc-core is simplified to limit impact on existing code.
>
>  Update of the RFC V1 based on discussions:
>  - [RFC 4/4] iecset: allow to select control with device and sub-device numbers
>  	no more part of the RFC V2, will be discussed in a separate thread
>  - [RFC 2/4] ALSA: control: increment index field for duplicated control.
>  	no more part of the RFC V2, no more need as RFC subject is PCM controls
>
> - [RFC V2 1/3] ASoC: core: allow DAI PCM controls bound to PCM device
> 	Patch reworked from V1 to simplify implementation
>         - Binding is not done for Dai links tagged with no_pcm (DPCM).
>         - no more possibility to add the controls after the DAI link probing.
>
> - [RFC V2 2/3]   ASoC: sti: bind PCM controls to PCM device.
> - [RFC V2 3/3]   ASoC: hdmi-codec: Example of PCM control bound to PCM device for multi
>         Example of implementation in STI DAI driver and HDMI-codec drivers
>
> V1:
>  http://www.spinics.net/lists/alsa-devel/msg56479.html
>
>  1) Alsa-utils patch
>
> - iecset: allow to select control with device and sub-device numbers
>   This patch allows to access to 2 iec controls differentiated by
>   device/sub-devices numbers
> => For me, this patch is mandatory to be able to address the ASoC IEC
>    controls, in case of no fix is implemented to allows index field
>    update in ASoC.
>
> 2) Alsa driver patches
>   - ASoC: core: allow PCM control binding to PCM device
>   	Add relationship between DAIs PCM controls and PCM device.
>
>   - ALSA: control: increment index field for duplicated control.
>    	Generic implementation of the patch proposed in HDA driver
>         (http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ea9b43add)
>
>   - ASoC: sti: use bind_pcm_ctl
>   	implementation of bind_pcm_ctl for sti driver.
>
> Arnaud Pouliquen (2):
>   ASoC: core: allow DAI PCM controls bound to PCM device
>   ASoC: sti: bind pcm controls to pcm device.
>
>  include/sound/soc-dai.h      |  4 ++++
>  sound/soc/soc-core.c         | 28 ++++++++++++++++++++++++++++
>  sound/soc/sti/sti_uniperif.c | 33 ++++-----------------------------
>  3 files changed, 36 insertions(+), 29 deletions(-)

Regards

Takashi Sakamoto
