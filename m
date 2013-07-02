From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Tue, 02 Jul 2013 15:30:51 +0200
Message-ID: <51D2D60B.2010205@topic.nl>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D22CAE.2020302@ti.com> <51D26CD8.7020709@topic.nl>
 <20130702121625.GM27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob10.myregisteredsite.com
 (atl4mhob10.myregisteredsite.com [209.17.115.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 8561726547B
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 15:30:55 +0200 (CEST)
Received: from mailpod.hostingplatform.com ([10.30.71.210])
 by atl4mhob10.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r62DUs3b018891
 for <alsa-devel@alsa-project.org>; Tue, 2 Jul 2013 09:30:54 -0400
In-Reply-To: <20130702121625.GM27646@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Joel Fernandes <joelf@ti.com>, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On 07/02/2013 02:16 PM, Mark Brown wrote:
> On Tue, Jul 02, 2013 at 08:02:00AM +0200, Mike Looijmans wrote:
>> On 07/02/2013 03:28 AM, Joel Fernandes wrote:
>
>>> Sweet! Any particular reason why it wasn't merged in vs the existing ping-pong code?
>
>> I've posted questions and other stuff concerning the McASP/OMAP1,
>> but there was very little interest, so I supposed the chipset was on
>> its way out and there wasn't any point in maintaining it.
>
> Did you CC the relevant maintainers and other people working on the
> code?  You've not done so on this thread...  if you only post to the
> list it's very likely that people won't see what you've sent.

I'm relatively new to Linux kernel programming. The key problem for me 
was - and still is - that there is so overwhelmingly much information 
available, that it's virtually impossible to find out things that would 
be obvious for long-time developers, like finding out who the maintainer 
for a piece of code is. I still don't know that, by the way. How do I 
find the "CC" list that I'm supposed to send bugs/suggestions/patches to 
for a given piece of code?

I guess that a document on 
kernel-driver-development-for-people-who-used-to-work-with-a-centrally-organized-OS-and-used-to-get-all-their-answers-from-them 
would help, but then again finding that particular document - or 
realizing that it even exists (it doesn't, does it?) - would be the next 
problem.

It's quite easy to find out how one goes about writing a driver, but the 
process surrounding it - such as finding whether such a driver already 
exists, where to go for technical advice and where to post the git patch 
for inclusion in mainline is something that no one seems to want to 
dwell on.

Sorry if I'm ranting here. Maybe in time I'll learn to behave...

Mike
