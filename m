From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Capture not working in MMAP mode with '-v'
Date: Mon, 9 Nov 2009 13:35:16 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A705220@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A705212@dbde02.ent.ti.com>
	<1257753496.30157.455.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C8A910383F
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 09:05:24 +0100 (CET)
In-Reply-To: <1257753496.30157.455.camel@eenurkka-desktop>
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
To: "ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Eero Nurkkala [mailto:ext-eero.nurkkala@nokia.com]
> Sent: Monday, November 09, 2009 1:28 PM
> To: Aggarwal, Anuj
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Capture not working in MMAP mode with '-v'
> 
> On Mon, 2009-11-09 at 08:56 +0100, ext Aggarwal, Anuj wrote:
> > > -----Original Message-----
> > > From: Aggarwal, Anuj
> > > Sent: Thursday, September 24, 2009 2:28 PM
> > > To: alsa-devel@alsa-project.org
> > > Subject: Capture not working in MMAP mode with '-v'
> > >
> > > Hi,
> > >
> > > When I try to capture audio in MMAP mode using the following
> > > command, it works properly:
> > >
> > > arecord -f cd -d 10 -M rec01.wav
> > >
> > > However, if I specify '-v' along with the above command, it fails to
> > > capture anything and prints log and returns immediately:
> > >
> > > Recording WAVE 'rec03.wav' : Signed 16 bit Little Endian,
> > > Rate 44100 Hz, Stereo
> > > Plug PCM: Hardware PCM card 0 'omap3evm' device 0 subdevice 0
> > > Its setup is:
> > >   stream       : CAPTURE
> > >   access       : MMAP_INTERLEAVED
> > >   format       : S16_LE
> > >   subformat    : STD
> > >   channels     : 2
> > >   rate         : 44100
> > >   exact rate   : 44100 (44100/1)
> > >   msbits       : 16
> > >   buffer_size  : 22052
> > >   period_size  : 5513
> > >   period_time  : 125011
> > >   tstamp_mode  : NONE
> > >   period_step  : 1
> > >   avail_min    : 5513
> > >   period_event : 0
> > >   start_threshold  : 1
> > >   stop_threshold   : 22052
> > >   silence_threshold: 0
> > >   silence_size : 0
> > >   boundary     : 1445199872
> > >   appl_ptr     : 0
> > >   hw_ptr       : 0
> > > mmap_area[0] = 0x4030e000,0,32 (16)
> > > mmap_area[1] = 0x4030e000,16,32 (16)
> > >
> > > I have not observed this problem while playing audio, only
> > > while capture this issue crops up.
> > >
> > > Any pointers?
> > Any updates on this? We have observed similar problem on other
> > platforms as well.
> 
> Yeah, it's an aplay bug, I've seen it & tracked down to aplay. It
> actually makes the recording file very huge instantly on some systems.
> Patch out the aplay when -M and -v are used =)
Is there a new version of alsa-utils available which fixes this
problem? Also, I have seen this problem only while using arecord,
not aplay, though they both point to the same source file? Whats
the reason for this?
> 
> > >
> > > Thanks & Regards,
> > > Anuj Aggarwal
> > >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
