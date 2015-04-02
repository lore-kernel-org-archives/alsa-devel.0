From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Thu, 02 Apr 2015 07:39:10 +0100
Message-ID: <1427956750.6532.11.camel@loki>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <1427820547.2856.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1427891224.2711.31.camel@loki>
 <CAN8cciYU-KKSUhYQZgvqLHdAQFtBnpwaDtJ1K_fRwEROM-PRdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 99DBA2604BA
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 08:39:17 +0200 (CEST)
In-Reply-To: <CAN8cciYU-KKSUhYQZgvqLHdAQFtBnpwaDtJ1K_fRwEROM-PRdg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>, Han Lu <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-04-02 at 07:24 +0800, Raymond Yau wrote:
> > > > >
> > > >
> > > > I've added a few others on the CC that would be interested.
> > > >
> > > > > My understanding is that a UCM device can represent a thing
> that has
> > > > > both input and output (I don't particularly like that, but
> it's too late
> > > > > to complain).
> > > >
> > > > Yes, but it can also represent simplex devices too e.g.
> > > > "Headset-Speakers" and "Headset-Mic". There are not any hard
> rules here,
> > > > but most examples are using duplex devices as historically UCM
> came from
> > > > the phone ecosystem use cases.
> 
> On some mobile phones which have FM radio , how do UCM handle FM radio
> since it need to use the headphone as antenna ?

This use case is just treated like any other where we have to set the
proper kcontrols and devices in the UCM config. This would include the
headphone if required for audio playback or antenna.

Liam
