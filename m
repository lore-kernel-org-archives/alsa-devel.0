From: "joey.jiaojg" <joey.jiaojg@gmail.com>
Subject: Re: hda_intel:azx_get_response timeout,
 switching to single_cmd mode: last cmd=0x00070503
Date: Thu, 16 Feb 2012 17:21:20 +0800
Message-ID: <4F3CCA90.9010809@gmail.com>
References: <loom.20120216T051747-31@post.gmane.org>
	<1329383904.3518.31.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 700ED244B4
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 10:21:33 +0100 (CET)
Received: by obbup6 with SMTP id up6so2769067obb.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 01:21:32 -0800 (PST)
In-Reply-To: <1329383904.3518.31.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org, Sirus Jolt <sirusjolt@rocketmail.com>
List-Id: alsa-devel@alsa-project.org

I had similar issue from dmesg once.
The NID,VERB,PARM works if I use hda-verb, So I think it's not a big 
problem since everything works.

On 2012?02?16? 17:18, Paul Menzel wrote:
> Dear Sirus,
>
>
> Am Donnerstag, den 16.02.2012, 04:29 +0000 schrieb Sirus Jolt:
>> Hi, I've got some problems to start session, because i've got the message like
>> subject:
>>
>> hda_intel: azx_get_response timeout, switching to single_cmd mode: last
>> cmd=0x00070503
>>
>> I have no idea about the problem, I need your help. In some threat mention it
>> but don't have the answer.
> your message misses a lot of useful information which would help
> developers (not me) to help you.
>
> Also do you notice any problems? That means, does audio work for you?
>
>
> Thanks,
>
> Paul
>
>
> [1] http://alsa-project.org/main/index.php/Help_To_Debug
> (Please attach that file to your next answer *and* upload it.)
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
