From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Thu, 16 Apr 2015 11:31:48 +0300
Message-ID: <1429173108.2971.0.camel@tkkaskin-mobl3.ger.corp.intel.com>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <1427820547.2856.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1427891224.2711.31.camel@loki>
 <CAEUnVG4iCJGGPw2=R+TxVCoj3ky2SBgZDpZrFbswXh36b-WydA@mail.gmail.com>
 <1428439055.12283.54.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1429112366.4506.9.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <CAEUnVG4A=p04fkZ+6ZMr0_NhDTcOs=S9er5FR1zrYUQjiCBryg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D69C26067E
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 10:31:53 +0200 (CEST)
In-Reply-To: <CAEUnVG4A=p04fkZ+6ZMr0_NhDTcOs=S9er5FR1zrYUQjiCBryg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>, Han Lu <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-04-15 at 09:10 -0700, Dylan Reid wrote:
> On Wed, Apr 15, 2015 at 8:39 AM, Tanu Kaskinen
> <tanu.kaskinen@linux.intel.com> wrote:
> > On Tue, 2015-04-07 at 23:37 +0300, Tanu Kaskinen wrote:
> >> I'm not sure what you mean... "There is always one UCM device [...] per
> >> jack" sounds like you want there to be only one device representing
> >> headset, but on the other hand you talk about it being advantageous to
> >> have a separate device for the headphone and mic... Can you clarify the
> >> number of UCM devices per physical headset jack?
> >
> > Ping? I'd like to get this clarified, because depending on what CRAS
> > does, we may or may not have to change the use-case.h documentation (and
> > PulseAudio code).
> 
> Sorry I missed this.  CRAS handles separate UCM devices for the
> headphone and mic of a combo jack.  However there is no support for
> handling a "Headset Jack" kcontrol or input event.  We have ensured
> all our platforms are capable of detecting if a mic is present and
> that they report the headphone and mic as separate jacks.

Thanks, no need to change anything then! (At least for now.)

-- 
Tanu
