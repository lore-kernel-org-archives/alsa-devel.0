From: "Nikhil Rao" <nikhil_p_rao@hotmail.com>
Subject: Re: Fw: Bug with PCM plug layer with mmap
	emulation=true ?
Date: Thu, 12 Oct 2006 17:52:50 -0700
Message-ID: <BAY111-DAV13C763DF9EC055C8B74DAFC20A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Another question:

If the driver is being used in MMAP mode - is the ack callback invoked when 
the appl_ptr is updated ?
I dont see it happening in my driver.

Thanks,
Nikhil
----- Original Message ----- 
From: "Nikhil Rao" <nikhil_p_rao@hotmail.com>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Wednesday, October 11, 2006 10:09 AM
Subject: Re: Fw: Bug with PCM plug layer with mmap emulation=true ?


> Hi,
>
> I am running into a bug with mmap_emulation=true and the plug layer, I had
> also run into the bug with 1.0.9b.
>
> The symptom of the bug is that the first period (first 2 ?) get repeated 
> on
> playback.
>
> To reproduce the bug -
>
> Modify the  the intel-snd8x0 driver so that MMAP is disabled and only the
> 48Khz sample rate is supported in hardware.
> Compile the driver and install it.
>
> The changes are attached with this email and reproduced below.
>
> 1097c1097
> <  .info =   ( SNDRV_PCM_INFO_INTERLEAVED |
> ---
>>  .info =   (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
> 1099c1099,1100
> <            SNDRV_PCM_INFO_PAUSE |
> ---
>>      SNDRV_PCM_INFO_MMAP_VALID |
>>      SNDRV_PCM_INFO_PAUSE |
>
> 1143,1144c1144
> <  //runtime->hw.rates = ichdev->pcm->rates;
> <  runtime->hw.rates = SNDRV_PCM_RATE_48000;
> ---
>>  runtime->hw.rates = ichdev->pcm->rates;
>
> Since MMAP is now disabled enable mmap_emulation=true in
> /usr/share/alsa/alsa.conf, below is the modification
>
> pcm.plughw {
>
> <SNIPPED>
>
> type plug
> slave.pcm {
>  type hw
>  card $CARD
>  device $DEV
>  subdevice $SUBDEV
>  mmap_emulation true #modification to get plughw to work if MMAP is not
> supported.
> }
> }
>
> Now play any non-48Khz  wav file and you will hear the first fragment
> repeating.
>
> aplay -D plughw:0,0 <wav file name>
>
> If anyone knows of a workaround or if you need any more info please let me
> know.
>
> Thanks,
> Nikhil
> ----- Original Message ----- 
> From: "Takashi Iwai" <tiwai@suse.de>
> To: "Nikhil Rao" <nikhil_p_rao@hotmail.com>
> Cc: <alsa-devel@lists.sourceforge.net>
> Sent: Wednesday, April 12, 2006 4:10 AM
> Subject: Re: Fw: Bug with PCM plug layer with mmap emulation=true ?
>
>
>> At Mon, 10 Apr 2006 15:51:14 -0700,
>> Nikhil Rao wrote:
>>>
>>> Hi Takashi,
>>>
>>> I havent received any response to the query below, let me know if I need
>>> to
>>> add more information.
>>
>> Sorry I seem to have missed that post.
>>
>>>
>>> thanks,
>>> Nikhil
>>> ----- Original Message ----- 
>>> From: "Nikhil Rao" <nikhil_p_rao@hotmail.com>
>>> To: <alsa-devel@lists.sourceforge.net>
>>> Sent: Monday, April 03, 2006 4:26 PM
>>> Subject: Bug with PCM plug layer with mmap emulation=true ?
>>>
>>>
>>> > Hello,
>>> >
>>> > I have observed that the using pcm plug layer with mmap emulation=true
>>> > in
>>> > alsa.conf, causes the first period of data to be sent twice to the
>>> > driver.
>>> > I also verified this by dumping the PCM data to a file (using the copy
>>> > callback)
>>
>> This could be a bug.  The mmap_emulation mode wasn't debugged for long
>> time.
>>
>>> > I have tried experiments using the ALSA driver (ver 1.0.10) written by
>>> > me
>>> > for  my development system (an SoC)
>>> > and also the intelx80 driver on a Suse 10.0 system (ALSA ver 1.0.9b). 
>>> > I
>>> > modified the intelx80 driver so that it only supports 48Khz and then
>>> > used
>>> > the plughw device to playout a 44Khz sample. There is a distinct
>>> > stutter
>>> > audible at the beginning of the clip caused by the first period being
>>> > presented twice to the hardware.
>>> >
>>> > Is this a known problem ? if so, is a workaround available (my
>>> > development
>>> > platform does not support mmap currently).
>>
>> Well, another question is whether really mmap is necessary for your
>> device.  Any particular applications require the mmap access
>> exclusively?
>>
>> Anyway, the bug should be fixed.  First, could you try the latest ALSA
>> (1.0.11rc5 was released yesterday)?  Debugging old codes is a waste of
>> time.
>>
>> The symptom sounds like a problem with rate plugin.  The rate plugin
>> defers the transfer until a whole period size is filled.
>> So, if the problem still exists, please describe the method you
>> checked this behavior in details, too.
>>
>>
>> Takashi
>>
> 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
