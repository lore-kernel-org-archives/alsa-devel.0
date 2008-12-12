From: "Alex Austin" <circuitsoft.alex@gmail.com>
Subject: Re: Trying to get unsupported CODEC to work
Date: Thu, 11 Dec 2008 18:05:14 -0600
Message-ID: <53baa24a0812111605vf0702eao262ab3e72c934a95@mail.gmail.com>
References: <53baa24a0812111428j143c23berb8ba0819b6b55eac@mail.gmail.com>
	<4941A886.9040804@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by alsa0.perex.cz (Postfix) with ESMTP id 9C314243BC
	for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2008 01:05:15 +0100 (CET)
Received: by gxk9 with SMTP id 9so1451804gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 16:05:14 -0800 (PST)
In-Reply-To: <4941A886.9040804@cox.net>
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
To: stan <ghjeold_i_mwee@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The problem, at this point, is that the mixer isn't even showing all the
channels for the second codec. Secondly, I can only see one codec at a time,
and I need to use both for my setup.
The mentioned pastebin is the SVG output of codecgraph on the second codec
on this system.

On Thu, Dec 11, 2008 at 5:55 PM, stan <ghjeold_i_mwee@cox.net> wrote:

> Alex Austin wrote:
>
>> HelloI have an MSI Media Live DIVA motherboard. It has an AMD SB600 HD
>> Audio
>> controller, and two CODECs on the HDA bus.
>>
>> First is an ALC888
>> Second is an Intersil DAE-3.
>>
>> Two alsa-info outputs in different circumstances
>> http://www.alsa-project.org/db/?f=20c86e755fdbbdbc8761c8c2f4de76bce2ea0c11
>> http://www.alsa-project.org/db/?f=15c5e5eab0104622a84b2dd0df03f26c17c7242d
>>
>> Output of codecgraph with "modprobe hda-intel probe_mask=2"
>> http://pastebin.com/f54b6a9b8
>>
>> What's the next step to get this supported?
>>
>
> In both alsa-info.sh outputs, you have outputs turned on, but they are at
> zero volume.  Have you tried running alsamixer to turn up volumes?  If you
> are running pulseaudio you might have to use pulse to turn up volumes, I
> don't use it so I can't help with that.
>
> Alsa starts with volumes at zero by default.
>
> The other thing is you are using an older version of everything.  I think
> the latest is at 1.0.18, and there are links on the page as
> http://www.alsa-project.org to get a tar ball of the very latest version
> available.  There are no guarantees, but it might help as changes go in
> every day.
>
>


-- 
- Alex Austin
(651) 238-9273

"...and then I visited Wikipedia ...and the next 8 hours are a blur."
