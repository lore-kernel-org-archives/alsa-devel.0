From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v3 5/6] ALSA: xen-front: Implement ALSA
 virtual sound driver
Date: Wed, 23 May 2018 13:00:45 +0900
Message-ID: <510b107c-c136-7748-0cfa-9de849887c61@sakamocchi.jp>
References: <20180514062742.25879-1-andr2000@gmail.com>
 <20180514062742.25879-6-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 7ED82266C1C
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 06:00:48 +0200 (CEST)
In-Reply-To: <20180514062742.25879-6-andr2000@gmail.com>
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
To: Oleksandr Andrushchenko <andr2000@gmail.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz, tiwai@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On May 14 2018 15:27, Oleksandr Andrushchenko wrote:
 > diff --git a/sound/xen/xen_snd_front_alsa.c 
b/sound/xen/xen_snd_front_alsa.c
 > new file mode 100644
 > index 000000000000..5041f83e98d2
 > --- /dev/null
 > +++ b/sound/xen/xen_snd_front_alsa.c
 > ...
 > +/*
 > + * FIXME: The mmaped data transfer is asynchronous and there is no
 > + * ack signal from user-space when it is done. This is the
 > + * reason it is not implemented in the PV driver as we do need
 > + * to know when the buffer can be transferred to the backend.
 > + */
 > ...

In ALSA PCM interface v2.0.14 or later, SNDRV_PCM_INFO_SYNC_APPLPTR is
available. This flag express that userspace applications are expected to
call ioctl(2) with 'SNDRV_PCM_IOCTL_SYNC_PTR' even if they oprate to
memory mapped page frames for PCM samples. For detail, please refer to a
commit 42f945970af9 ('ALSA: pcm: Add the explicit appl_ptr sync
support')[1].

As a supplement, please refer to below commits:
  * 4b671f577474 ('ALSA: pcm: Add an ioctl to specify the supported
    protocol version')[2]
  * b602aa8eb1a0 ('ALSA: pcm: Disable only control mmap for explicit
    appl_ptr sync')[3]

Alsa-lib v1.1.5 or later supports this flag and existent applications
can run transparently.

For developers, a tracepoint may be useful:
  * fccf53881e9b ('ALSA: pcm: add 'applptr' event of tracepoint')[4]

For your information.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42f945970af9
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b671f577474
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b602aa8eb1a0
[4] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fccf53881e9b


Regards

Takashi Sakamoto
