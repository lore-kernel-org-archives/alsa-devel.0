From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Fri, 20 Mar 2015 12:03:15 +0800
Message-ID: <CAN8ccib9=F2=SUgHmiXrf3aygX=-usoTPpYVV47+fY1kp+yjtQ@mail.gmail.com>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <s5h3851t6xx.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDA3F0@SHSMSX101.ccr.corp.intel.com>
 <s5hd2455a07.wl-tiwai@suse.de>
 <20150319144240.GV2869@sirena.org.uk>
 <s5hpp85rqg5.wl-tiwai@suse.de>
 <20150319151851.GW2869@sirena.org.uk>
 <s5hh9thnh07.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6966D2606B6
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 05:03:17 +0100 (CET)
Received: by oier21 with SMTP id r21so82235186oie.1
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 21:03:16 -0700 (PDT)
In-Reply-To: <s5hh9thnh07.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>, "Lu,
 Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

> >
> > > > The theory is that this is handled by the fact that the userspace
ABI
> > > > includes a reference to the struct device and therefore a chain
showing
> > > > where the thing is attached; anything registering two different
jacks
> > > > with the same name attached to the same device probably qualifies as
> > > > broken.
> >
> > > So this implicitly assumes the name uniqueness.  For HD-audio, this
> > > was a problem because we need to generate jack names dynamically; for
> > > example, there are laptops with two headphones, and we assigned
> > > indices in such a case.
> >
> > That's on the same card, though?
>
> Yeah, on the same laptop, even both on the front.  The designer must
> have smoked, or just looked for a partner sitting at next to listen to
> music together :)

http://en.community.dell.com/support-forums/laptop/f/3517/t/19440542

One of the headphone jack is actually headphone/SPDIF combo jack

and the two headphone jacks and mic jack can support surround 5.1
