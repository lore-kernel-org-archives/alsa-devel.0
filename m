From: "Tellman, Steven" <Steven.Tellman@idt.com>
Subject: Re: SOLVED: Re: Dell Studio 15 - aka Inspiron 1535
	sound problems: HDA intel and codec IDT (STAC) 92HD73C1X5
Date: Thu, 7 Aug 2008 08:32:25 -0700
Message-ID: <16A430A423D62246A24C9A892622FE663464C0@CORPEXCH1.na.ads.idt.com>
References: <48987087.4040001@avalpa.com> <48995ECF.2040607@avalpa.com>
	<489A1376.3040005@avalpa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout2.mainstreet.net (mxout2.mainstreet.net [204.69.220.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 60AE2248C5
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Aug 2008 17:32:35 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <489A1376.3040005@avalpa.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrea Venturi <a.venturi@avalpa.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yes, EQ is in development as an ALSA plug-in.

IDT PC Audio Marketing Engineer/Linux Manager
W: (512) 330-3127

-----Original Message-----
From: alsa-devel-bounces@alsa-project.org
[mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Andrea Venturi
Sent: Wednesday, August 06, 2008 4:11 PM
To: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] SOLVED: Re: Dell Studio 15 - aka Inspiron 1535
sound problems: HDA intel and codec IDT (STAC) 92HD73C1X5

Andrea Venturi wrote:
> Andrea Venturi wrote:
>> hi, i own a brand new Dell laptop Studio 15
>>
>> the audio speakers stay mute if i play an audio file. :-|
>>
>
> now it works (more or less).

hi. i'm back again with a little issue.

the sound max volume is not as high as the other OS standard.

i had a little thread in the Dell Linux mailing list about this issue:

 
http://lists.us.dell.com/pipermail/linux-desktops/2008-August/001808.htm
l


and, to make a long story short, Dell's Mario Limonciello told me that
the max master volume has been reduced from 0xff to 0xec, to solve some
distortion (resonance) issues at higher levels, with this commit:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=d654a660355f9d
c30d3a6bf1493d32363bde8570

this is not going to change until there's some Band EQualization
software support in the alsa driver that can reduce this resonance
issues at higher volume levels.

do you know if something like this is in development?

i gave a quick look to the Stac/IDT 92HD73C1XXX codec datasheet
http://www.idt.com/?genID=92HD73C1 and i'm going to believe there's no
HW support about band filtering..  (the datasheet indeed speaks about a
SigmaTel Kernel Processing Interface AKA /SKPI/ ) so it should it be a
complete software solution for linux too! right?

bye

andrea venturi
