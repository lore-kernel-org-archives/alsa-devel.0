From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [ANNOUNCE] Audio Mini Summit 2015, 8th October,
 Dublin
Date: Fri, 24 Apr 2015 04:11:26 +0100
Message-ID: <1429845086.2702.45.camel@loki>
References: <s5h1trqavly.wl-tiwai@suse.de>
 <20150423205745.GH22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A2E3F260430
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 05:11:31 +0200 (CEST)
In-Reply-To: <20150423205745.GH22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-04-23 at 21:57 +0100, Mark Brown wrote:
> Hi,
> 
> like previous years, we're going to hold a meeting to discuss
> lowlevel audio on Linux.  This will be held the day after ELC Europe on
> 8th October at CCD (The Convention Centre) in Dublin.
> 
> If you're interested please sign up in the attendee list:
> 
> https://docs.google.com/spreadsheets/d/1bi-8GHsqlzt41FR20WiMuWILe_cZowFireVMBd-QM8Q/edit?usp=sharing
> 
> and please follow up to this mail with any topics you'd like to see
> raised so we can start collecting them (probably another Google doc will
> be forthcoming for them).

My initial topics would be :-

o Reducing alsa kernel and driver size for IoT devices with limited
DRAM. Look at Tinyalsa and salsalib too for IoT userspace.

o Generic machine drivers based on ACPI table data from multiple
devices. i.e. create a machine driver based on ACPI HW topology data
from codec and DSP drivers. This seems to be done for DT, so we probably
need to combine ACPI support into the existing code. The device property
API can be used to abstract any differences between reading data from DT
and ACPI. The difference with DT is that we will need to aggregate data
from the codec and DSP tables as we wont have any ACPI table data for a
machine driver device.

o Intels audio testing tool (currently called BAT). What new features
are needed/wanted most. This is a tool Intel are working on for
automated testing of audio drivers and sound servers. It will be GPL
licensed and is intended to be part of alsa-utils when ready. I'll make
an announcement with more details and a git repo in the next few weeks.
We are using this internally atm for testing current upstream SST
drivers.

Liam  



> 
> Thanks,
> Mark
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
