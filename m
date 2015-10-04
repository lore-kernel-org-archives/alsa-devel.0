From: Arun Raghavan <arun@accosted.net>
Subject: Re: [REANNOUNCE] Audio Mini Summit 2015, 8th October,
	Dublin
Date: Sun, 4 Oct 2015 14:54:43 +0530
Message-ID: <CACuU-+h6hn2MtsbagBb5JYFbR8psqRhc17Df3J0v19FNUiTT_Q@mail.gmail.com>
References: <20150714150352.GW11162@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70108CC68@RTITMBSV03.realtek.com.tw>
 <55B6B92B.5010305@linux.intel.com> <20150803031552.GN29916@localhost>
 <CACuU-+ig60xn85_fKKoZRESDcupwZRekShQ-Jj3Bpj4pZu5EeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f180.google.com (mail-yk0-f180.google.com
 [209.85.160.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D6BD26510B
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2015 11:25:04 +0200 (CEST)
Received: by ykdz138 with SMTP id z138so146670572ykd.2
 for <alsa-devel@alsa-project.org>; Sun, 04 Oct 2015 02:25:03 -0700 (PDT)
In-Reply-To: <CACuU-+ig60xn85_fKKoZRESDcupwZRekShQ-Jj3Bpj4pZu5EeA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi again, all,

On 22 September 2015 at 14:19, Arun Raghavan <arun@accosted.net> wrote:
> On 3 August 2015 at 08:45, Vinod Koul <vinod.koul@intel.com> wrote:
>> On Mon, Jul 27, 2015 at 06:05:15PM -0500, Pierre-Louis Bossart wrote:
>>> On 7/21/15 6:29 AM, Bard Liao wrote:
>>> >>-----Original Message-----
>>> >>From: Mark Brown [mailto:broonie@kernel.org]
>>> >>Sent: Tuesday, July 14, 2015 11:04 PM
>>> >>To: Takashi Iwai; Liam Girdwood; Jaroslav Kysela
>>> >>Cc: alsa-devel@alsa-project.org
>>> >>Subject: [REANNOUNCE] Audio Mini Summit 2015, 8th October, Dublin
>>> >>
>>> >>Like previous years, we're going to hold a meeting to discuss lowlevel
>>> >>audio on Linux.  This will be held the day after ELC Europe on 8th
>>> >>October at CCD (The Convention Centre) in Dublin.
>>> >>
>>> >>If you're interested please sign up in the attendee list:
>>> >>
>>> >>https://docs.google.com/spreadsheets/d/1bi-8GHsqlzt41FR20WiMuWILe_
>>> >>cZowFireVMBd-QM8Q/edit?usp=sharing
>>> >>
>>> >>and please follow up to this mail with any topics you'd like to see raised so
>>> >>we can start collecting them (probably another Google doc will be
>>> >>forthcoming for them).
>>> >>
>>> >>Previously suggested topics include:
>>> >>
>>> >>  - Reducing kernel size for IoT applications
>>> >>  - ACPI simple-card
>>>
>>> I think we should also share findings on DeviceTree vs. ACPI support
>>> for machine drivers and subnodes.
>>
>> I am planning to discuss two things in this space:
>> - One the NHLT table in BIOS
>> - Second my ongoing work on ACPI properties for machines, hopefully should be
>>   able to send patches before conference
>
> I have a a couple of things to add:
>
> 1. The BATCH flag, granularity, etc. again (this is really biting us
> with USB devices since we're respecting it)
>
> 2. Some work I've been doing on configuration (not the consolidation
> we were looking for at the end of last meeting, but something I should
> be able to send a link to here in a week or two)

I was hoping to get just a bit more done before sending this out, but
there's not much time left before the audio meetup. I've been working
on a tool to make it a bit easier to translate Android XML
configuration to UCM. It's up at:

  https://github.com/ford-prefect/xml2ucm

The idea is to take the mixer_paths.xml, write a bit of extra
configuration as a separate file describing devices, use cases, etc.
and then have UCM output from that. You can see some example
configuration for the Sony Xperia Z3 Compact (aries) at:

  https://github.com/ford-prefect/xml2ucm/blob/master/examples/aries-l-config.xml
  https://github.com/ford-prefect/xml2ucm/blob/master/examples/aries-l-mixer_paths.xml

That particular configuration works fine for HiFi. I was hoping to get
the voice call config also done by now, but it's been a bit uphill
since I'm working without any specs.

I'm happy to hear feedback on whether this is useful, what else you'd
like to see if it is, and anything else you might have comments on.

Cheers,
Arun

p.s.: Yes, it's in Haskell, sorry about the added pain there. I'm
planning on having this also available as a simple web service so you
don't have to build it to use it (the README should have accurate
documentation on how to build, though).
