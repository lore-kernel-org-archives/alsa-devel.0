From: Stephen Warren <swarren@nvidia.com>
Subject: Re: UCM representation questions
Date: Thu, 26 May 2011 10:13:21 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A486ED@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A47E52@HQMAIL01.nvidia.com>
	<4DD7E644.4010301@ti.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A485B6@HQMAIL01.nvidia.com>
	<4DDE3333.5010907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 59E0410381C
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 19:13:30 +0200 (CEST)
In-Reply-To: <4DDE3333.5010907@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote at Thursday, May 26, 2011 5:02 AM:
> On 25/05/11 23:38, Stephen Warren wrote:
> > Liam Girdwood wrote at Saturday, May 21, 2011 10:20 AM:
> >> On 20/05/11 22:48, Stephen Warren wrote:
> >>> I have a few more questions how to represent things in UCM.
> >>> ...
> >>> The WM8903 can capture from one or the other or AMIC/DMIC, but not both.
> >>> ...
> >>> How to indicate when certain devices can be used together, or are
> >>> mutually exclusive?
> >>
> >> Atm, I don't think we can do this with devices. We can do it with
> >> modifiers though (i.e. a modifier can list it's supported devices). It
> >> does sound like a useful feature and probably could be based on the
> >> modifier supported device code.
> >
> > OK, it looks pretty easy to modify the code to parse and implement
> > something like:
> >
> > SectionDevice."AMIC".0 {
> >     Comment "Analog Microphone Jack"
> >
> >     ConflictingDevice [
> >         "DMIC",
> >         "foo"
> >     ]
> > ...
> > }
> >
> > SectionDevice."DMIC".0 {
> >     Comment "Internal Digital Microphone"
> >
> >     ConflictingDevice [
> >         "AMIC"
> >     ]
> > ...
> > }
> >
> > Does that look reasonable?
> 
> Yes, although does it make more sense using "SupportedDevice" instead ?

I assume a SupportedDevice list would be all devices in the current
verb that are compatible with the SectionDevice being defined, i.e.
you're talking about different semantics, rather than just a different
textual name for the section.

My thought process here was that conflicting devices are probably less
common than non-conflicting devices. At least, it seems like that'd be
the default assumption of someone writing a UCM file. So, if we list
ConflictingDevice(s), then that would often map to an empty list, and
you could eliminate the section. If we had to list all compatible
devices, by default you'd have to list every device in the UCM verb in
almost all cases. That seems like more work.

Plus, adding an optional ConflictingDevice list maintains backwards
Compatibility with any existing UCM files, whereas adding a mandatory
SupportedDevice list doesn't.

Still, explicitly listing SupportedDevice(s) might be safer?

I wonder if allowing all lists of devices to be either inclusive
SupportedDevice or exclusive ConflictingDevice makes sense, with the
default being ConflictingDevice being empty, and SupportedDevice being
the entire set of devices? Seems more complex, but probably still
workable.

I'll go with whatever call you want to make.

-- 
nvpublic
