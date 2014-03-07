From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [GIT PULL v2] Enhancement of support for Firewire
	devices
Date: Fri, 07 Mar 2014 15:46:41 +0100
Message-ID: <5319DBD1.9000104@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp> <s5h61nqteqk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 86DBF265A06
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 15:46:42 +0100 (CET)
In-Reply-To: <s5h61nqteqk.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Takashi Sakamoto wrote:
>> This pull-request is an update for my previous pull-request:
>> [alsa-devel] [GIT PULL][PATCH 00/39] Enhancement of support for Firewire devices
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073446.html
>>
>> Updates since previous pull-request:
>> firewire-lib:
>>  - use swap() instead of local macro
>>  - check NULL at memory allocation for sort table
>> fireworks:
>>  - use bitmap.h for card slots
>>  - add 'firewire' subdirectory for card node in procfs
>>  - add sanity check of module parameter with clamp()
>> bebob:
>>  - use bitmap.h for card slots
>>  - add 'firewire' subdirectory for card node in procfs
>>  - simplify codes for metering
>>  - use swap() instead of local macro
>>  - change order of last two commits
>
> Clemens, could you review this new series?

I'll see what I can do this weekend ...


Regards,
Clemens
