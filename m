From: Jaroslav Kysela <perex@perex.cz>
Subject: SOF firmware/ucm/topology packaging (was: CA0132
	firmware)
Date: Tue, 28 May 2019 21:15:27 +0200
Message-ID: <b11570d9-6b46-e162-eb91-22e81bfa17bd@perex.cz>
References: <s5hblzmvdcq.wl-tiwai@suse.de>
 <9668d632-c5c9-5114-39cb-0e8a105a547c@perex.cz>
 <9d5ef75c-9b28-3998-865d-a958b7aaaa75@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0A7EF8072E
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 21:15:32 +0200 (CEST)
In-Reply-To: <9d5ef75c-9b28-3998-865d-a958b7aaaa75@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I believe that we need to discuss this more.

Dne 28. 05. 19 v 18:59 Pierre-Louis Bossart napsal(a):
> 
> 
> On 5/28/19 11:38 AM, Jaroslav Kysela wrote:
>
>> The same situation is for the SoC SOF firmware files (drivers are
>> in kernel, firmware files are missing). Perhaps, we can release those files
>> quickly in alsa-firmware and then migrate them slowly to linux-firmware.
> 
> for SOF there are 4 cases
> 
> 1. developers/integrators build from scratch themselves from the public 
> tree.
> 2. integrators build from scratch with their own secret sauce added.
> 3. distros want a binary since they don't want to build from source 
> and/or don't have access to all the DSP tools
> 4. distros needs a binary signed with the Intel production key (e.g. to 
> run on devices initially designed for Windows).

Do you mean that the firmware should be signed because the hardware is doing a
check, if the hardware vendor enables it and rejects the unsigned binaries?

> So far we were mostly dealing with case 1. Case 2 is allowed by the SOF 
> permissive license and there's no need to look into this. We are 
> planning releases for the last two cases, with a cadence aligned with 
> kernel updates. It's not fully clear to me if the linux-firmware tree is 
> the 'right' solution since ideally we'd want to have firmware, topology 
> and UCM files released at the same time.

Do you plan to create a new package for this? I can eventually offer the space
/ docker build system on the ALSA server, if you like. The github releases
work fine, too. The question is, if it's the right way. It seems that the
firmware/topology files are read-only chunks used by the driver (standard
usage) and the UCM config is for alsa-lib (the user space). It might make
probably sense to add compatibility IDs to link/check the correct parts
together at runtime and keep the standard (binary) code distribution for the
most of users (linux-firmware / alsa-lib).

Speaking for distributions, we need to correctly identify the driver which
will load the proper firmware files. From notes posted to the alsa-devel ML,
it seems that there are three drivers for similar hardware (sound bridges) now
and it is not easy to identify the proper driver, because the similar PCI ID
is registered in all of them:

1) legacy HDA
2) sound/soc/intel
3) sound/soc/sof/intel

Do not forget that the distributions include all driver modules in their
universal kernels. It seems like a problem for the Intel hardware at the
moment. Perhaps, you may give us some recommendations / hints.

Totaly another topic is the on-demand installation of firmware files (and
eventually ALSA configuration files). The linux-firmware package has over
180MB now and it's growing. It makes sense to install only useable firmware
files - ommit the files for hardware / drivers which are not detected and
used. It's probably a topic for linux-firmware rather then the ALSA project.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
