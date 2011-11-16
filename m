From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: First test of the hda-jack branch
Date: Wed, 16 Nov 2011 11:07:38 +0100
Message-ID: <4EC38B6A.8090009@canonical.com>
References: <4EBD4C04.3090406@canonical.com> <s5hwrb67gax.wl%tiwai@suse.de>
	<4EBD80CF.2070203@canonical.com> <s5h8vnj6odk.wl%tiwai@suse.de>
	<4EC140A4.2060408@perex.cz> <4EC22F3D.6030001@canonical.com>
	<CAN8cciZ2sC-2TtONkjirgzeAH0GwL43R31681Ue_djB4E_-Csg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id EEF591039A1
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 11:07:39 +0100 (CET)
Received: from hd9483857.selulk5.dyn.perspektivbredband.net ([217.72.56.87]
	helo=[192.168.8.102]) by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1RQcP4-0005Z6-GG
	for alsa-devel@alsa-project.org; Wed, 16 Nov 2011 10:07:38 +0000
In-Reply-To: <CAN8cciZ2sC-2TtONkjirgzeAH0GwL43R31681Ue_djB4E_-Csg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/16/2011 10:50 AM, Raymond Yau wrote:
> 2011/11/15 David Henningsson<david.henningsson@canonical.com>:
>> On 11/14/2011 05:24 PM, Jaroslav Kysela wrote:
>>> Date 14.11.2011 10:32, Takashi Iwai wrote:
>>>> At Fri, 11 Nov 2011 21:08:47 +0100,
>>>> David Henningsson wrote:
>>>>>
>>>>> In addition, I have a question about the second machine, which looks
>>>>> like this:
>>>>>
>>>>> numid=45,iface=CARD,name='Front Headphone Jack'
>>>>> numid=47,iface=CARD,name='Front Mic Jack'
>>>>> numid=48,iface=CARD,name='Line Jack'
>>>>> numid=41,iface=CARD,name='Line-Out Jack'
>>>>> numid=42,iface=CARD,name='Line-Out Jack',index=1
>>>>> numid=43,iface=CARD,name='Line-Out Jack',index=2
>>>>> numid=44,iface=CARD,name='Line-Out Jack',index=3
>>>>> numid=46,iface=CARD,name='Rear Mic Jack'
>>>>>
>>>>> Would it be possible to name the Line-Out Jacks "Front Line-Out",
>>>>> "Surround Line-Out" etc, so one can tell which one is which? Or can you
>>>>> always tell that just from the order of them?
>>>>
>>>> I can assign more intuitive names for the output, certainly.
>>>> I'll consider the implementation.
>
> How about those dell xps notebooks which have dual headphone jacks ?

We'll have to find a good naming convention for them as well, IMO.

>>> Perhaps, the jacks should be described (control name) using physical
>>> parameters (location, color, connector type). Many codecs support both
>>> directions and I saw some bug-reports that ALSA cannot reassign the
>>> direction of jacks -
>>
>> We can essentially do that in snd-hda-intel with the reconfiguration
>> feature. That will also recreate the jacks with the new name. This seems
>> to be a reasonable way forward IMO.
>
> can you describe more detail about the reconfiguration since I try to
> solve the problem of asus M2N ad1988 with 3 audio jacks(green, blue
> and pink at rear panel) by the auto model instead of "3stack" model?

The reconfiguration is described here: 
http://www.kernel.org/doc/Documentation/sound/alsa/HD-Audio.txt under 
the section "HD-Audio reconfiguration"

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
