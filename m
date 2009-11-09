From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: Capture not working in MMAP mode with '-v'
Date: Mon, 09 Nov 2009 10:12:31 +0200
Message-ID: <1257754351.30157.464.camel@eenurkka-desktop>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A705212@dbde02.ent.ti.com>
	<1257753496.30157.455.camel@eenurkka-desktop>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A705220@dbde02.ent.ti.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FCC4103830
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 09:14:32 +0100 (CET)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A705220@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-11-09 at 09:05 +0100, ext Aggarwal, Anuj wrote:
> > -----Original Message-----
> > From: Eero Nurkkala [mailto:ext-eero.nurkkala@nokia.com]
> > Sent: Monday, November 09, 2009 1:28 PM
> > To: Aggarwal, Anuj
> > Cc: alsa-devel@alsa-project.org
> > Subject: Re: [alsa-devel] Capture not working in MMAP mode with '-v'
> > 
> > On Mon, 2009-11-09 at 08:56 +0100, ext Aggarwal, Anuj wrote:
> > > > -----Original Message-----
> > > > From: Aggarwal, Anuj
> > > > Sent: Thursday, September 24, 2009 2:28 PM
> > > > To: alsa-devel@alsa-project.org
> > > > Subject: Capture not working in MMAP mode with '-v'
> > > >
> > > > Hi,
> > > >
> > > > When I try to capture audio in MMAP mode using the following
> > > > command, it works properly:
> > > >
> > > > arecord -f cd -d 10 -M rec01.wav
> > > >
> > > > However, if I specify '-v' along with the above command, it fails to
> > > > capture anything and prints log and returns immediately:
> > > >
> > > > Recording WAVE 'rec03.wav' : Signed 16 bit Little Endian,
> > > > Rate 44100 Hz, Stereo
> > > > Plug PCM: Hardware PCM card 0 'omap3evm' device 0 subdevice 0
> > > > Its setup is:
> > > >   stream       : CAPTURE
> > > >   access       : MMAP_INTERLEAVED
> > > >   format       : S16_LE
> > > >   subformat    : STD
> > > >   channels     : 2
> > > >   rate         : 44100
> > > >   exact rate   : 44100 (44100/1)
> > > >   msbits       : 16
> > > >   buffer_size  : 22052
> > > >   period_size  : 5513
> > > >   period_time  : 125011
> > > >   tstamp_mode  : NONE
> > > >   period_step  : 1
> > > >   avail_min    : 5513
> > > >   period_event : 0
> > > >   start_threshold  : 1
> > > >   stop_threshold   : 22052
> > > >   silence_threshold: 0
> > > >   silence_size : 0
> > > >   boundary     : 1445199872
> > > >   appl_ptr     : 0
> > > >   hw_ptr       : 0
> > > > mmap_area[0] = 0x4030e000,0,32 (16)
> > > > mmap_area[1] = 0x4030e000,16,32 (16)
> > > >
> > > > I have not observed this problem while playing audio, only
> > > > while capture this issue crops up.
> > > >
> > > > Any pointers?
> > > Any updates on this? We have observed similar problem on other
> > > platforms as well.
> > 
> > Yeah, it's an aplay bug, I've seen it & tracked down to aplay. It
> > actually makes the recording file very huge instantly on some systems.
> > Patch out the aplay when -M and -v are used =)
> Is there a new version of alsa-utils available which fixes this
> problem? Also, I have seen this problem only while using arecord,
> not aplay, though they both point to the same source file? Whats
> the reason for this?

As far as I know, nobody fixed it. Yeah, aplay = arecord, and it occurs
only with arecord to be more specific, and is present on all platforms
out there:

My workaround:

"
arecord is only buggy, if -M and -v flags are used, and
chunk_size goes to zero (which is perfectly OK).


This is the functional version of aplay:

<----------------------------->
        /* show mmap buffer arragment */
        if (mmap_flag && verbose) {

                const snd_pcm_channel_area_t *areas;
                snd_pcm_uframes_t offset;
                int i, chunk_prev = chunk_size;

                snd_pcm_avail_update(handle);
                err = snd_pcm_mmap_begin(handle, &areas, &offset, &chunk_size);
                if (err < 0) {
                        error("snd_pcm_mmap_begin problem: %s",
snd_strerror(err));
                        exit(EXIT_FAILURE);
                }
                for (i = 0; i < hwparams.channels; i++)
                        fprintf(stderr, "mmap_area[%i] = %p,%u,%u (%u)\n", i,
areas[i].addr, areas[i].first, areas[i].step,
snd_pcm_format_physical_width(hwparams.format));
                if (!chunk_size)
                        chunk_size = chunk_prev;
                /* not required, but for sure */
                snd_pcm_mmap_commit(handle, offset, 0);
        }
<----------------------------------_>
"

> > 
> > > >
> > > > Thanks & Regards,
> > > > Anuj Aggarwal
> > > >
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
> 
