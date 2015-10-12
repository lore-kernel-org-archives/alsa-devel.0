From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Packages 1.0.30 - release pending
Date: Mon, 12 Oct 2015 11:51:21 +0200
Message-ID: <561B8299.2090200@perex.cz>
References: <561AB391.6030504@perex.cz> <s5hvbaca40c.wl-tiwai@suse.de>
 <1444640191.3544.11.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 7359926040E
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 11:51:22 +0200 (CEST)
In-Reply-To: <1444640191.3544.11.camel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>, "tiwai@suse.de" <tiwai@suse.de>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 12.10.2015 v 10:56 Koul, Vinod napsal(a):
> On Mon, 2015-10-12 at 10:24 +0200, Takashi Iwai wrote:
>> On Sun, 11 Oct 2015 21:08:01 +0200,
>> Jaroslav Kysela wrote:
>>>
>>> Hi all,
>>>
>>> 	I would like to release 1.0.30 version of all packages. Things to discuss:
>>
>> There are pending issues: one is about the topology ABI and this seems
>> still in flux.  I suppose this will be stabilized in 4.4.  Also, the
>> documentation for BAT is utterly missing, and I expect we'll get this
>> soonish.  Liam, Mengdong, any comments on these?
>>
>> We've discussed a bit about the user-space package release in the
>> meeting.  Most people prefer more regular release.  My own preference
>> is to stick with the kernel release cycle -- as most of features are
>> related with the update of kernel ABI.  It's not necessarily at every
>> kernel but, e.g. with two kernel releases, so that we'll get two or
>> three releases per year.  It's just my $0.02, not insisting on it,
>> though.
>>
>>
>>> 1) tinycompress
>>>    - do the release this library, too ?
>>
>> Yeah, this was requested in the meething, too.
> 
> Thanks that will be great..
> 
>>
>>>    - versioning - follow the rule for all other ALSA packages
>>>      (all packages have same version) ?
>>
>> Vinod?
> 
> Sure, so you guys want me to bump up the version to 1.0.30. I don't think that should
> be an issue to align?

Ok, fine. I just asked.

> Also Takashi was mentioning tar balls, do you need me to generate these and upload ?

I'll generate them using my tools on the server. I also prepare the
runtime snapshots - http://www.alsa-project.org/snapshot/ , so you may
test the tarbar before it's versioned. I'll post a note when finished.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
