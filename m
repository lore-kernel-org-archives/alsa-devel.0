From: Dylan Reid <dgreid@chromium.org>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Thu, 2 Apr 2015 08:28:43 -0700
Message-ID: <CAEUnVG4iCJGGPw2=R+TxVCoj3ky2SBgZDpZrFbswXh36b-WydA@mail.gmail.com>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <1427820547.2856.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1427891224.2711.31.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f41.google.com (mail-yh0-f41.google.com
 [209.85.213.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E61B260569
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 17:29:06 +0200 (CEST)
Received: by yhfw71 with SMTP id w71so21696715yhf.2
 for <alsa-devel@alsa-project.org>; Thu, 02 Apr 2015 08:29:05 -0700 (PDT)
In-Reply-To: <1427891224.2711.31.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>, Han Lu <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 1, 2015 at 5:27 AM, Liam Girdwood
<liam.r.girdwood@linux.intel.com> wrote:
> On Tue, 2015-03-31 at 19:49 +0300, Tanu Kaskinen wrote:
>> Reviving this thread...
>>
>> On Thu, 2015-03-19 at 09:15 +0000, Liam Girdwood wrote:
>> > On Wed, 2015-03-18 at 21:41 +0200, Tanu Kaskinen wrote:
>> > > Hi Liam and alsa-devel,
>> > >
>> >
>> > I've added a few others on the CC that would be interested.
>> >
>> > > My understanding is that a UCM device can represent a thing that has
>> > > both input and output (I don't particularly like that, but it's too late
>> > > to complain).
>> >
>> > Yes, but it can also represent simplex devices too e.g.
>> > "Headset-Speakers" and "Headset-Mic". There are not any hard rules here,
>> > but most examples are using duplex devices as historically UCM came from
>> > the phone ecosystem use cases.
>> >
>> > > How likely do you think that there are or there will be
>> > > some drivers that expose separate input and output jack kcontrols for a
>> > > headset jack, to differentiate between headphones/headset/microphone? My
>> > > understanding is that jack kcontrols store only booleans, so there's no
>> > > way to distinguish between headphones and a headset with just one kcontrol.
>> > >
>> >
>> > This sounds like we need to extend the jack kcontrol so that we can
>> > differentiate between Headphones and Headset unless the kcontrol naming
>> > was intended to differentiate and define the jack type ?
>>
>> I guess it's now clear that all jack kcontrols will be booleans, and
>> headset jacks will require two jack kcontrols.
>>
>> > > The current UCM "spec" doesn't support specifying multiple kcontrols,
>> > > since there's only one "JackControl" value. (Perhaps the "JackDev" value
>> > > suffers from this problem too, but I don't know if jack input devices
>> > > already support reporting the state separately for input and output.)
>> > >
>> >
>> > I think in this case we could define simplex UCM devices and attach a
>> > JackControl value to each device.
>>
>> So is your preference that UCM configuration authors are forced to
>> define simplex devices to deal with headset jacks, rather than using
>> duplex devices and defining "PlaybackJackControl" and
>> "CaptureJackControl" separately? (I don't personally mind either way.)
>
> I don't really mind either, but what's easier for audio servers like
> pulseaudio that will be the main UCM clients ? I guess that pulseaudio,
> CRAS, and other audio servers probably deal with simplex PCM streams
> internally so mapping to simplex jacks/devices might be better ?

There is an advantage to having a separate device for the headphone and mic
even if they are connected to the same jack.  The user can enable one and not
the other, most commonly to use the headphones but record from the built-in mic,
ignoring the headset mic.  Because of this we require all ChromeOS devices to
support separate reporting and selection of headphone/mic on the headset jack.
There is always one UCM device and one user-visible i/o node per jack.

>
> Liam
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
