From: Mark Goldstein <goldstein.mark@gmail.com>
Subject: Re: [PATCH] ALSA: HDA: Fix mic initialization in VIA
 auto parser (was: pci/hda/patch_via.c - broken between 2.6.36 and 2.6.37
 (bisected))
Date: Wed, 23 Mar 2011 12:58:36 +0200
Message-ID: <AANLkTikUhVuh1VYYaWM1kyQ8e_X3nUiE17V22q01eeks@mail.gmail.com>
References: <ijqrmf$tlg$1@dough.gmane.org>
	<AANLkTin4TQvLwZX_mjhHq66STrsrXJu9a+bvsiSdxXub@mail.gmail.com>
	<4D6223CD.4060900@canonical.com>
	<AANLkTinDJ7k3pXqg7ZP5pcGVXUt+xWYRTv-pa4_=J15b@mail.gmail.com>
	<4D62308E.8070606@canonical.com> <ik066p$5li$1@dough.gmane.org>
	<imcip6$qos$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id D434024463
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 11:58:56 +0100 (CET)
Received: by ewy28 with SMTP id 28so1884736ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 03:58:56 -0700 (PDT)
In-Reply-To: <imcip6$qos$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 23, 2011 at 12:41 PM, Wolfgang Scheicher
<wolfgang.scheicher@gmail.com> wrote:
> Wolfgang Scheicher wrote:
>
>> David Henningsson wrote:
>>
>>> On 2011-02-21 09:43, Mark Goldstein wrote:
>>>> [...]
>>>>
>>>> I've never dealt with submitting patches, so probably it'll be better
>>>> (and definitely faster) if you could do it.
>>>>
>>>> Thank you,
>>>
>>> Ok, here comes the patch!
>>
>> Tested, and Microphone now works! Thanks a lot to everyone involved.
>> Good job so far!
>
> Hmm ... Just tried kernel 2.6.38 from debian sid, and Microphone is not
> working again. However, this fix is in.
> What might have broken it this time?
> I hope to find some time to track down the commit somewhen the next days ...
>

Wolfgang,

When I was fighting with Mic issue, I used hda-analyser script. Try it
and check how the pin 0x1e (Front Mic) is configured.
My symptom was that this pin has been initiated with VREF Hi-Z.
If you see that, try changing it to VREF 50. Mic should start working.

Regards,
-- 
Mark Goldstein
