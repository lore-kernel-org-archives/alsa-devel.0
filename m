From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Para-virtualized audio drivers
Date: Wed, 19 Oct 2016 11:27:58 +0100
Message-ID: <1476872878.11707.24.camel@loki>
References: <85DFEED57DC57344B2483EF7BF8CB60552C5B457@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id B98E0266806
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2016 12:28:36 +0200 (CEST)
In-Reply-To: <85DFEED57DC57344B2483EF7BF8CB60552C5B457@BGSMSX104.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Mon, 2016-10-17 at 03:01 +0000, Ughreja, Rakesh A wrote:
> Hi Takashi and all,
> 
> I have some need to develop para virtualized audio drivers which can
> work with XEN hypervisor.
> 
> I see some attempt was made in the past.
> https://lists.xen.org/archives/html/xen-devel/2015-01/msg02125.html
> 
> I see one more material but with no code.
> http://rd.springer.com/chapter/10.1007%2F978-94-007-2105-0_46
> 
> I am thinking to develop pv-audio-frontend (running on Dom1) and 
> pv-audio-backend (running on Dom0) drivers all at kernel level.
> Backend driver owns the hardware. Frontend driver communicates with 
> backend driver using XENbus framework just like storage and network PV
> drivers.
> 
> Before I start, I wanted to check if there is any other
> work that has been done which I can take as base ?
> 

Fwiw, I've done something similar over 2 VMs for the audio DSP on
Baytrail. i.e. one VM is x86 Qemu/KVM running the host OS and kernel,
whilst the other VM is xtensa Qemu running the DSP firmware.

Details here :-

http://alsa-project.org/main/index.php/Firmware#Using_the_Qemu_DSP_emulator

Liam
