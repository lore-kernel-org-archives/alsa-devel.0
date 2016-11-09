From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC 0/4] ALSA controls management using
 index/device/sub-devices fields
Date: Wed, 9 Nov 2016 21:33:28 +0900
Message-ID: <c28a3623-3cf1-5fc1-1ba8-e6785fb967ca@sakamocchi.jp>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 695852663ED
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 13:33:34 +0100 (CET)
In-Reply-To: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 8 2016 17:11, Arnaud Pouliquen wrote:
> 3) Patches proposed:
> Based on these observations, here are some patches that i tested in my
> environment. There are complementary,  and could answer to some
> limitations mentioned above.
>
> 3-1) Alsa-utils patch
>
> - iecset: allow to select control with device and sub-device numbers
>   This patch allows to access to 2 iec controls differentiated by
>   device/sub-devices numbers
> => For me, this patch is mandatory to be able to address the ASoC IEC
>    controls, in case of no fix is implemented to allows index field
>    update in ASoC.
>
> 3-2) Alsa driver patches
>   - ASoC: core: allow PCM control binding to PCM device
>   	Add relationship between DAIs PCM controls and PCM device.
>
>   - ALSA: control: increment index field for duplicated control.
>    	Generic implementation of the patch proposed in HDA driver
>         (http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ea9b43add)
>
>   - ASoC: sti: use bind_pcm_ctl
>   	implementation of bind_pcm_ctl for sti driver.

In my view, this patchset includes two attempts:
1.to add a framework into ALSA SoC part to relate some control element 
sets to PCM devices
2.to allow drivers in ALSA SoC part to add some control element sets 
from the same codes according to entries of dtb

To achieve above 2nd attempt, it changes ALSA control core to accept 
several control element sets with the same name by assigning proper 
indexes to the sets.

Well, since your former messages, you continue using the word, 'general' 
or 'generic'. If it were somewhat general, it should satisfy 
requirements in whole this subsystem. Actually, there's none of such 
requirements outside of ALSA SoC part. For the drivers outside of ALSA 
SoC part, design of target sound card is fixed in advance, therefore 
programmers can assign control element sets to PCM devices in usual 
ways. At least, current infrastructure in ALSA control core can satisfy 
the programmers.

Therefore, I think that your attempts includes over-generalization. In 
theory, it can bring over-specification easily and it causes code 
complication or unmaintained codes.


Focusing on ALSA SoC part, there's a requirement to register control 
element sets from the same code, in fact. So I wonder why you don't 
start your explanation in an aspect of it. In short, I can't understand 
the reason that you adhere to such an inappropriate generalization for 
this subsystem.

In this patchset, you adhere to usage of 'index' field. But there's 
another way; assigning different identification information to the 
control element sets. Let us to start discussion from this point? At 
least, Iwai-san said, former driver for Intel High Definition Audio is 
necessarily not a good example for a model to c
onsider about this issue and the usage of 'index' is not 
well-generalized[1].

Finally, it's better to clear main points of your issue, for practical 
and meaningful discussion for better approaches, before starting this 
discussion, I think. At least, there's over-generalization, 
misunderstandings of design and interfaces, driver-specific historical 
reasons and so on.


[1] [alsa-devel] [RFC 0/4] ALSA controls management using 
index/device/sub-devices fields
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/114430.html


Regards

Takashi Sakamoto
