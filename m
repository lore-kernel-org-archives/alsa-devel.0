From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Is snd_pcm_hw_constraint_mask64 really needed ?
Date: Sun, 12 Mar 2017 10:24:09 +0900
Message-ID: <dd51b96c-b367-3c64-1ebe-7a5e7496f6f3@sakamocchi.jp>
References: <CAHkWnPZu3a5WdsXzF8_faxdoYPOuSgcqkAu3tX_EL4VCczqYqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 8A2C1265142
 for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2017 02:24:13 +0100 (CET)
In-Reply-To: <CAHkWnPZu3a5WdsXzF8_faxdoYPOuSgcqkAu3tX_EL4VCczqYqw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chemsi Mehdi <chmsmehdi@gmail.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 10 2017 01:23, Chemsi Mehdi wrote:
> I am working with an alsa codec driver  where the driver is calling
> err = snd_pcm_hw_constraint_mask64(substream->runtime,
> SNDRV_PCM_HW_PARAM_FORMAT, formats);
> my driver is already setting format before that so I wonder why this
> function is called?
> Looks like it is  needed to add audio constraints to substreams at
> open/startup time, but why ?
> what can be the issue if I do not call it ?

It's for user space applications.

In protocol of ALSA PCM interface between kernel/userspace, parameters 
of PCM substream are decided via interaction between drivers and 
applications. Typically, applications keep memory object in user space 
for 'struct snd_pcm_hw_params' and set their preferable parameters to 
it, then call ioctl(2) system call for it with SNDRV_PCM_IOCTL_HW_PARAMS 
or SNDRV_PCM_IOCTL_HW_REFINE. In kernel mode, the memory object is 
copied to kernel space and handled by ALSA PCM core. The constrains and 
rules registered by drivers are applied to it, then the result is copied 
to user space. Finally, applications can get available parameters of PCM 
substream.

Without this interaction, even if your driver can handle your devices 
correctly, applications cannot use them with proper parameters of PCM 
substream; e.g. wrong PCM samples per frame, wrong sampling rate, and so on.


Regards

# I'm another Takashi.

Takashi Sakamoto
