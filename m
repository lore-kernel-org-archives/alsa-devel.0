From: Chris J Arges <chris.j.arges@canonical.com>
Subject: Re: [PATCH v3 0/4] Scarlett mixer interface inclusion
Date: Mon, 03 Nov 2014 09:49:37 -0600
Message-ID: <5457A411.7080905@canonical.com>
References: <s5h1tq0egzi.wl-tiwai@suse.de>
 <1414616163-14146-1-git-send-email-chris.j.arges@canonical.com>
 <7822588.pH2Cdg4lJ9@eriador>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D19AD2604F6
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 16:49:40 +0100 (CET)
In-Reply-To: <7822588.pH2Cdg4lJ9@eriador>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dominik Haumann <dhaumann@kde.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 11/02/2014 01:00 PM, Dominik Haumann wrote:
> Hi Chris,
> 
> On Wednesday 29 October 2014 15:55:59 Chris J Arges wrote:
>> This is v3 of the patchset to merge what Tobias Hoffman and Robin Gareus have
>> done to enable the Focusrite Scarlett mixers for use with ALSA.
>>
>> I have split the commits into hopefully a logical series. First the original
>> quirk is reverted for one model of a Scarlett device. Next an additional
>> structure is added to be able to more easily reuse usb_mixer_elem_info.
>> After this mixer functions that were useful to this code were made public.
>> Finally the last patch adds the necessary functions to make this mixer work.
>>
>> I have only tested this on my own device which is a Focusrite Scarlett 18i8, 
>> any additional testing would be appreciated.
> 
> I have a 6i6, and ran `alsa-info.sh` on the following configurations:
> 
> Kernel without patch:
> - kernel-3.11 (openSUSE)
> - output of alsa-info.sh: http://paste.kde.org/ps7bionk7
> 
> Kernel with patch (v3):
> - kernel-3.18-rc2, self-compiled following [1]
> - output of alsa-info.sh: http://paste.kde.org/pjb8wgbxe (starting
>   from line 999)
> 
> I'm not too familiar with interpreting this output. It seems to me that
> a lot of mixer controls are listed (maybe even too many for the 6i6?)
> If you need more information, or if I should test something specific,
> please let me know.
>

I believe this looks as it should (although I don't have this device),
there are a lot of controls to be able to use the matrix mixing
functionality. So this allows you to create separate mixes for various
mix buses. The way this is setup in the alsamixer is there is an Matrix
X Input which one can select which input one wants to mix, and then a
series of Mixes A-H which correspond to output volume.

Testing various inputs and outputs to see if this is working as expected
would be very helpful.

> What I found when rebooting into my old kernel again, the internal
> state of the Scarlett Focusrite 6i6 changed, meaning that I had to turn
> the device off and on again to reset it to the stored state. Not sure
> whether this is related to the patch, though?!
>

I've noticed this too even with the original patch. The code currently
does initialize values when it starts, and even if I remove those
initializations it initializes to some not very useful defaults. If I
manually power on and off the device it goes to the stored default. The
stored default can be modified by using the 'Save to HW' control; and
this does work.

--chris

> Greetings,
> Dominik
> 
> [1] https://www.suse.com/communities/conversations/compiling-de-linux-kernel-suse-way/
> 
