From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: conversion of opti93x driver to use cs4231-lib
Date: Tue, 08 Jan 2008 15:16:57 +0100
Message-ID: <478385D9.1000402@keyaccess.nl>
References: <20080107200801.008a3cc1.krzysztof.h1@poczta.fm>
	<s5hlk707dj7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 58C7C24AF4
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 15:19:46 +0100 (CET)
In-Reply-To: <s5hlk707dj7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

On 08-01-08 12:38, Takashi Iwai wrote:

Jaroslav -- do you know/remember why opti93x didn't use cs4231-lib?

> At Mon, 7 Jan 2008 20:08:01 +0100,
> Krzysztof Helt wrote:
>> Hi,
>>
>> I posted some time ago two patches which converts opti93x driver to use cs4231-lib library. 
>>
>> The opti93x chips are almost compatible with the cs4231 differing mostly by mixer.
>>
>> This change greatly reduces the source of the opti drivers.
>>
>> Here are patches:
>> [addition of opti93x details to the cs4231-lib]
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-September/003395.html
>>
>> and 
>> [conversion of opti93x driver to use cs4231-lib]
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-September/003396.html
>>
>> I will rediff the second patch as there were some changes to opti93x driver after sending the patch.
>>
>> If it is not a good idea to do such conversion, please reply and drop patches.
> 
> The only concern is whether this breaks the workign opti9xx stuff.
> If someone can confirm it's OK, then I'm 100% for these patches.
> 
> Added Rene to Cc to hear his opinion.

Missed this one originally. I'll look into this in some detail but will need 
a few days. Obviously, if it works, it's desirable. Maybe Jaroslav knows why 
it's not that way now?

Rene.
