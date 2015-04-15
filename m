From: Dylan Reid <dgreid@chromium.org>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Wed, 15 Apr 2015 09:10:26 -0700
Message-ID: <CAEUnVG4A=p04fkZ+6ZMr0_NhDTcOs=S9er5FR1zrYUQjiCBryg@mail.gmail.com>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <1427820547.2856.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1427891224.2711.31.camel@loki>
 <CAEUnVG4iCJGGPw2=R+TxVCoj3ky2SBgZDpZrFbswXh36b-WydA@mail.gmail.com>
 <1428439055.12283.54.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1429112366.4506.9.camel@tkkaskin-mobl3.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f42.google.com (mail-vn0-f42.google.com
 [209.85.216.42])
 by alsa0.perex.cz (Postfix) with ESMTP id A301E2606A5
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 18:10:48 +0200 (CEST)
Received: by vnbg62 with SMTP id g62so16787411vnb.7
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 09:10:47 -0700 (PDT)
In-Reply-To: <1429112366.4506.9.camel@tkkaskin-mobl3.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>, Han Lu <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 15, 2015 at 8:39 AM, Tanu Kaskinen
<tanu.kaskinen@linux.intel.com> wrote:
> On Tue, 2015-04-07 at 23:37 +0300, Tanu Kaskinen wrote:
>> On Thu, 2015-04-02 at 08:28 -0700, Dylan Reid wrote:
>> > On Wed, Apr 1, 2015 at 5:27 AM, Liam Girdwood
>> > <liam.r.girdwood@linux.intel.com> wrote:
>> > > On Tue, 2015-03-31 at 19:49 +0300, Tanu Kaskinen wrote:
>> > >> So is your preference that UCM configuration authors are forced to
>> > >> define simplex devices to deal with headset jacks, rather than using
>> > >> duplex devices and defining "PlaybackJackControl" and
>> > >> "CaptureJackControl" separately? (I don't personally mind either way.)
>> > >
>> > > I don't really mind either, but what's easier for audio servers like
>> > > pulseaudio that will be the main UCM clients ? I guess that pulseaudio,
>> > > CRAS, and other audio servers probably deal with simplex PCM streams
>> > > internally so mapping to simplex jacks/devices might be better ?
>> >
>> > There is an advantage to having a separate device for the headphone and mic
>> > even if they are connected to the same jack.  The user can enable one and not
>> > the other, most commonly to use the headphones but record from the built-in mic,
>> > ignoring the headset mic.  Because of this we require all ChromeOS devices to
>> > support separate reporting and selection of headphone/mic on the headset jack.
>> > There is always one UCM device and one user-visible i/o node per jack.
>>
>> I'm not sure what you mean... "There is always one UCM device [...] per
>> jack" sounds like you want there to be only one device representing
>> headset, but on the other hand you talk about it being advantageous to
>> have a separate device for the headphone and mic... Can you clarify the
>> number of UCM devices per physical headset jack?
>
> Ping? I'd like to get this clarified, because depending on what CRAS
> does, we may or may not have to change the use-case.h documentation (and
> PulseAudio code).

Sorry I missed this.  CRAS handles separate UCM devices for the
headphone and mic of a combo jack.  However there is no support for
handling a "Headset Jack" kcontrol or input event.  We have ensured
all our platforms are capable of detecting if a mic is present and
that they report the headphone and mic as separate jacks.

>
> --
> Tanu
>
