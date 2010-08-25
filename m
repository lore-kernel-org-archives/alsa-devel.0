From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Wed, 25 Aug 2010 10:28:14 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
References: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
	<alpine.LNX.2.00.1008231907170.10278@eeebox2.perex-int.cz>
	<1282640988.3053.43.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E575210384F
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 10:28:14 +0200 (CEST)
In-Reply-To: <1282640988.3053.43.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Aug 2010, Liam Girdwood wrote:

> On Mon, 2010-08-23 at 19:47 +0200, Jaroslav Kysela wrote:
>
>> Unfortunately, I have many ideas to improve the API before I can approve
>> or recommend the inclusion to the alsa-lib's tree.
>>
>
> I wish you had shared your API ideas with us at the time of the RFC. A
> lot of time and effort has since went into UCM development :-/

I too. My big problem is the lack of time.

I tried to rethink the API to be more universal for future extensions (but 
the implementation will not dramatically change and the mechanisms you 
want to expose are not touched at all). I just wanted to add the 
possibility to create the virtual cards combining resources from any 
PCM/control/mixer device available in system. The proper device evaluation 
and mixer control assignments is something which is wanted by PulseAudio 
developers.

My proposed header file with reduced function set but not reduced 
functionality is available at:

http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=include/use-case.h;h=33d480f66d000fa7c86367c68b98bdaad9217a74;hb=fcc9adb26058667656277ba92032ba7e0b00261c

The syntax of your proposed files is very close to the other alsa-lib's 
syntax. For example:

SectionModifier
 	Name "Capture Voice"
 	EnableSequence
 		seq1 1
 	EndSequence
 	QoS Voice
EndSection

Can be written in alsa-lib's syntax:

SectionModifier."Capture Voice" [
 	EnableSequence [
 		seq1 1
 	]
 	QoS Voice
]

So I'm thinking to recode all parsers to use the alsa-lib configuration 
parsers. As bonus, the alsa-lib configuration routines give us some 
runtime evaluation and possibility to reference (include) other files.

Next step may be to support the 'amixer' like syntax for the control and 
mixer element handling.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
