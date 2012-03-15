From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Thu, 15 Mar 2012 17:28:13 -0400
Message-ID: <CA+7tXijgsT3uitVa-=VLmKY2ubQpgff0hkKjA5jz6QCFp9_PiA@mail.gmail.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
	<20120315175310.GR3138@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 0613624402
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 22:28:13 +0100 (CET)
Received: by wibhq7 with SMTP id hq7so7849504wib.2
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 14:28:13 -0700 (PDT)
In-Reply-To: <20120315175310.GR3138@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ramesh Babu <ramesh.babu@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 15, 2012 at 1:53 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Mar 15, 2012 at 03:23:04PM +0530, Ramesh Babu wrote:
>> I need to make sure that all simultaneous playback and capture (across t=
he
>> all dai_links) needs to be of same frequency family.
>> If the sampling frequency of =A0a new request is different from ongoing
>> playback/capture, then it needs to be rejected.
>
>> How do I handle it in machine driver?
>
> Why do you need to do this in the machine driver? =A0Such a constraint
> sounds like it's coming from one of the chips in the system rather than
> from the machine itself so it'd seem sensible for the chip itself to
> impose the constraint so that other machines don't need to replicate the
> code.
>
> See wm8988 for an example of adding sample rate constraints, obviously
> you can change the criteria dynamically.

There is a race when the constraints change dynamically.  See the
fsl_ssi.c driver and the sample size constraint in synchronous mode.

Say you have two substreams that must be at the same rate.  The first
pcm substream opens, gets a constraint based on current conditions.
If no other substreams are initialized, then this is a range of sample
rates.  Now a second substream opens, before the first is initialized,
and gets the same constraints of a range of sample rates.  The second
stream initializes and starts.  This means the first substream must
now be constrained to be the same sample rate as the second.  But
those constraints were set when the first stream opened.  There's no
way to change them now.
