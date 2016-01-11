From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bat: naming conflict in distribution packages
	with	Bareos/Bacula
Date: Mon, 11 Jan 2016 21:02:46 +0100
Message-ID: <56940A66.4040201@ladisch.de>
References: <n5e2br$fdp$1@ger.gmane.org> <s5hh9ikyx25.wl-tiwai@suse.de>
 <1452527626.2473.28.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id EFBD5260455
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 21:03:44 +0100 (CET)
In-Reply-To: <1452527626.2473.28.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "Lu, Han" <han.lu@intel.com>, J6rg Steffens <joerg.steffens@bareos.com>, alsa-devel@alsa-project.org, Bernard Gautier <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> On Mon, 2016-01-11 at 16:07 +0100, Takashi Iwai wrote:
>> J6rg Steffens wrote:
>>> alsa-utils as well as bareos-bat (as well a some Bacula packages) all
>>> contain a program called /usr/bin/bat, which causes conflicts on various
>>> distributions ("basic audio tester" vs "bareos administration tool"
>>> ("bacula administration tool")).
>>
>> [...]
>> OTOH, if we all agree with renaming to something less likely
>> conflicting, I'm all fine with it.
>
> What about prefixing "alsa" or "a" to to bat ?

Why not calling it basic-audio-test (like speaker-test)?


Regards,
Clemens
