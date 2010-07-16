From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Which project to choose?
Date: Fri, 16 Jul 2010 08:39:29 +0800
Message-ID: <AANLkTik16UoQM2zZMgs3An1dv8-i0gWpiTEg3qOLqFTC@mail.gmail.com>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTildhplqQxzk7mBMc5IW_3bwAVDDrRe5UDpJXIS6@mail.gmail.com>
	<4C3DD271.6040003@epost.diwic.se>
	<alpine.LNX.2.00.1007141723070.16744@eeebox2.perex-int.cz>
	<4C3E13D1.1070908@epost.diwic.se>
	<alpine.LNX.2.00.1007150007340.16744@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 773A2243AC
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 02:39:31 +0200 (CEST)
Received: by vws9 with SMTP id 9so1879676vws.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2010 17:39:29 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1007150007340.16744@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/15 Jaroslav Kysela <perex@perex.cz>

> On Wed, 14 Jul 2010, David Henningsson wrote:
>
> > 2010-07-14 17:25, Jaroslav Kysela skrev:
> >> On Wed, 14 Jul 2010, David Henningsson wrote:
> >>
> >>> 2010-07-14 13:13, Raymond Yau skrev:
> >>>
> >>>> localhost pulseaudio[24553]: alsa-util.c:   appl_ptr     : 735801008
> >>>> localhost pulseaudio[24553]: alsa-util.c:   hw_ptr       : 735846184
> >>>>
> >>>> This is underrun as you can see appl_ptr is behing hw_ptr
> >>>
> >>> Ehm, isn't that a ring buffer? I e, there is nothing wrong with
> appl_ptr
> >>> being less than hw_ptr.
> >>
> >> For playback, if appl_ptr is less than hw_ptr, it's underrun situation
> >> (application didn't feed samples in time to the driver's ring buffer).
> >>
> >> Note that pointers in ALSA are in range 0..boundary not
> >> 0..ring_buffer_size (boundary is near LONG_MAX value) - it's design to
> >> detect such situations (underrun, overrun).
> >
> > Okay, thanks for the clarification. But LONG_MAX (as in 2^31) would
> > still wrap around every thirteen hours (at 44100 Hz), so are we having
> > bugs, such as e g failure to detect underruns, at those occasions?
>
> >From values above, it looks like a standard underrun (samples didn't
> arrive in time to the ring buffer). Just check the real system time
> between I/O operations and you'll see if it's issue in the ALSA driver or
> a task scheduling problem.
>
>                                        Jaroslav
>

Looking  at the ens1371 specification , it seem to me that alsa-lib cannot
perform rewind too
I guess those 44101 rate is not really the best supported rate


4.2 Bus Master Cache Control (CCB)
This block control the transfer of data between the PCI memory and the
internal memory.
The Serial block signal when a cache fill/transfer is required in three
memory buffers

5.5 PCI Data transfer

Only brust read/write transfers are allowed. All data transfer are 8 Long
Word brust transfers
