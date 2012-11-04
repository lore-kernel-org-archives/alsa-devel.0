From: Massimo Del Fedele <max@veneto.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Sun, 04 Nov 2012 10:31:27 +0100
Message-ID: <k75cle$1i1$1@ger.gmane.org>
References: <k6rkr2$usv$1@ger.gmane.org>
 <CAN8cciZEwLxxiMp69k8yyAzSnqRNQ6m2=7q373x91D_pMy=h-w@mail.gmail.com>
 <k6tlk1$2vr$1@ger.gmane.org>
 <CAN8cciZQw8m-m-Bk6KF2UuqpU2a5=Y7vAi7daWmqF9vbA2w=4g@mail.gmail.com>
 <k70n1l$65a$1@ger.gmane.org>
 <CAN8cciZWX2tdAUcNeBHpa7eFHYeMnsTN_ngRcj7gRuj46RXnpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 868AB26173C
 for <alsa-devel@alsa-project.org>; Sun,  4 Nov 2012 10:31:47 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TUwYY-0000qJ-U4
 for alsa-devel@alsa-project.org; Sun, 04 Nov 2012 10:31:50 +0100
Received: from host222-225-dynamic.58-82-r.retail.telecomitalia.it
 ([82.58.225.222]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 04 Nov 2012 10:31:50 +0100
Received: from max by host222-225-dynamic.58-82-r.retail.telecomitalia.it with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 04 Nov 2012 10:31:50 +0100
In-Reply-To: <CAN8cciZWX2tdAUcNeBHpa7eFHYeMnsTN_ngRcj7gRuj46RXnpg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm starting to feel lost.... anyways, I'll try to answer to some questions :
 >
> and some asus with vt1802 does not have any subwoofer

That's very possible, the patch should be applied only for selected machines... But I don't know how to do it.

>
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=94c142a160d63edac0e1fca7848960dcf75dd2a9;hp=012e7eb1e501d0120e0383b81477f63091f5e365
>
> do notebook with vt1802 really need independent headphone ?

IMHO, but that's just my opinion, an independent HP is quite useless for notebooks.
AFAIK the unpatched driver maps a DAC to front speakers (0x08) and another for HP (0x09), so
no DAC free for subwoofer. We could maybe mono mix the front channel and route it to subwoofer,
but then you'd have no separate volume control for sub, which makes it useless.

>
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.
> git;a=commitdiff;h=a2a870c82797e47884b2736e95e9d9
> c89a51c219;hp=5c9a5615dedec19196b1217e864616 a2ce9e392a
>
>>
>>>>> should the auto parser put it into autocfg->mono_out?
>>>>
>>>> maybe.... I didn't try that one.
>>>> With both patches the stuffs appears like a 4 channel one; the correct
>>>
>>> would be 2+1, but
>>>>
>>>> I didn't manage to get it right.
>>>
>>>
>
>> The function should scan all paths from DACs to
>> OUTS, but like it is just takes the first available DAC.
>> The problem arises here :
>>
>> if (dac) {
>> spec->private_dac_nids[i] = dac;
>> dac_num++;
>> }
>
>> Which correctly adds DAC to used list, but doesn't
>> update the total number of found DACs
>> in spec->multiout.num_dacs; following calls to
>> is_empty_dac() will always return true
>> for already used DACs, making parse_output_path()
>> return always the first one.
>
> it is because
>
> spec->multiout.num_dacs = cfg->line_outs + spec->smart51_nums;
>
> so this may be the reason for the auto parser put internal speaker 0x24
> into autocfg->lineout

Those are two unrelated things.
The code above is plain wrong (and my patch isn't correct either, but at least makes it
working...); when populating DAC nids, the scanner forgets to update the number of found
needs while scanning; I mean, in practice during the recursive scan the DACS are always free,
so only the first one is returned.

The 0x24 is marked as speaker but is put on line out by auto_parser IF no true line outs are found.
I didn't dig too deep inside it, but I guess that if it finds NO line outs (and asus G75 is the case...)
it takes first speaker channel and puts on line streams. Not the best solution,IMHO.


>
> does this mean that spec->speaker_path and spec->speaker_mix_path  are
> useless ?
>

Dont't know, but being without separate volume controls, all must be controlled
at dac level, I think... and having a speaker out without separate volume
makes no sense.
But I didn't dig much on it.

Max
