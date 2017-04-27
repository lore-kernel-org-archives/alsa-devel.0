From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: snd_soc_set_dmi_name - Shouldn't it use SYS_VENDOR?
Date: Thu, 27 Apr 2017 15:32:31 -0500
Message-ID: <7dbec345-e058-18ca-b4b3-e071fbc08fb0@linux.intel.com>
References: <CAD8Lp454-BRKu7GZxpbO+4qgFfSTF0DviUcaUDtgNOVrzb2jLw@mail.gmail.com>
 <5aa36e3b-49f9-d7f6-df58-18dcfcda08e5@linux.intel.com>
 <CAD8Lp44uqQW9+V_ZgB4LLXa8WFb+=CX8hT8PmWbZEGFhZGTvBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 14174266C0A
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 22:32:33 +0200 (CEST)
In-Reply-To: <CAD8Lp44uqQW9+V_ZgB4LLXa8WFb+=CX8hT8PmWbZEGFhZGTvBw@mail.gmail.com>
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
Cc: liam.r.girdwood@linux.intel.com, "Lin, Mengdong" <mengdong.lin@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 04/27/2017 03:13 PM, Daniel Drake wrote:
> On Thu, Apr 27, 2017 at 1:28 PM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> Not sure if we can really limit the conventions to type1 or type2 if we want
>> the names to be somewhat meaningful.
>>
>> I can't recall why we selected DMI_BOARD_VENDOR instead of DMI_SYS_VENDOR
>> though.
> Is it too late to change to DMI_SYS_VENDOR? Or to have both present in
> the string?
While in general DMI_SYS_VENDOR is commonly used, there are exceptions 
to the rule, such as the very machine I am working on at the moment 
which does have any useful DMI_SYS_VENDOR information (see below)
Mengdong may be able to comment on why we took this direction.


Handle 0x0001, DMI type 1, 27 bytes
System Information
     Manufacturer:
     Product Name:
     Version:
     Serial Number:
     UUID: 6DD3E1A2-7A70-41FC-917A-231C2C4E2E4E
     Wake-up Type: Power Switch
     SKU Number:
     Family:

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
     Manufacturer: Intel Corporation
     Product Name: NUC6i7KYB
     Version: H90766-405
