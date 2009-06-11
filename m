From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: Re: problems with fedora 11 and pulseaudio and svn
	x-fi driver
Date: Thu, 11 Jun 2009 09:48:03 -0500
Message-ID: <1244731683.24526.0.camel@localhost.localdomain>
References: <s5hy70xsl46.wl%tiwai@suse.de> <1223583478.5018.0.camel@home>
	<s5hbpxt7zui.wl%tiwai@suse.de> <1223619975.4700.2.camel@home>
	<1244623151.4093.3.camel@localhost.localdomain>
	<1244623955.6367.0.camel@localhost.localdomain>
	<s5hljo0mo7i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FC5410386F
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 16:48:07 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so754442ywq.2
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2009 07:48:06 -0700 (PDT)
In-Reply-To: <s5hljo0mo7i.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here's the output during some skipping.  It happens with or without
pulse if I have any application playing sound to my xfi.  Do not have
the same problem if output goes to integrated intel:


cat /proc/asound/card0/pcm0p/sub0/* 
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 1
rate: 44100 (44100/1)
period_size: 32768
buffer_size: 65536
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ctxfi
name: Front/WaveIn
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 8
subdevices_avail: 7
128
128
state: RUNNING
trigger_time: 74684.238387841
tstamp : 74702.900700135
delay : 2664
avail : 62872
avail_max : 62872
-----
hw_ptr : 822976
appl_ptr : 825640
tstamp_mode: ENABLE
period_step: 1
avail_min: 63069
start_threshold: 4294967295
stop_threshold: 1073741824
silence_threshold: 0
silence_size: 0
boundary: 1073741824

On Wed, 2009-06-10 at 11:29 +0200, Takashi Iwai wrote:

> At Wed, 10 Jun 2009 03:52:35 -0500,
> Ted T. Logan wrote:
> > 
> > I killed pulseaudio and the problem is the same as far as every few seconds,
> > just a different sound.  it seems to be the xfi driver.
> 
> Please be more specific, what apps did you test and how, and on which
> hardware, with which alsa-driver.  There is no svn alsa-driver at
> all, at least, as I know of.
> 
> If it's emu20k1 chip (not emu20k2), try use_system_timer=1 module
> option snd-ctxfi driver.  This will take the timer management back to
> the old one using the system timer.
> 
> 
> thanks,
> 
> Takashi
> 
> > I did not have this problem with XFiDrv_Linux_Public_US_1.00.tar.gz
> > however, I am trying to get away from that driver because of other issues.
> > 
> > Thanks!
> > 
> > On Wed, 2009-06-10 at 03:39 -0500, Ted T. Logan wrote:
> > 
> >     Hello,
> >    
> >     I upgraded to fedora 11 with PA 9.15 and got the svn alsa-driver and
> >     installed it for the x-fi driver.
> >    
> >     The problem is, with pulseaudio, i get a pop every few seconds
> >     like, every 3 seconds, "pop" and it does it over and over and over
> >    
> >     I seem to get no sound at all with the card if I bypass pulse
> >    
> >     What can I do?
> > 
> > 
