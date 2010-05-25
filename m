From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MMAP in ALSA
Date: Tue, 25 May 2010 10:55:18 +0200
Message-ID: <4BFB9076.7030709@ladisch.de>
References: <BCF80163639E9F4296FC4B208F99BA47013899D48F@orsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6A73324157
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 10:55:33 +0200 (CEST)
In-Reply-To: <BCF80163639E9F4296FC4B208F99BA47013899D48F@orsmsx504.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Varadarajan, Srikanth" <srikanth.varadarajan@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Varadarajan, Srikanth wrote:
> If we have one application using the hardware through ALSA, other
> applications are unable to get access to it. So, we want to have
> PulseAudio on top and use the pulse virtual device to render audio
> through ALSA. Is this a recommended way of having multiple applications
> access one audio HW simultaneously?

Usually yes.

> Is there any other way of handling multiple applications get access to
> the same hardware?

With ALSA's dmix plugin, but this requires that the hardware supports
mmap, i.e., DMA to/from the main memory.

> Also, why are mmap and munmap operations required in ALSA?

They aren't, except for dmix.

> Right now, we do not have mmap and munmap operations exposed.
> Though the hardware constraints have "SNDRV_PCM_INFO_MMAP |
> SNDRV_PCM_INFO_MMAP_VALID" defined.

In most drivers, the buffer management, including mmap, is automatically
handled by the ALSA framework.

> If there is a close enough ALSA implementation in the current Linux
> kernel that I can lookup, please point me to that.

Close to what?  What kind of buffer does your device use, DMA in main
memory, memory-mapped device memory, or PIO?


Regards,
Clemens
