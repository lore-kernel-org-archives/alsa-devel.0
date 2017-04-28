From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: snd_soc_set_dmi_name - Shouldn't it use SYS_VENDOR?
Date: Fri, 28 Apr 2017 11:35:01 +0100
Message-ID: <1493375701.2540.53.camel@loki>
References: <CAD8Lp454-BRKu7GZxpbO+4qgFfSTF0DviUcaUDtgNOVrzb2jLw@mail.gmail.com>
 <5aa36e3b-49f9-d7f6-df58-18dcfcda08e5@linux.intel.com>
 <CAD8Lp44uqQW9+V_ZgB4LLXa8WFb+=CX8hT8PmWbZEGFhZGTvBw@mail.gmail.com>
 <7dbec345-e058-18ca-b4b3-e071fbc08fb0@linux.intel.com>
 <CAD8Lp47u3ERC_pn4ScJ6DQZ9HOuDcUZ0zM4fEQ99c3EVzP_YXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 630FA267335
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 12:35:06 +0200 (CEST)
In-Reply-To: <CAD8Lp47u3ERC_pn4ScJ6DQZ9HOuDcUZ0zM4fEQ99c3EVzP_YXA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Drake <drake@endlessm.com>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-04-27 at 15:02 -0600, Daniel Drake wrote:
> On Thu, Apr 27, 2017 at 2:32 PM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
> > While in general DMI_SYS_VENDOR is commonly used, there are exceptions to
> > the rule, such as the very machine I am working on at the moment which does
> > have any useful DMI_SYS_VENDOR information (see below)
> > Mengdong may be able to comment on why we took this direction.
> 

I think it was probably due to our limited number of test machines all
reporting better info via DMI_BOARD_VENDOR.

> In a DMI database of 113 PC models that we have worked with here:
> 
> 112 have correct/meaningful sys_vendor, 1 is useless (To be filled by OEM)
> 106 have correct board_vendor, 7 have incorrect or useless values
> 
> And awkwardly the one system that I'd like to match in UCM rules here
> has correct sys_vendor but bad board_vendor.
> 

So given your larger database is showing better results for
DMI_SYS_VENDOR it may be best to try this first and if that's NULL then
use DMI_BOARD_VENDOR. 

Would you care to submit a patch ? or Mengdong ?  Sorry, I wont be able
to get to this for a week due to some travel.

Thanks

Liam 
