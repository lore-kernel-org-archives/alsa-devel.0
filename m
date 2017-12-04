From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC 05/10] ALSA: hda - make some of the functions
 externally visible
Date: Mon, 4 Dec 2017 15:43:45 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579AC5F3B@BGSMSX104.gar.corp.intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1512119648-2700-6-git-send-email-rakesh.a.ughreja@intel.com>
 <3fd52b04-97e9-a438-2edf-ccb04530125c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BC24266BBC
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 16:44:34 +0100 (CET)
In-Reply-To: <3fd52b04-97e9-a438-2edf-ccb04530125c@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>Sent: Saturday, December 2, 2017 12:57 AM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; alsa-devel@alsa-
>project.org; broonie@kernel.org; tiwai@suse.de; liam.r.girdwood@linux.intel.com
>Cc: Koul, Vinod <vinod.koul@intel.com>; Patches Audio
><patches.audio@intel.com>
>Subject: Re: [alsa-devel] [RFC 05/10] ALSA: hda - make some of the functions
>externally visible
>
>On 12/1/17 3:14 AM, Rakesh Ughreja wrote:
>> Mark some functions with EXPORT_SYMBOL_GPL so that it can be called by
>> other kernel modules. These APIs would be called by ASoC based HDA codec
>> driver which will be added in the later patches.
>
>Looks ok. Just wondering from a code maintenance perspective if those
>functions would need to be part of a library, and if this means that to
>compile the ASoC based HDAudio codec support you still need to enable
>the legacy support - and if this leads to potential conflicts on which
>driver gets probed?

Yes, I think these functions are already part of library.
These are part of file hda_codec.c, which looks like a library to me.

Takashi is that correct understanding ?
