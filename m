From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH] ALSA: hda: Abort capability probe on
	invalid capability
Date: Wed, 18 Oct 2017 10:29:14 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB605799EA440@BGSMSX104.gar.corp.intel.com>
References: <1508349576-29947-1-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hvajcvjua.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 115A0266EEB
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 12:29:18 +0200 (CEST)
In-Reply-To: <s5hvajcvjua.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Wednesday, October 18, 2017 3:50 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; Koul, Vinod <vinod.koul@intel.com>
>Subject: Re: [PATCH] ALSA: hda: Abort capability probe on invalid capability
>
>On Wed, 18 Oct 2017 19:59:36 +0200,
>Ughreja, Rakesh A wrote:
>>
>> From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>>
>> When an invalid capability is discovered, stop traversing
>> the capability link list further.
>
>Could you give more background, especially *why* we change that?
>It's almost clear what the patch does by looking at the change, but
>it's not clear why it is needed.

Is the following description in patch okay for you ?

Due to bugs in BIOS it's possible that the HDA capability link list is 
not constructed properly. This may lead to driver going into unknown
state. So whenever driver discovers unknown HDA capability, 
log it as error and stop traversing the link list further.

Regards,
Rakesh
 
