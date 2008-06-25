From: "Kan-I Jyo" <cecilhsujp@gmail.com>
Subject: Re: [Fwd: [Alsa-user] Intel Poulsbo(SCH) chipset does
	not recognize Adi 1986 codec under linux]]
Date: Wed, 25 Jun 2008 12:23:02 +0900
Message-ID: <1e8a3dd0806242023g5bad7aa9j5184d519e10aabc3@mail.gmail.com>
References: <1e8a3dd0806241840m76069ad8sa35058ad8ddb843b@mail.gmail.com>
	<1214358600.4303.155.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 1977C103834
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 05:23:03 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so3094800fka.0
	for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2008 20:23:02 -0700 (PDT)
In-Reply-To: <1214358600.4303.155.camel@razman>
Content-Disposition: inline
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

Dear Tobin,

Thank you for your response.

2008/6/25 Tobin Davis <tdavis@dsl-only.net>:
> If the system you are referring to is a development platform, then it is
> possible that the jumper settings on your sound board are not configured
> correctly.

This was the first thing that came to my mind as well.
To make sure that the hardware is correctly configured, we had
installed a retail version of Windows XP to this device along with
SoundMAX driver as well. And the misterious thing is that sound output
was working on this revision 06 device with Windows XP but not Linux.

> One simple test is to swap sound boards.

This is a good idea and worth trying. However, as all chips including
the sound codec are hard-wired on this board, there is no extra slots
like pci or isa available for me to make such a test.


> Another thing to look  at is the bios settings.

Another good point that inspires me. I have digged around the BIOS
menu. There did be some difference between the working machine and the
not-working one. Frustratingly, the sound codec chip remains
unrecognized even they have exact settings along with each other after
adjustments.

> The mainstream alsa driver should not care about the chipset revision.  But if the audio hardware is misconfigured, that would cause it not to work.

I can't not agree with you more. Though it seems that there is less
possibility as the device works under Windows, I wil try to see if
there were any other hardware jumper that I can adjust.

On the other hand, is there any other thing/info that I can do to help
solve phenomenon?


-- 
Sincerely,

Jyo
