From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: MPC5200/WM9712 mute problem
Date: Fri, 7 Aug 2009 11:16:12 -0400
Message-ID: <9e4733910908070816x4aa3ab8nc79fd65dd56efca0@mail.gmail.com>
References: <20090731230311.17686.46431.stgit@riker>
	<9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
	<1249139096.4582.13.camel@riker> <20090802114950.GA1778@sirena.org.uk>
	<1249489853.4582.58.camel@riker>
	<20090805170305.GC16844@sirena.org.uk>
	<1249579721.5844.88.camel@riker>
	<20090807095601.GA8175@rakim.wolfsonmicro.main>
	<1249656522.5844.89.camel@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 78E5D1038D8
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 17:16:14 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so434336anc.2
	for <alsa-devel@alsa-project.org>; Fri, 07 Aug 2009 08:16:12 -0700 (PDT)
In-Reply-To: <1249656522.5844.89.camel@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 7, 2009 at 10:48 AM, John Bonesio<bones@secretlab.ca> wrote:
> On Fri, 2009-08-07 at 10:56 +0100, Mark Brown wrote:
>> On Thu, Aug 06, 2009 at 10:28:41AM -0700, John Bonesio wrote:
>>
>> > I'm open to more suggestions or thoughts on the approach I've taken so
>> > far.
>>
>> The approach you've been taking sounds reasonable; at this point I'd be
>> looking at trying to confirm that the controller is doing what's been
>> asked of it. =A0Checking that the CODEC power rails are all within spec
>> and looking at other bits in the same register may also be useful.

You can turn on an interrupt that gets triggered when the register
wire completes. That would give you a clue if too many register writes
are happening.

A DSO or logical analyzer would make this much faster to isolate.

>>
>> Is the system otherwise idle when the problem occurs?
>
> Yes the system is idle - just me fiddling with the mute settings.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- =

Jon Smirl
jonsmirl@gmail.com
