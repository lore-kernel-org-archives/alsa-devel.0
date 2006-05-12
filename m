From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Re: aplay and arecord can't set sw params
Date: Fri, 12 May 2006 13:15:50 +0200
Message-ID: <44646E66.6060704@atmel.com>
References: <4461F630.2060707@atmel.com> <s5hac9p9a32.wl%tiwai@suse.de> <4462DBE7.7010900@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4462DBE7.7010900@atmel.com>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hans-Christian Egtvedt wrote:
> Takashi Iwai wrote:
>> At Wed, 10 May 2006 16:18:24 +0200,
>> Hans-Christian Egtvedt wrote:
>>> Does this output give any signs of where the error is?
>>>
>>> ~ # aplay /stk1000/gorillaz.wav
>>> Playing WAVE '/stk1000/gorillaz.wav' : Signed 16 bit Little Endian, Rate
>>> 48000 Hz, Stereo
>>> aplay: set_params:1012: unable to install sw params:
>>> start_mode: DATA
>>> xrun_mode: STOP
>>> tstamp_mode: NONE
>>> period_step: 1
>>> sleep_min: 0
>>> avail_min: 0
>>> xfer_align: 0
>> avail_min and xfer_align should be the period size.  So, something
>> wrong in alsa-lib or in aplay code.
> 
> Keep in mind my recent fix for the enum vs. int problem. I'm still
> working on the AVR32 plattform. The soundcard is the embedded AC97
> controller inside the device (AP7000) and the external codec is a
> National Semiconductor LM4549A.
> 
> I'll try digging into the code (aplay/alsalib) and see why the
> xfer_align and avail_min is not set.

I have found a workaround for the issue by compiling alsa-lib static. It
seems like the references to the variables are not set when aplay is
dynamicly linked with alsa-lib.

Actually not sure if it's either the GCC compiler which does something
wrong, a bad parameter while configuring or something in the code that
causes this.

<snip>

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
