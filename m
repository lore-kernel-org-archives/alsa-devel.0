From: Ben Saylor <bensaylor@fastmail.fm>
Subject: Re: Audiophile USB samplerate workaround
Date: Wed, 23 Jul 2003 01:02:19 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307230102.19627.bensaylor@fastmail.fm>
References: <200307222259.25527.bensaylor@fastmail.fm> <s5hr84hfxxn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr84hfxxn.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 23 July 2003 12:29 am, you wrote:
> At Tue, 22 Jul 2003 22:59:25 -0800,
>
> Ben Saylor wrote:
> > I did some investigation to find out why the sample rate can't be
> > set to anything but 48khz (or rather, remains 48khz even if it is
> > set to something else) on the Audiophile.
>
> does format descriptor contain other sample rates?

In parse_audio_format_rates(), nr_rates is always 0 (continuous).  
/proc/asound/card0/stream{0,1} reflect the same.  Most of the altsets 
are 8000-48000 continuous.  I hope that's a meaningful answer. :)

> > In init_usb_sample_rate(),
> > 	if (fmt->attributes & EP_CS_ATTR_SAMPLE_RATE)
> > is never true, so the sample rate is not set.  If I just make it
> > if(1) the sample rate is settable.  Is this a hardware bug or
> > something else?
>
> then the format descriptor might be bogus.
>
>
> Takashi



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
