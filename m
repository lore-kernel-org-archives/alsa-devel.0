From: peloy@chapus.net (Eloy A. Paris)
Subject: Re: CS46xx oddness
Date: Wed, 24 Dec 2003 10:38:38 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87ekuutedd.fsf@canaima.chapus.net>
References: <20031224094213.GE25270@zewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031224094213.GE25270@zewt.org> (Glenn Maynard's message of
 "Wed, 24 Dec 2003 04:42:13 -0500")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Is this card being actively maintained? I've seen several reports of
problems with this card (occasional metallic sound when recording,
SPDIF passthrough not working on some receivers, etc.) but haven't seen
any responses about possible solutions.

I wish I could volunteer to improve the driver for this card, but I
think my technical skills to be able to do so are lacking :(

I personally replaced my cs46xx-based card with a SoundBlaster Live! 5.1
because of the problems with the cs46xx driver.

Cheers,

Eloy.-

Glenn Maynard <g_sf@zewt.org> writes:

> (2.6.0 test11)
>
> I'm seeing something odd with a CS46xx chip: if I don't set a buffer
> size, or if I set it to 4k or 8k, then sound isn't played.  The buffer
> fills up, and the device stays in SND_PCM_STATE_RUNNING.  If I set it
> to 16k or 32k, it works.
>
> I'm testing remotely on a user's machine, so I can't do much to
> troubleshoot this (I'm not going to mess with his kernel).  In case
> anyone's feeling brave, the relevant code is at
>
>    http://cvs.sf.net/viewcvs.py/*checkout*/stepmania/stepmania/src/arch/Sound/ALSA9Helpers.cpp?rev=1.12
>
> For reference, samplerate is 44100, channels is 2, and all dsnd* are
> just pointers to snd*.  Sorry for not making a test case; it's 4am, so
> I can't do it tonight, and this is a drop-in on IRC so I may not get
> access to this machine again.  If nobody feels like looking at that
> at all, I'll understand. :)
>
> If it helps, here's /proc/asound/card0/pcm0p/sub0/* with an 8k, full buffer:
>
> access: MMAP_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 44100 (44100/1)
> period_size: 8
> buffer_size: 8192
> tick_time: 1000
> card: 0
> device: 0
> subdevice: 0
> stream: PLAYBACK
> id: CS46xx
> name: CS46xx
> subname: subdevice #0
> class: 0
> subclass: 0
> subdevices_count: 31
> subdevices_avail: 30
> 64
> state: RUNNING
> trigger_time: 1072258017.688694000
> tstamp      : 1072258028.517208000
> delay       : 512
> avail       : 7680
> avail_max   : 7680
> -----
> hw_ptr      : 0
> appl_ptr    : 512
> tstamp_mode: NONE
> period_step: 1
> sleep_min: 0
> avail_min: 8
> xfer_align: 8
> start_threshold: 0
> stop_threshold: 1073741824
> silence_threshold: 0
> silence_size: 0
> boundary: 1073741824
>
>
> -- 
> Glenn Maynard
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
