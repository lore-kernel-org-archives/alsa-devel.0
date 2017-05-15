From: Paulo Sergio <pstglia@gmail.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Mon, 15 May 2017 10:10:12 -0300
Message-ID: <CAJcYhpYwo0g3+xwSbVo6QWQVH9iGCvO-aLWUOphX4H3gVWZHRw@mail.gmail.com>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <20160505091122.GE1646@localhost.localdomain>
 <CAJcYhpbdr-3qBSdaLX-=MCSGX7VC0XGz6tKbzJ3K3RHeGMhs7g@mail.gmail.com>
 <CAJcYhpZ1NRUa_7nu5kT6yJ_NTbDxRtK5Uy0H1fxMBEHhvA1fxw@mail.gmail.com>
 <20160509142210.GH1646@localhost.localdomain>
 <CAJcYhpa8OrxyFxL1L4VQJL=WSEhrKhvfcdLeUj40Hb=N2kDUUQ@mail.gmail.com>
 <20160513114136.GM1646@localhost.localdomain>
 <CAJcYhpYJcTE0qBwYAHtGF9tbNCKXAVaLP3RnS5CF5=Z1LBijmA@mail.gmail.com>
 <20160515101308.GN1646@localhost.localdomain>
 <CAJcYhpaFiDrMYmbS1cUWL=ix-L2crjnNekpCXjjdHVThwp2Xag@mail.gmail.com>
 <20170508082422.GJ1594@localhost.localdomain>
 <CAJcYhpb0amzyug01nN3TUWBFSgGWfZcfOVfMgV01rxgTnbNnHg@mail.gmail.com>
 <7c35cd21-35a4-726d-71b5-1ef9f096fbee@linux.intel.com>
 <CAJcYhpb9yOJjDwG6ZGEYFQTiLXtkHNgmVkmF2ssQp6QPOX0ueA@mail.gmail.com>
 <6615d589-9124-5f71-0d6d-e634caf2fdaa@linux.intel.com>
 <CAJcYhpatsrYyC0CRu-0quA0=NYOObMC2nro5sDE-2ssTTu83rA@mail.gmail.com>
 <bdaae069-fc68-af1d-8e40-a3e0654fa4cc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f47.google.com (mail-pg0-f47.google.com [74.125.83.47])
 by alsa0.perex.cz (Postfix) with ESMTP id B76F426741F
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 15:10:14 +0200 (CEST)
Received: by mail-pg0-f47.google.com with SMTP id u187so59963223pgb.0
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 06:10:14 -0700 (PDT)
In-Reply-To: <bdaae069-fc68-af1d-8e40-a3e0654fa4cc@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, broonie@opensource.wolfsonmicro.com, Android-x86 development <android-x86-devel@googlegroups.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi Pierre


Em 15/05/2017 09:44, "Pierre-Louis Bossart" <
pierre-louis.bossart@linux.intel.com> escreveu:

On 5/13/17 12:11 AM, Paulo Sergio wrote:

> * This device (Lenovo Yoga 2 1051F) is a bytcr device. However bios
> status returned by iosf_mbi_read is
>     1000000001000000000000101000000 (bits 26:27 disabled).
>    Had to force  bytcr flag to be true  in order to apply correct MCLK
> frequency (25Mhz) and use SSP0
>

Are you sure it's Baytrail-CR? where does this information come from?
Those fields are tied to which PMIC is used and it would be extremely
surprising to have a disconnect.


Sorry, I should have said that I assumed it is a Baytrail CR device because
these features:

* it's a Z3745 soc
* acpi_ipc_irq_index used is 0 (0x1D is the 1st index listed on dsdt, just
like other bytcr devices)
* ssp0 is being used on this device, not ssp2
* it has a 25mhz clk

But these are not enough to state it is a bytcr right?

Regards
Pstglia
