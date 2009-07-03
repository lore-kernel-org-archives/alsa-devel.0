From: ruben@ugr.es
Subject: Re: [PATCH] Enable loudspeakers in ALC889 for Acers
 and others [fixed]
Date: Fri, 3 Jul 2009 16:20:22 +0200 (CEST)
Message-ID: <41798.87.217.178.68.1246630822.squirrel@goliat2.ugr.es>
References: <32768.87.217.178.68.1246471476.squirrel@goliat7.ugr.es><59656.8
	7.217.178.68.1246606000.squirrel@goliat9.ugr.es><s5hhbxucg8d.wl%tiwai@suse.de>
	<s5heisycf45.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ugr.es (mail3.ugr.es [150.214.35.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 380F124459
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 16:20:24 +0200 (CEST)
In-Reply-To: <s5heisycf45.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> At Fri, 03 Jul 2009 10:39:46 +0200,
> I wrote:
>>
>> At Fri, 3 Jul 2009 09:26:40 +0200 (CEST),
>> ruben@ugr.es wrote:
>> >
>> > > At Thu, 2 Jul 2009 22:12:02 +0200 (CEST),
>> > > ruben@ugr.es wrote:
>> > >>

>> > ...
>> > >> > Does this happen even with the latest alsa-driver snapshot?
>> > >> >   ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>> > >> >
>> > >> >
>> > >> > Takashi
>> > >> >
>> > >>
>> > >> I installed the snapshot, and it has some good things and some bad
>> > >> things.
>> > >> --Good new things
>> > >> -The loudspeakers work correctly on boot.
>> > >> -The headphones jack sense works, and mutes the loudspeakers when I
>> > >> insert
>> > >> headphones.
>> > >>
>> > >> --Bad new things
>> > >> -The headphones don't provide any sound (regression with respect to

>> > Headphones are still muted in today's snapshot.
>>
I tested the snapshot for today (03/07/09) and everything works perfectly.
I think the headphones were acting funny yesterday, since the snapshot for
30/06 works perfectly as well.
I am positive 1.0.20 does not work, so the fix is somewhere in between.
Thanks to all for their great work!

I also need somebody to mark
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4261
as resolved fixed. I can't close it, since the reporter is somebody else,
who seems to have disappeared.
