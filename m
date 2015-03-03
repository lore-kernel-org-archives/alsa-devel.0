From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Tue, 3 Mar 2015 16:25:09 +0000
Message-ID: <32F4D3A311A1404B92CF923AFF38C3C52E1A7750@BGSMSX104.gar.corp.intel.com>
References: <20150223183913.fb262011d6300425da7f34be@ao2.it>
 <20150303151621.c6fc3cfa308aed62484b87a0@ao2.it>
 <54F5CB3D.7020100@linux.intel.com> <20150303161744.GG2613@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DCE202615FC
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 17:25:15 +0100 (CET)
In-Reply-To: <20150303161744.GG2613@intel.com>
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
To: "Koul, Vinod" <vinod.koul@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Harsha Priya <priya.harsha@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@ao2.it>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Abdullah,
 Omair M" <omair.m.abdullah@intel.com>
List-Id: alsa-devel@alsa-project.org

> From: Koul, Vinod
> Sent: Tuesday, March 3, 2015 9:48 PM
> To: Jarkko Nikula
> Cc: Antonio Ospite; alsa-devel@alsa-project.org; Babu, Ramesh; Abdullah,
> Omair M; Harsha Priya; Mika Westerberg
> Subject: Re: [alsa-devel] Intel SST on a Bay Trail tablet
> 
> On Tue, Mar 03, 2015 at 04:54:53PM +0200, Jarkko Nikula wrote:
> > Hi
> >
> > On 03/03/2015 04:16 PM, Antonio Ospite wrote:
> > >On Mon, 23 Feb 2015 18:39:13 +0100
> > >Antonio Ospite <ao2@ao2.it> wrote:
> > >
> > >>Hi,
> > >>
> > >>I am trying to get the Intel SST driver working on a Teclast X98 Air 3G
> > >>[1], it's a Bay Trail tablet. The tests below have been made with
> > >>4.0.0-rc1 and the firmware files from
> > >>https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-
> firmware.git/tree/intel
> > >>
> > >
> > >Hi, has anyone had a chance to take a look at my previous message?
> > >
> > I forgot to answer... Some earlier notes including Teclast X98 Air
> > 3G and patch attempts are collected here:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=86581
> >
> > Unfortunately bug is not solved since it looks these newer Baytrail
> > Windows 8.1 based machines use different SSP port than previous ones
> > and Linux DSP firmware is hardcoded for SSP2.
> >
> > What's interesting does that Android FW use other than SSP2 or does
> > Teclast have some extra amplifier.
> >
> > >[...]
> > >>Last question, what is the difference between having the device detected
> > >>by sound/soc/intel/sst-acpi.c (like in my case) opposed to
> > >>sound/soc/intel/sst/sst_acpi.c? I can see the 80860F28 id in both the
> > >>files but they seem to load different firmwares.
> > >>
> >
> > Different firmware, driver stack and machine driver despite the same
> > LPE ACPI ID and codec ACPI ID. (We really should have some
> > additional DMI quirks that does the selection because of the same
> > ACPI IDs).
> >
> > >
> > >Another thing I noticed is that the Android driver for the rt5640 codec
> > >defines some controls which are not in the mainline driver:
> > >
> > >   OUT MIXR BST3 Switch
> > >   OUT MIXL BST3 Switch
> > >   RECMIXR BST3 Switch
> > >   RECMIXL BST3 Switch
> > >   IN1 Mode Control
> > >   IN2 Mode Control
> > >
> > I'm not sure but these might be FW implemented DSP controls? Vinod,
> > do you know?
> 
> Nope these are not DSP based... From description Antonio is saying these are
> from rt5640 driver... not upstreamed I think.

Yes, they are Realtek codec controls, which are not upstreamed yet.
> 
> --
> ~Vinod
> 
> >
> > --
> > Jarkko
> 
> --
