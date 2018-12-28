From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Coherence of status structure after SYNC_PTR
Date: Fri, 28 Dec 2018 12:45:49 +0900
Message-ID: <20181228034549.GA22203@workstation>
References: <20181227172224.GA18933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EFB0267AC8
 for <alsa-devel@alsa-project.org>; Fri, 28 Dec 2018 04:45:57 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id e5so9513859plb.5
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2018 19:45:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20181227172224.GA18933@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 27, 2018 at 03:22:24PM -0200, Ricardo Biehl Pasquali wrote:
> In alsa-lib, pcm_hw, htimestamp(), avail is rechecked to
> ensure a valid timestamp.
> 
> I guess this is for the case when status is mmaped, when
> hardware pointer is read, an interrupt occur, and timestamp
> is read.
> 
> Does SYNC_PTR ioctl always fill a coherent status?

Exactly.

The ioctl command was firstly introduced to solve an issue in
cache-incoherent architectures such as arm or a part of atom platform
in Intel architecture.

In cache-coherent architectures, kernel memory can be mapped to
process VMA to share status and control data of runtime of PCM substream
('struct snd_pcm_runtime.status' = 'struct snd_pcm_mmap_status'
and 'struct snd_pcm_runtime.control' = 'struct snd_pcm_mmap_control').
For example, state of runtime of PCM substream is in the 'status' data.
Members of these two can be changed by both of kernel/userspace, thus
need to care of cache-coherency.

In cache-incoherent architectures, the mapped memory is not necessarily
cache-coherent, thus a call of the ioctl command delivers changed data
in temporary buffer to copy from process VMA to kernel memory or vise versa.

Of cource, the ioctl command works expectedly in cache-coherent
architecture as well.

I note that there're some levels of timestamp and autio timestamp.
Additionally, audio timestamp is updated only in any hardware/software IRQs,
thus it's not available with 'no-period-wakeup' runtime, FYI.


Regards

Takashi Sakamoto
