From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/5] ASoC: Intel: ACPI support and
 machines
Date: Tue, 4 Nov 2014 13:55:10 +0530
Message-ID: <20141104082510.GC1870@intel.com>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
 <545889C4.5000509@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4716326055E
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 09:24:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <545889C4.5000509@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>, liam.r.girdwood@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 04, 2014 at 10:09:40AM +0200, Jarkko Nikula wrote:
> On 11/04/2014 07:31 AM, Vinod Koul wrote:
> >This is second rev of patch series which fixes the modules split as
> >discussed in ML. The core part is now module along with PCI and ACPI one.
> >Added fix reported by Dan as well. Also added the BYTCR machine driver
> >
> >Subhransu S. Prusty (1):
> >   ASoC: Intel: add BYTCR machine driver with RT5640
> >
> >Vinod Koul (4):
> >   ASoC: Intel: mrfld - remove unnecessary check for pointer
> >   ASoC: Intel: mrfld - create separate module for pci part
> >   ASoC: Intel: mrfld - add shim save restore
> >   ASoC: Intel: mrfld- add ACPI module
> >
> I think there is need to have some consolidation with current
> byt-rt5640 and byt-max98090. Since existing drivers and this set are
> using the same ACPI IDs "80860F28" for the ADSP and "10EC5640" codec
> ACPIID for the machine driver probing these drivers won't work
> together.
Liam's suggestion was to remove the current driver when all the bits are
upstream

> One difference at the moment is that byt-rt5640 machines out there
> have differences in audio routings but those are not too difficult
> to handle in the same machine driver.
> 
> Bigger question how to handle platform part? I.e. can these use the
> same drivers and ADSP firmware? If they can, is the firmware
> available for distributions to take?
The two firmware are *not* compatible and that is the big reason why we
can't reuse the parts available

> Optimally all machines out there would use the same drivers and get
> support for compressed audio but meanwhile we should not break
> existing machines.
Yes, I have tested this one on T100 and doesn't seem to break anything.
Please do test and revert if you find issues on any other available board (I
don't have any other board)

-- 
~Vinod
