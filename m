From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH v2] ALSA: hda: Abort capability probe on
 invalid capability
Date: Wed, 18 Oct 2017 16:52:54 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB605799EAB3D@BGSMSX104.gar.corp.intel.com>
References: <1508370325-3118-1-git-send-email-rakesh.a.ughreja@intel.com>
 <20171018162651.GA30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 762AD266EE0
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 18:55:07 +0200 (CEST)
In-Reply-To: <20171018162651.GA30097@localhost>
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
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Koul, Vinod
>Sent: Wednesday, October 18, 2017 9:57 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; tiwai@suse.de
>Subject: Re: [PATCH v2] ALSA: hda: Abort capability probe on invalid capability
>
>On Thu, Oct 19, 2017 at 05:15:25AM +0530, Ughreja, Rakesh A wrote:
>> From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>>
>> Due to bugs in BIOS it's possible that the HDA capability link
>
>It maybe due to BIOS bug or some other issue, lets not quantify that please.
>
>I would say "On reading wrong capablity pointer values we may crash...
>
>> list is not constructed properly. This may lead to driver going
>> into unknown state.
>
>I dont think we maintain driver states which are going wrong here
>
>> So whenever driver discovers unknown HDA
>> capability, log it as error and stop traversing the link list
>> further.
>
>that sound good

Hi Vinod, Takashi,

Are you both ok with following commit message ?

On reading wrong capability pointer values driver may crash, so 
whenever driver discovers unknown HDA capability, log it as error 
and stop traversing the link list further.

Regards,
Rakesh
