From: "Guo, Chaohong" <chaohong.guo@intel.com>
Subject: Re: [PATCH] hda: add bounds checking for the codec
	command fields	v2
Date: Mon, 20 Jul 2009 10:13:48 +0800
Message-ID: <BB1F052FCDB1EA468BD99786C8B1ED2C05871FFE74@PDSMSX501.ccr.corp.intel.com>
References: <20090717082410.GA20628@localhost>
	<20090717082703.GA21835@localhost> <20090717084919.GA24645@localhost>
	<BB1F052FCDB1EA468BD99786C8B1ED2C05871FFCB9@PDSMSX501.ccr.corp.intel.com>
	<s5hljmn8u52.wl%tiwai@suse.de> <20090717110552.GA21516@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 25CB424596
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jul 2009 04:15:04 +0200 (CEST)
In-Reply-To: <20090717110552.GA21516@localhost>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Wu, Fengguang" <fengguang.wu@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, John Villalovos <jvillalo@redhat.com>, Jaroslav@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 

>Cc: Guo, Chaohong; alsa-devel@alsa-project.org; Jaroslav 
>Kysela; John Villalovos
>Subject: Re: [PATCH] hda: add bounds checking for the codec 
>command fields v2
>
>On Fri, Jul 17, 2009 at 06:46:01PM +0800, Takashi Iwai wrote:
>> At Fri, 17 Jul 2009 18:41:05 +0800,
>> Guo, Chaohong wrote:
>> > 
>> > Although it does address this issue, I am not comfortable 
>with this fixing. 
>> > It seems more like a workaround than fix.
>> 
>> No, it's rather for catching a bug.  This is definitely neither
>> "workaround" nor "fix".
>
>Yes, I wrote this mainly for catching unknown bugs.

Oh, I misunderstood your intention.  So, we still need to  investigate
the bug which occurs on RH i386 version  :)



>
>> >  Moreover, if long format node
>> > ID is used in the future,  the code will cause little 
>trouble for maintaining.
>> 
>> Well, the current code doesn't support the long id (as the 
>restriction
>> of HD-audio controller side), so we'd need major changes in anyway.
>> Thus this check is no big issue for maintenance, at least to me :)
>
>Does the HDA spec define cmd format that accept long form NID?
>If so, can you point me to the specific location please? Thanks.

No.  AFAIK,  HDA doesn't specifiy long NID verb yet,  I said "In the
feature".   but who knows why hardware vendors want to use long
NID in the future,  seems 128 is enough.


-minskey


>
>> > what I want is to fix it during parsing connection list, 
>and verify the node
>> > id is valid there .  
>> 
>> Heh, this was already fixed :)
>
>AFAIK, snd_hda_get_connections() won't return NIDs bigger than
>0x7f(short) or 0x7ffff(long).
>
>Thanks,
>Fengguang
>
