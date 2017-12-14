From: Jens Verwiebe <info@jensverwiebe.de>
Subject: Re: Line6 Helix - usb compliant but not working
 correct - followup
Date: Thu, 14 Dec 2017 20:00:06 +0100
Message-ID: <b708b74c-b220-7644-7e04-8da7abe548fe@jensverwiebe.de>
References: <4d9d4dd7-1b49-574c-ac0b-62fd0e40ba82@jensverwiebe.de>
 <17555436-4918-0b12-48a6-44c84cc009d2@codethink.co.uk>
 <8faa629e-b9e0-5124-b9c1-4c5d9678351d@jensverwiebe.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------8551D59847B94CD96A0BF606"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 75AAF266E30
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 20:00:08 +0100 (CET)
Received: from [192.168.178.21] ([77.186.59.186]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0Lucpk-1f7Nwt2e5Q-00zqLt for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017
 20:00:07 +0100
In-Reply-To: <8faa629e-b9e0-5124-b9c1-4c5d9678351d@jensverwiebe.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------8551D59847B94CD96A0BF606
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, me again

In between i got the line6 helix working fine with a hack, which is to 
set an arbitray rate i have readout from another interface on the same 
bus. This works reliable so far, no more clicks, no xruns over several 
hours. There must be som magic to get the true usbrate from this device, 
but i did no fond a way yet, so my hack is more something unique for my 
working situation.

I also tried to get the implicite feeback from the capture interface to 
the pb interface to get a proper sync_ep, but still the rate is plain stiff.

Another problem is the mixer, which should be a plain passthrough. Cause 
ctrl interface is somewhat broken pure alsa does not work, but jack can 
create the device just fine.

I attach below the lsusb dump from the helix + my hack and the resulting 
working proc for further investigation.

Any ideas and voodoo is welcome.

Cheers ... Jens



Am 29.11.2017 um 16:24 schrieb Jens Verwiebe:
> Hi,, yeah thx for looking into it.
>
> TBH i tried all kinda stuff already and also am able to compare all 
> logs with a Focusrite Scarlett 6i6, which shows
>
> almost exactly same outputs but works just fine. This makes me clueless.
>
> I also investigated if this could be a firmware bug, but then it would 
> not work on osx either, no ?
>
> Something new i found: if i capture from helix and play this file with 
> scarlett all is fine. So it seems to be something
> with out-of-sync playback only.
>
>
> Am 29.11.2017 um 15:51 schrieb Jorge:
>>
>>
>> On 29/11/17 13:26, Jens Verwiebe wrote:
>>> Hi folks
>>>
>>> I recently got a Line6 Helix LT which can work usb compliant for 
>>> example on
>>
>> Interesting. I would like to try the Helix in Linux too. I have seen 
>> similar issues when fiddling with
>> set_sample_rate. Some comments/ideas below.
>>
>>>
>>> OSX or IOS. No driver is needed but the samplerate is fixed to 48000 
>>> ( which is okay for the first ).
>>>
>>> Now i expected this device to work ootb in alsa, which turned out to 
>>> be half the truth.
>>>
>>> Connecting the device threw " usb 7-2: 
>>> parse_audio_format_rates_v2(): unable to retrieve number of sample 
>>> rates (clock 16)"
>>>
>>> so i investigated a bit and found this workaround:
>>>
>>> --- 
>>> "/media/Workdata3/Development/kernel_lowlat_4.4-97/linux-4.4.97/sound/usb/clock 
>>> (Kopie).c"    2017-11-08 10:06:31.000000000 +0100
>>> +++ 
>>> /media/Workdata3/Development/kernel_lowlat_4.4-97/linux-4.4.97/sound/usb/clock.c 
>>> 2017-11-14 23:06:51.750924051 +0100
>>> @@ -361,6 +361,13 @@ static int set_sample_rate_v2(struct snd
>>>      struct uac_clock_source_descriptor *cs_desc;
>>>
>>>      clock = snd_usb_clock_find_source(chip, fmt->clock, true);
>>> +        /*
>>> +         * Line6 HELIX does not respond to sample rate
>>> +         * set requests. The only valid rate is 48000.
>>> +         */
>>> +        if (chip->usb_id == USB_ID(0x0e41, 0x4244) && rate == 48000)
>>> +            return 0;
>>> +
>>>      if (clock < 0)
>>>          return clock;
>>>
>>> --- 
>>> "/media/Workdata3/Development/kernel_lowlat_4.4-97/linux-4.4.97/sound/usb/format 
>>> (Kopie).c"    2017-11-08 10:06:31.000000000 +0100
>>> +++ 
>>> /media/Workdata3/Development/kernel_lowlat_4.4-97/linux-4.4.97/sound/usb/format.c 
>>> 2017-11-14 23:12:24.329766243 +0100
>>> @@ -293,6 +293,20 @@ static int parse_audio_format_rates_v2(s
>>>      int nr_triplets, data_size, ret = 0;
>>>      int clock = snd_usb_clock_find_source(chip, fp->clock, false);
>>>
>>> +    /*
>>> +    * Line6 HELIX does not respond to sample rate
>>> +    * query requests. The only valid rate is 48000.
>>> +    */
>>> +    if (chip->usb_id == USB_ID(0x0e41, 0x4244)) {
>>> +        fp->nr_rates = 1;
>>> +            fp->rate_min = 48000;
>>> +            fp->rate_max = 48000;
>>> +            fp->rates = SNDRV_PCM_RATE_48000;
>>> +            fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
>>> +            fp->rate_table[0] = 48000;
>>> +            return 0;
>>> +        }
>>> +
>>>      if (clock < 0) {
>>>          dev_err(&dev->dev,
>>>              "%s(): unable to find clock source (clock %d)\n",
>>>
>>>
>>> This trick made the device appear in aplay -l and /proc/asound just 
>>> as expected.
>>>
>>> [ 7988.495085] usb 7-2: new high-speed USB device number 4 using 
>>> xhci_hcd
>>> [ 7988.663622] usb 7-2: New USB device found, idVendor=0e41, 
>>> idProduct=4244
>>> [ 7988.663625] usb 7-2: New USB device strings: Mfr=1, Product=2, 
>>> SerialNumber=3
>>> [ 7988.663627] usb 7-2: Product: HELIX
>>> [ 7988.663629] usb 7-2: Manufacturer: LINE 6
>>> [ 7988.663630] usb 7-2: SerialNumber:    2744535
>>>
>>> But i ended up with sometimes occuring soft clicks in playback which 
>>> imply i have timing problems.
>>>
>>> Another symptom is aplay does not output any sound while not 
>>> throwing any error while in jack i can create the driver just fine.
>>
>> Have you tried debugging the pointer position with that device? Do 
>> you get sensible buffer sizes
>> with `-v` in aplay for 48KHz, 24 bits, etc?
> I get just this but silence ( while plughhw:1,0 == scarlett looks same 
> and plays sound ):
>
> aplay -D plughw:6,0 -vv test.wav
> Wiedergabe: WAVE 'test.wav' : Signed 16 bit Little Endian, Rate: 44100 
> Hz, stereo
> Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
> Converter: libspeex (builtin)
> Protocol version: 10002
> Its setup is:
>   stream       : PLAYBACK
>   access       : RW_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 44100
>   exact rate   : 44100 (44100/1)
>   msbits       : 16
>   buffer_size  : 22050
>   period_size  : 5512
>   period_time  : 125000
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 5512
>   period_event : 0
>   start_threshold  : 22050
>   stop_threshold   : 22050
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 6206523236469964800
> Slave: Route conversion PCM (sformat=S32_LE)
>   Transformation table:
>     0 <- 0
>     1 <- 1
>     2 <- none
>     3 <- none
>     4 <- none
>     5 <- none
>     6 <- none
>     7 <- none
> Its setup is:
>   stream       : PLAYBACK
>   access       : MMAP_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 16
>   buffer_size  : 24001
>   period_size  : 6000
>   period_time  : 125000
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 6000
>   period_event : 0
>   start_threshold  : 24000
>   stop_threshold   : 24001
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 6755680916032454656
> Slave: Hardware PCM card 6 'HELIX' device 0 subdevice 0
> Its setup is:
>   stream       : PLAYBACK
>   access       : MMAP_INTERLEAVED
>   format       : S32_LE
>   subformat    : STD
>   channels     : 8
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 32
>   buffer_size  : 24001
>   period_size  : 6000
>   period_time  : 125000
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 6000
>   period_event : 0
>   start_threshold  : 24000
>   stop_threshold   : 24001
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 6755680916032454656
>   appl_ptr     : 0
>   hw_ptr       : 0
>
>
>>
>> I once ended up with really small buffers when I changed the usb 
>> audioformats for a fixed rate device
>> so there was not sound whatsoever even though all the devices were 
>> present. I am not sure whether
>> fp->rates should get SNDRV_PCM_RATE_CONTINUOUS either way and then 
>> min/max = 48KHz delimiting it.
>
> Tried this already, makes no difference.
>>
>> Jorge.
>>
>>>
>>> I would apreciate any hint what i could try out here.
>>>
>>>
>>> Greetings from Hamburg ... Jens
>>>
>>
>>
>
> My wisdom is at the end here ... Jens ;-)
>

-- 

Jens Verwiebe
Allerskehre 44 - 22309 Hamburg

Tel.: +49 40 68 78 50
mobile: +49 172 400 49 07
mailto: info@jensverwiebe.de
web: http://www.jensverwiebe.de


--------------8551D59847B94CD96A0BF606
Content-Type: text/plain; charset=UTF-8;
 name="line6_helix_lt_dump.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="line6_helix_lt_dump.txt"

QnVzIDAwNyBEZXZpY2UgMDAzOiBJRCAwZTQxOjQyNDQgTGluZTYsIEluYy4gCkRldmljZSBE
ZXNjcmlwdG9yOgogIGJMZW5ndGggICAgICAgICAgICAgICAgMTgKICBiRGVzY3JpcHRvclR5
cGUgICAgICAgICAxCiAgYmNkVVNCICAgICAgICAgICAgICAgMi4wMAogIGJEZXZpY2VDbGFz
cyAgICAgICAgICAyMzkgTWlzY2VsbGFuZW91cyBEZXZpY2UKICBiRGV2aWNlU3ViQ2xhc3Mg
ICAgICAgICAyID8KICBiRGV2aWNlUHJvdG9jb2wgICAgICAgICAxIEludGVyZmFjZSBBc3Nv
Y2lhdGlvbgogIGJNYXhQYWNrZXRTaXplMCAgICAgICAgNjQKICBpZFZlbmRvciAgICAgICAg
ICAgMHgwZTQxIExpbmU2LCBJbmMuCiAgaWRQcm9kdWN0ICAgICAgICAgIDB4NDI0NCAKICBi
Y2REZXZpY2UgICAgICAgICAgICAyLjAwCiAgaU1hbnVmYWN0dXJlciAgICAgICAgICAgMSBM
SU5FIDYKICBpUHJvZHVjdCAgICAgICAgICAgICAgICAyIEhFTElYICAgCiAgaVNlcmlhbCAg
ICAgICAgICAgICAgICAgMyAgICAyNzQ0NTM1CiAgYk51bUNvbmZpZ3VyYXRpb25zICAgICAg
MQogIENvbmZpZ3VyYXRpb24gRGVzY3JpcHRvcjoKICAgIGJMZW5ndGggICAgICAgICAgICAg
ICAgIDkKICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDIKICAgIHdUb3RhbExlbmd0aCAg
ICAgICAgICAyNzUKICAgIGJOdW1JbnRlcmZhY2VzICAgICAgICAgIDUKICAgIGJDb25maWd1
cmF0aW9uVmFsdWUgICAgIDEKICAgIGlDb25maWd1cmF0aW9uICAgICAgICAgIDAgCiAgICBi
bUF0dHJpYnV0ZXMgICAgICAgICAweGMwCiAgICAgIFNlbGYgUG93ZXJlZAogICAgTWF4UG93
ZXIgICAgICAgICAgICAgIDEwMG1BCiAgICBJbnRlcmZhY2UgQXNzb2NpYXRpb246CiAgICAg
IGJMZW5ndGggICAgICAgICAgICAgICAgIDgKICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAg
ICAxMQogICAgICBiRmlyc3RJbnRlcmZhY2UgICAgICAgICAxCiAgICAgIGJJbnRlcmZhY2VD
b3VudCAgICAgICAgIDMKICAgICAgYkZ1bmN0aW9uQ2xhc3MgICAgICAgICAgMSBBdWRpbwog
ICAgICBiRnVuY3Rpb25TdWJDbGFzcyAgICAgICAwIAogICAgICBiRnVuY3Rpb25Qcm90b2Nv
bCAgICAgIDMyIAogICAgICBpRnVuY3Rpb24gICAgICAgICAgICAgICAwIAogICAgSW50ZXJm
YWNlIERlc2NyaXB0b3I6CiAgICAgIGJMZW5ndGggICAgICAgICAgICAgICAgIDkKICAgICAg
YkRlc2NyaXB0b3JUeXBlICAgICAgICAgNAogICAgICBiSW50ZXJmYWNlTnVtYmVyICAgICAg
ICAwCiAgICAgIGJBbHRlcm5hdGVTZXR0aW5nICAgICAgIDAKICAgICAgYk51bUVuZHBvaW50
cyAgICAgICAgICAgMgogICAgICBiSW50ZXJmYWNlQ2xhc3MgICAgICAgMjU1IFZlbmRvciBT
cGVjaWZpYyBDbGFzcwogICAgICBiSW50ZXJmYWNlU3ViQ2xhc3MgICAgICAwIAogICAgICBi
SW50ZXJmYWNlUHJvdG9jb2wgICAgICAwIAogICAgICBpSW50ZXJmYWNlICAgICAgICAgICAg
ICA0IE1zZyBQaXBlCiAgICAgIEVuZHBvaW50IERlc2NyaXB0b3I6CiAgICAgICAgYkxlbmd0
aCAgICAgICAgICAgICAgICAgNwogICAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDUK
ICAgICAgICBiRW5kcG9pbnRBZGRyZXNzICAgICAweDgxICBFUCAxIElOCiAgICAgICAgYm1B
dHRyaWJ1dGVzICAgICAgICAgICAgMgogICAgICAgICAgVHJhbnNmZXIgVHlwZSAgICAgICAg
ICAgIEJ1bGsKICAgICAgICAgIFN5bmNoIFR5cGUgICAgICAgICAgICAgICBOb25lCiAgICAg
ICAgICBVc2FnZSBUeXBlICAgICAgICAgICAgICAgRGF0YQogICAgICAgIHdNYXhQYWNrZXRT
aXplICAgICAweDAyMDAgIDF4IDUxMiBieXRlcwogICAgICAgIGJJbnRlcnZhbCAgICAgICAg
ICAgICAgIDAKICAgICAgRW5kcG9pbnQgRGVzY3JpcHRvcjoKICAgICAgICBiTGVuZ3RoICAg
ICAgICAgICAgICAgICA3CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgNQogICAg
ICAgIGJFbmRwb2ludEFkZHJlc3MgICAgIDB4MDEgIEVQIDEgT1VUCiAgICAgICAgYm1BdHRy
aWJ1dGVzICAgICAgICAgICAgMgogICAgICAgICAgVHJhbnNmZXIgVHlwZSAgICAgICAgICAg
IEJ1bGsKICAgICAgICAgIFN5bmNoIFR5cGUgICAgICAgICAgICAgICBOb25lCiAgICAgICAg
ICBVc2FnZSBUeXBlICAgICAgICAgICAgICAgRGF0YQogICAgICAgIHdNYXhQYWNrZXRTaXpl
ICAgICAweDAyMDAgIDF4IDUxMiBieXRlcwogICAgICAgIGJJbnRlcnZhbCAgICAgICAgICAg
ICAgIDAKICAgIEludGVyZmFjZSBEZXNjcmlwdG9yOgogICAgICBiTGVuZ3RoICAgICAgICAg
ICAgICAgICA5CiAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDQKICAgICAgYkludGVy
ZmFjZU51bWJlciAgICAgICAgMQogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAgICAgICAwCiAg
ICAgIGJOdW1FbmRwb2ludHMgICAgICAgICAgIDAKICAgICAgYkludGVyZmFjZUNsYXNzICAg
ICAgICAgMSBBdWRpbwogICAgICBiSW50ZXJmYWNlU3ViQ2xhc3MgICAgICAxIENvbnRyb2wg
RGV2aWNlCiAgICAgIGJJbnRlcmZhY2VQcm90b2NvbCAgICAgMzIgCiAgICAgIGlJbnRlcmZh
Y2UgICAgICAgICAgICAgIDYgSEVMSVggQXVkaW8KICAgICAgQXVkaW9Db250cm9sIEludGVy
ZmFjZSBEZXNjcmlwdG9yOgogICAgICAgIGJMZW5ndGggICAgICAgICAgICAgICAgIDkKICAg
ICAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgIDM2CiAgICAgICAgYkRlc2NyaXB0b3JTdWJ0
eXBlICAgICAgMSAoSEVBREVSKQogICAgICAgIGJjZEFEQyAgICAgICAgICAgICAgIDIuMDAK
ICAgICAgICBiQ2F0ZWdvcnkgICAgICAgICAgICAgIDEwCiAgICAgICAgd1RvdGFsTGVuZ3Ro
ICAgICAgICAgICA0NgogICAgICAgIGJtQ29udHJvbCAgICAgICAgICAgIDB4MDAKICAgICAg
QXVkaW9Db250cm9sIEludGVyZmFjZSBEZXNjcmlwdG9yOgogICAgICAgIGJMZW5ndGggICAg
ICAgICAgICAgICAgIDgKICAgICAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgIDM2CiAgICAg
ICAgYkRlc2NyaXB0b3JTdWJ0eXBlICAgICAxMCAoQ0xPQ0tfU09VUkNFKQogICAgICAgIGJD
bG9ja0lEICAgICAgICAgICAgICAgMTYKICAgICAgICBibUF0dHJpYnV0ZXMgICAgICAgICAw
eDAxIEludGVybmFsIGZpeGVkIENsb2NrIAogICAgICAgIGJtQ29udHJvbHMgICAgICAgICAg
IDB4MDAKICAgICAgICBiQXNzb2NUZXJtaW5hbCAgICAgICAgICAwCiAgICAgICAgaUNsb2Nr
U291cmNlICAgICAgICAgICAgMCAKICAgICAgQXVkaW9Db250cm9sIEludGVyZmFjZSBEZXNj
cmlwdG9yOgogICAgICAgIGJMZW5ndGggICAgICAgICAgICAgICAgMTcKICAgICAgICBiRGVz
Y3JpcHRvclR5cGUgICAgICAgIDM2CiAgICAgICAgYkRlc2NyaXB0b3JTdWJ0eXBlICAgICAg
MiAoSU5QVVRfVEVSTUlOQUwpCiAgICAgICAgYlRlcm1pbmFsSUQgICAgICAgICAgICAzMgog
ICAgICAgIHdUZXJtaW5hbFR5cGUgICAgICAweDAyMDEgTWljcm9waG9uZQogICAgICAgIGJB
c3NvY1Rlcm1pbmFsICAgICAgICAgNjQKICAgICAgICBiQ1NvdXJjZUlEICAgICAgICAgICAg
IDE2CiAgICAgICAgYk5yQ2hhbm5lbHMgICAgICAgICAgICAgOAogICAgICAgIGJtQ2hhbm5l
bENvbmZpZyAgIDB4MDAwMDAwMDAKICAgICAgICBibUNvbnRyb2xzICAgIDB4MDAwMAogICAg
ICAgIGlDaGFubmVsTmFtZXMgICAgICAgICAgIDAgCiAgICAgICAgaVRlcm1pbmFsICAgICAg
ICAgICAgICAgMCAKICAgICAgQXVkaW9Db250cm9sIEludGVyZmFjZSBEZXNjcmlwdG9yOgog
ICAgICAgIGJMZW5ndGggICAgICAgICAgICAgICAgMTIKICAgICAgICBiRGVzY3JpcHRvclR5
cGUgICAgICAgIDM2CiAgICAgICAgYkRlc2NyaXB0b3JTdWJ0eXBlICAgICAgMyAoT1VUUFVU
X1RFUk1JTkFMKQogICAgICAgIGJUZXJtaW5hbElEICAgICAgICAgICAgNjQKICAgICAgICB3
VGVybWluYWxUeXBlICAgICAgMHgwMzAxIFNwZWFrZXIKICAgICAgICBiQXNzb2NUZXJtaW5h
bCAgICAgICAgIDMyCiAgICAgICAgYlNvdXJjZUlEICAgICAgICAgICAgICAzMgogICAgICAg
IGJDU291cmNlSUQgICAgICAgICAgICAgMTYKICAgICAgICBibUNvbnRyb2xzICAgICAgICAg
MHgwMDAwCiAgICAgICAgaVRlcm1pbmFsICAgICAgICAgICAgICAgMCAKICAgIEludGVyZmFj
ZSBEZXNjcmlwdG9yOgogICAgICBiTGVuZ3RoICAgICAgICAgICAgICAgICA5CiAgICAgIGJE
ZXNjcmlwdG9yVHlwZSAgICAgICAgIDQKICAgICAgYkludGVyZmFjZU51bWJlciAgICAgICAg
MgogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAgICAgICAwCiAgICAgIGJOdW1FbmRwb2ludHMg
ICAgICAgICAgIDAKICAgICAgYkludGVyZmFjZUNsYXNzICAgICAgICAgMSBBdWRpbwogICAg
ICBiSW50ZXJmYWNlU3ViQ2xhc3MgICAgICAyIFN0cmVhbWluZwogICAgICBiSW50ZXJmYWNl
UHJvdG9jb2wgICAgIDMyIAogICAgICBpSW50ZXJmYWNlICAgICAgICAgICAgICAwIAogICAg
SW50ZXJmYWNlIERlc2NyaXB0b3I6CiAgICAgIGJMZW5ndGggICAgICAgICAgICAgICAgIDkK
ICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgNAogICAgICBiSW50ZXJmYWNlTnVtYmVy
ICAgICAgICAyCiAgICAgIGJBbHRlcm5hdGVTZXR0aW5nICAgICAgIDEKICAgICAgYk51bUVu
ZHBvaW50cyAgICAgICAgICAgMQogICAgICBiSW50ZXJmYWNlQ2xhc3MgICAgICAgICAxIEF1
ZGlvCiAgICAgIGJJbnRlcmZhY2VTdWJDbGFzcyAgICAgIDIgU3RyZWFtaW5nCiAgICAgIGJJ
bnRlcmZhY2VQcm90b2NvbCAgICAgMzIgCiAgICAgIGlJbnRlcmZhY2UgICAgICAgICAgICAg
IDAgCiAgICAgIEF1ZGlvU3RyZWFtaW5nIEludGVyZmFjZSBEZXNjcmlwdG9yOgogICAgICAg
IGJMZW5ndGggICAgICAgICAgICAgICAgMTYKICAgICAgICBiRGVzY3JpcHRvclR5cGUgICAg
ICAgIDM2CiAgICAgICAgYkRlc2NyaXB0b3JTdWJ0eXBlICAgICAgMSAoQVNfR0VORVJBTCkK
ICAgICAgICBiVGVybWluYWxMaW5rICAgICAgICAgIDMyCiAgICAgICAgYm1Db250cm9scyAg
ICAgICAgICAgMHgwMAogICAgICAgIGJGb3JtYXRUeXBlICAgICAgICAgICAgIDEKICAgICAg
ICBibUZvcm1hdHMgICAgICAgICAweDAwMDAwMDAxCiAgICAgICAgICBQQ00KICAgICAgICBi
TnJDaGFubmVscyAgICAgICAgICAgICA4CiAgICAgICAgYm1DaGFubmVsQ29uZmlnICAgMHgw
MDAwMDAwMAogICAgICAgIGlDaGFubmVsTmFtZXMgICAgICAgICAgIDAgCiAgICAgIEF1ZGlv
U3RyZWFtaW5nIEludGVyZmFjZSBEZXNjcmlwdG9yOgogICAgICAgIGJMZW5ndGggICAgICAg
ICAgICAgICAgIDYKICAgICAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgIDM2CiAgICAgICAg
YkRlc2NyaXB0b3JTdWJ0eXBlICAgICAgMiAoRk9STUFUX1RZUEUpCiAgICAgICAgYkZvcm1h
dFR5cGUgICAgICAgICAgICAgMSAoRk9STUFUX1RZUEVfSSkKICAgICAgICBiU3Vic2xvdFNp
emUgICAgICAgICAgICA0CiAgICAgICAgYkJpdFJlc29sdXRpb24gICAgICAgICAyNAogICAg
ICBFbmRwb2ludCBEZXNjcmlwdG9yOgogICAgICAgIGJMZW5ndGggICAgICAgICAgICAgICAg
IDcKICAgICAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgICA1CiAgICAgICAgYkVuZHBvaW50
QWRkcmVzcyAgICAgMHgwMyAgRVAgMyBPVVQKICAgICAgICBibUF0dHJpYnV0ZXMgICAgICAg
ICAgICA1CiAgICAgICAgICBUcmFuc2ZlciBUeXBlICAgICAgICAgICAgSXNvY2hyb25vdXMK
ICAgICAgICAgIFN5bmNoIFR5cGUgICAgICAgICAgICAgICBBc3luY2hyb25vdXMKICAgICAg
ICAgIFVzYWdlIFR5cGUgICAgICAgICAgICAgICBEYXRhCiAgICAgICAgd01heFBhY2tldFNp
emUgICAgIDB4MDBlMCAgMXggMjI0IGJ5dGVzCiAgICAgICAgYkludGVydmFsICAgICAgICAg
ICAgICAgMQogICAgICAgIEF1ZGlvQ29udHJvbCBFbmRwb2ludCBEZXNjcmlwdG9yOgogICAg
ICAgICAgYkxlbmd0aCAgICAgICAgICAgICAgICAgOAogICAgICAgICAgYkRlc2NyaXB0b3JU
eXBlICAgICAgICAzNwogICAgICAgICAgYkRlc2NyaXB0b3JTdWJ0eXBlICAgICAgMSAoRVBf
R0VORVJBTCkKICAgICAgICAgIGJtQXR0cmlidXRlcyAgICAgICAgIDB4MDAKICAgICAgICAg
IGJtQ29udHJvbHMgICAgICAgICAgIDB4MDAKICAgICAgICAgIGJMb2NrRGVsYXlVbml0cyAg
ICAgICAgIDAgVW5kZWZpbmVkCiAgICAgICAgICB3TG9ja0RlbGF5ICAgICAgICAgICAgICAw
CiAgICBJbnRlcmZhY2UgRGVzY3JpcHRvcjoKICAgICAgYkxlbmd0aCAgICAgICAgICAgICAg
ICAgOQogICAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgICA0CiAgICAgIGJJbnRlcmZhY2VO
dW1iZXIgICAgICAgIDMKICAgICAgYkFsdGVybmF0ZVNldHRpbmcgICAgICAgMAogICAgICBi
TnVtRW5kcG9pbnRzICAgICAgICAgICAwCiAgICAgIGJJbnRlcmZhY2VDbGFzcyAgICAgICAg
IDEgQXVkaW8KICAgICAgYkludGVyZmFjZVN1YkNsYXNzICAgICAgMiBTdHJlYW1pbmcKICAg
ICAgYkludGVyZmFjZVByb3RvY29sICAgICAzMiAKICAgICAgaUludGVyZmFjZSAgICAgICAg
ICAgICAgMCAKICAgIEludGVyZmFjZSBEZXNjcmlwdG9yOgogICAgICBiTGVuZ3RoICAgICAg
ICAgICAgICAgICA5CiAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDQKICAgICAgYklu
dGVyZmFjZU51bWJlciAgICAgICAgMwogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAgICAgICAx
CiAgICAgIGJOdW1FbmRwb2ludHMgICAgICAgICAgIDEKICAgICAgYkludGVyZmFjZUNsYXNz
ICAgICAgICAgMSBBdWRpbwogICAgICBiSW50ZXJmYWNlU3ViQ2xhc3MgICAgICAyIFN0cmVh
bWluZwogICAgICBiSW50ZXJmYWNlUHJvdG9jb2wgICAgIDMyIAogICAgICBpSW50ZXJmYWNl
ICAgICAgICAgICAgICAwIAogICAgICBBdWRpb1N0cmVhbWluZyBJbnRlcmZhY2UgRGVzY3Jp
cHRvcjoKICAgICAgICBiTGVuZ3RoICAgICAgICAgICAgICAgIDE2CiAgICAgICAgYkRlc2Ny
aXB0b3JUeXBlICAgICAgICAzNgogICAgICAgIGJEZXNjcmlwdG9yU3VidHlwZSAgICAgIDEg
KEFTX0dFTkVSQUwpCiAgICAgICAgYlRlcm1pbmFsTGluayAgICAgICAgICA2NAogICAgICAg
IGJtQ29udHJvbHMgICAgICAgICAgIDB4MDAKICAgICAgICBiRm9ybWF0VHlwZSAgICAgICAg
ICAgICAxCiAgICAgICAgYm1Gb3JtYXRzICAgICAgICAgMHgwMDAwMDAwMQogICAgICAgICAg
UENNCiAgICAgICAgYk5yQ2hhbm5lbHMgICAgICAgICAgICAgOAogICAgICAgIGJtQ2hhbm5l
bENvbmZpZyAgIDB4MDAwMDAwMDAKICAgICAgICBpQ2hhbm5lbE5hbWVzICAgICAgICAgICAw
IAogICAgICBBdWRpb1N0cmVhbWluZyBJbnRlcmZhY2UgRGVzY3JpcHRvcjoKICAgICAgICBi
TGVuZ3RoICAgICAgICAgICAgICAgICA2CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAg
ICAzNgogICAgICAgIGJEZXNjcmlwdG9yU3VidHlwZSAgICAgIDIgKEZPUk1BVF9UWVBFKQog
ICAgICAgIGJGb3JtYXRUeXBlICAgICAgICAgICAgIDEgKEZPUk1BVF9UWVBFX0kpCiAgICAg
ICAgYlN1YnNsb3RTaXplICAgICAgICAgICAgNAogICAgICAgIGJCaXRSZXNvbHV0aW9uICAg
ICAgICAgMjQKICAgICAgRW5kcG9pbnQgRGVzY3JpcHRvcjoKICAgICAgICBiTGVuZ3RoICAg
ICAgICAgICAgICAgICA3CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgNQogICAg
ICAgIGJFbmRwb2ludEFkZHJlc3MgICAgIDB4ODMgIEVQIDMgSU4KICAgICAgICBibUF0dHJp
YnV0ZXMgICAgICAgICAgIDM3CiAgICAgICAgICBUcmFuc2ZlciBUeXBlICAgICAgICAgICAg
SXNvY2hyb25vdXMKICAgICAgICAgIFN5bmNoIFR5cGUgICAgICAgICAgICAgICBBc3luY2hy
b25vdXMKICAgICAgICAgIFVzYWdlIFR5cGUgICAgICAgICAgICAgICBJbXBsaWNpdCBmZWVk
YmFjayBEYXRhCiAgICAgICAgd01heFBhY2tldFNpemUgICAgIDB4MDBlMCAgMXggMjI0IGJ5
dGVzCiAgICAgICAgYkludGVydmFsICAgICAgICAgICAgICAgMQogICAgICAgIEF1ZGlvQ29u
dHJvbCBFbmRwb2ludCBEZXNjcmlwdG9yOgogICAgICAgICAgYkxlbmd0aCAgICAgICAgICAg
ICAgICAgOAogICAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAzNwogICAgICAgICAg
YkRlc2NyaXB0b3JTdWJ0eXBlICAgICAgMSAoRVBfR0VORVJBTCkKICAgICAgICAgIGJtQXR0
cmlidXRlcyAgICAgICAgIDB4MDAKICAgICAgICAgIGJtQ29udHJvbHMgICAgICAgICAgIDB4
MDAKICAgICAgICAgIGJMb2NrRGVsYXlVbml0cyAgICAgICAgIDAgVW5kZWZpbmVkCiAgICAg
ICAgICB3TG9ja0RlbGF5ICAgICAgICAgICAgICAwCiAgICBJbnRlcmZhY2UgRGVzY3JpcHRv
cjoKICAgICAgYkxlbmd0aCAgICAgICAgICAgICAgICAgOQogICAgICBiRGVzY3JpcHRvclR5
cGUgICAgICAgICA0CiAgICAgIGJJbnRlcmZhY2VOdW1iZXIgICAgICAgIDQKICAgICAgYkFs
dGVybmF0ZVNldHRpbmcgICAgICAgMAogICAgICBiTnVtRW5kcG9pbnRzICAgICAgICAgICAy
CiAgICAgIGJJbnRlcmZhY2VDbGFzcyAgICAgICAgIDEgQXVkaW8KICAgICAgYkludGVyZmFj
ZVN1YkNsYXNzICAgICAgMyBNSURJIFN0cmVhbWluZwogICAgICBiSW50ZXJmYWNlUHJvdG9j
b2wgICAgICAwIAogICAgICBpSW50ZXJmYWNlICAgICAgICAgICAgICA3IEhFTElYIE1JREkK
ICAgICAgTUlESVN0cmVhbWluZyBJbnRlcmZhY2UgRGVzY3JpcHRvcjoKICAgICAgICBiTGVu
Z3RoICAgICAgICAgICAgICAgICA3CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAz
NgogICAgICAgIGJEZXNjcmlwdG9yU3VidHlwZSAgICAgIDEgKEhFQURFUikKICAgICAgICBi
Y2RBREMgICAgICAgICAgICAgICAxLjAwCiAgICAgICAgd1RvdGFsTGVuZ3RoICAgICAgICAg
ICA2MQogICAgICBNSURJU3RyZWFtaW5nIEludGVyZmFjZSBEZXNjcmlwdG9yOgogICAgICAg
IGJMZW5ndGggICAgICAgICAgICAgICAgIDYKICAgICAgICBiRGVzY3JpcHRvclR5cGUgICAg
ICAgIDM2CiAgICAgICAgYkRlc2NyaXB0b3JTdWJ0eXBlICAgICAgMiAoTUlESV9JTl9KQUNL
KQogICAgICAgIGJKYWNrVHlwZSAgICAgICAgICAgICAgIDEgRW1iZWRkZWQKICAgICAgICBi
SmFja0lEICAgICAgICAgICAgICAgICAxCiAgICAgICAgaUphY2sgICAgICAgICAgICAgICAg
ICAgMCAKICAgICAgTUlESVN0cmVhbWluZyBJbnRlcmZhY2UgRGVzY3JpcHRvcjoKICAgICAg
ICBiTGVuZ3RoICAgICAgICAgICAgICAgICA2CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAg
ICAgICAzNgogICAgICAgIGJEZXNjcmlwdG9yU3VidHlwZSAgICAgIDIgKE1JRElfSU5fSkFD
SykKICAgICAgICBiSmFja1R5cGUgICAgICAgICAgICAgICAyIEV4dGVybmFsCiAgICAgICAg
YkphY2tJRCAgICAgICAgICAgICAgICAgMgogICAgICAgIGlKYWNrICAgICAgICAgICAgICAg
ICAgIDAgCiAgICAgIE1JRElTdHJlYW1pbmcgSW50ZXJmYWNlIERlc2NyaXB0b3I6CiAgICAg
ICAgYkxlbmd0aCAgICAgICAgICAgICAgICAgOQogICAgICAgIGJEZXNjcmlwdG9yVHlwZSAg
ICAgICAgMzYKICAgICAgICBiRGVzY3JpcHRvclN1YnR5cGUgICAgICAzIChNSURJX09VVF9K
QUNLKQogICAgICAgIGJKYWNrVHlwZSAgICAgICAgICAgICAgIDEgRW1iZWRkZWQKICAgICAg
ICBiSmFja0lEICAgICAgICAgICAgICAgICAzCiAgICAgICAgYk5ySW5wdXRQaW5zICAgICAg
ICAgICAgMQogICAgICAgIGJhU291cmNlSUQoIDApICAgICAgICAgIDIKICAgICAgICBCYVNv
dXJjZVBpbiggMCkgICAgICAgICAxCiAgICAgICAgaUphY2sgICAgICAgICAgICAgICAgICAg
MCAKICAgICAgTUlESVN0cmVhbWluZyBJbnRlcmZhY2UgRGVzY3JpcHRvcjoKICAgICAgICBi
TGVuZ3RoICAgICAgICAgICAgICAgICA5CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAg
ICAzNgogICAgICAgIGJEZXNjcmlwdG9yU3VidHlwZSAgICAgIDMgKE1JRElfT1VUX0pBQ0sp
CiAgICAgICAgYkphY2tUeXBlICAgICAgICAgICAgICAgMiBFeHRlcm5hbAogICAgICAgIGJK
YWNrSUQgICAgICAgICAgICAgICAgIDQKICAgICAgICBiTnJJbnB1dFBpbnMgICAgICAgICAg
ICAxCiAgICAgICAgYmFTb3VyY2VJRCggMCkgICAgICAgICAgMQogICAgICAgIEJhU291cmNl
UGluKCAwKSAgICAgICAgIDEKICAgICAgICBpSmFjayAgICAgICAgICAgICAgICAgICAwIAog
ICAgICBFbmRwb2ludCBEZXNjcmlwdG9yOgogICAgICAgIGJMZW5ndGggICAgICAgICAgICAg
ICAgIDcKICAgICAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgICA1CiAgICAgICAgYkVuZHBv
aW50QWRkcmVzcyAgICAgMHgwNCAgRVAgNCBPVVQKICAgICAgICBibUF0dHJpYnV0ZXMgICAg
ICAgICAgICAyCiAgICAgICAgICBUcmFuc2ZlciBUeXBlICAgICAgICAgICAgQnVsawogICAg
ICAgICAgU3luY2ggVHlwZSAgICAgICAgICAgICAgIE5vbmUKICAgICAgICAgIFVzYWdlIFR5
cGUgICAgICAgICAgICAgICBEYXRhCiAgICAgICAgd01heFBhY2tldFNpemUgICAgIDB4MDIw
MCAgMXggNTEyIGJ5dGVzCiAgICAgICAgYkludGVydmFsICAgICAgICAgICAgICAgMAogICAg
ICAgIE1JRElTdHJlYW1pbmcgRW5kcG9pbnQgRGVzY3JpcHRvcjoKICAgICAgICAgIGJMZW5n
dGggICAgICAgICAgICAgICAgIDUKICAgICAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAg
MzcKICAgICAgICAgIGJEZXNjcmlwdG9yU3VidHlwZSAgICAgIDEgKEdFTkVSQUwpCiAgICAg
ICAgICBiTnVtRW1iTUlESUphY2sgICAgICAgICAxCiAgICAgICAgICBiYUFzc29jSmFja0lE
KCAwKSAgICAgICAxCiAgICAgIEVuZHBvaW50IERlc2NyaXB0b3I6CiAgICAgICAgYkxlbmd0
aCAgICAgICAgICAgICAgICAgNwogICAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDUK
ICAgICAgICBiRW5kcG9pbnRBZGRyZXNzICAgICAweDg0ICBFUCA0IElOCiAgICAgICAgYm1B
dHRyaWJ1dGVzICAgICAgICAgICAgMgogICAgICAgICAgVHJhbnNmZXIgVHlwZSAgICAgICAg
ICAgIEJ1bGsKICAgICAgICAgIFN5bmNoIFR5cGUgICAgICAgICAgICAgICBOb25lCiAgICAg
ICAgICBVc2FnZSBUeXBlICAgICAgICAgICAgICAgRGF0YQogICAgICAgIHdNYXhQYWNrZXRT
aXplICAgICAweDAyMDAgIDF4IDUxMiBieXRlcwogICAgICAgIGJJbnRlcnZhbCAgICAgICAg
ICAgICAgIDAKICAgICAgICBNSURJU3RyZWFtaW5nIEVuZHBvaW50IERlc2NyaXB0b3I6CiAg
ICAgICAgICBiTGVuZ3RoICAgICAgICAgICAgICAgICA1CiAgICAgICAgICBiRGVzY3JpcHRv
clR5cGUgICAgICAgIDM3CiAgICAgICAgICBiRGVzY3JpcHRvclN1YnR5cGUgICAgICAxIChH
RU5FUkFMKQogICAgICAgICAgYk51bUVtYk1JRElKYWNrICAgICAgICAgMQogICAgICAgICAg
YmFBc3NvY0phY2tJRCggMCkgICAgICAgMwpEZXZpY2UgUXVhbGlmaWVyIChmb3Igb3RoZXIg
ZGV2aWNlIHNwZWVkKToKICBiTGVuZ3RoICAgICAgICAgICAgICAgIDEwCiAgYkRlc2NyaXB0
b3JUeXBlICAgICAgICAgNgogIGJjZFVTQiAgICAgICAgICAgICAgIDIuMDAKICBiRGV2aWNl
Q2xhc3MgICAgICAgICAgICAwIChEZWZpbmVkIGF0IEludGVyZmFjZSBsZXZlbCkKICBiRGV2
aWNlU3ViQ2xhc3MgICAgICAgICAwIAogIGJEZXZpY2VQcm90b2NvbCAgICAgICAgIDAgCiAg
Yk1heFBhY2tldFNpemUwICAgICAgICA2NAogIGJOdW1Db25maWd1cmF0aW9ucyAgICAgIDEK
RGV2aWNlIFN0YXR1czogICAgIDB4MDAwMQogIFNlbGYgUG93ZXJlZAo=
--------------8551D59847B94CD96A0BF606
Content-Type: text/plain; charset=UTF-8;
 name="helix_last_patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="helix_last_patch.txt"

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9jbG9jay5jIGIvc291bmQvdXNiL2Nsb2NrLmMKaW5k
ZXggOTJlNjkxOC4uZDI1OTg2YSAxMDA2NDQKLS0tIGEvc291bmQvdXNiL2Nsb2NrLmMKKysr
IGIvc291bmQvdXNiL2Nsb2NrLmMKQEAgLTM3Myw3ICszNzMsNiBAQCBzdGF0aWMgaW50IHNl
dF9zYW1wbGVfcmF0ZV92MihzdHJ1Y3Qgc25kX3VzYl9hdWRpbyAqY2hpcCwgaW50IGlmYWNl
LAogICAgIAlpZiAoY2hpcC0+dXNiX2lkID09IFVTQl9JRCgweDBlNDEsIDB4NDI0NCkgJiYg
cmF0ZSA9PSA0ODAwMCkKICAgICAgICAgCXJldHVybiAwOwogCi0KIAlpZiAoY2xvY2sgPCAw
KQogCQlyZXR1cm4gY2xvY2s7CiAKZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9lbmRwb2ludC5j
IGIvc291bmQvdXNiL2VuZHBvaW50LmMKaW5kZXggYzkwNjA3ZS4uMDI2MDk1YSAxMDA2NDQK
LS0tIGEvc291bmQvdXNiL2VuZHBvaW50LmMKKysrIGIvc291bmQvdXNiL2VuZHBvaW50LmMK
QEAgLTg4OCw2ICs4ODgsOCBAQCBpbnQgc25kX3VzYl9lbmRwb2ludF9zZXRfcGFyYW1zKHN0
cnVjdCBzbmRfdXNiX2VuZHBvaW50ICplcCwKIAogCWlmIChzbmRfdXNiX2dldF9zcGVlZChl
cC0+Y2hpcC0+ZGV2KSA9PSBVU0JfU1BFRURfRlVMTCkKIAkJZXAtPmZyZXFuID0gZ2V0X3Vz
Yl9mdWxsX3NwZWVkX3JhdGUocmF0ZSk7CisJZWxzZSBpZiAoVVNCX0lEKDB4MGU0MSwgMHg0
MjQ0KSkKKwkJZXAtPmZyZXFuID0gZ2V0X3VzYl9oaWdoX3NwZWVkX3JhdGUocmF0ZSArIDUp
OyAvLyB1Z2x5IGhlbGl4IGhhY2ssIHJlYWRvdXQgZnJvbSBmb2N1c3JpdGUgc2NhcmxldHQg
b24gc2FtZSB1c2JidXMKIAllbHNlCiAJCWVwLT5mcmVxbiA9IGdldF91c2JfaGlnaF9zcGVl
ZF9yYXRlKHJhdGUpOwogCmRpZmYgLS1naXQgYS9zb3VuZC91c2IvZm9ybWF0LmMgYi9zb3Vu
ZC91c2IvZm9ybWF0LmMKaW5kZXggMWMwMTA3ZC4uODg2MDg5ZiAxMDA2NDQKLS0tIGEvc291
bmQvdXNiL2Zvcm1hdC5jCisrKyBiL3NvdW5kL3VzYi9mb3JtYXQuYwpAQCAtMzA1LDcgKzMw
NSw3IEBAIHN0YXRpYyBpbnQgcGFyc2VfYXVkaW9fZm9ybWF0X3JhdGVzX3YyKHN0cnVjdCBz
bmRfdXNiX2F1ZGlvICpjaGlwLAogCWlmIChjaGlwLT51c2JfaWQgPT0gVVNCX0lEKDB4MGU0
MSwgMHg0MjQ0KSkgewogCQlmcC0+bnJfcmF0ZXMgPSAxOwogICAgICAgICAJZnAtPnJhdGVf
bWluID0gNDgwMDA7Ci0gICAgICAgIAlmcC0+cmF0ZV9tYXggPSA0ODAwMDsKKwkgICAgICAg
CWZwLT5yYXRlX21heCA9IDQ4MDAwOwogICAgICAgICAJZnAtPnJhdGVzID0gU05EUlZfUENN
X1JBVEVfNDgwMDA7CiAgICAgICAgIAlmcC0+cmF0ZV90YWJsZSA9IGttYWxsb2Moc2l6ZW9m
KGludCksIEdGUF9LRVJORUwpOwogICAgICAgICAJZnAtPnJhdGVfdGFibGVbMF0gPSA0ODAw
MDsKCg==
--------------8551D59847B94CD96A0BF606
Content-Type: text/plain; charset=UTF-8;
 name="helix_proc_asound_stream.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="helix_proc_asound_stream.txt"

L3Byb2MvYXNvdW5kL0hFTElYL3N0cmVhbTA6CgpMSU5FIDYgSEVMSVggYXQgdXNiLTAwMDA6
MDc6MDAuMC0yLCBoaWdoIHNwZWVkIDogVVNCIEF1ZGlvCgpQbGF5YmFjazoKICBTdGF0dXM6
IFJ1bm5pbmcKICAgIEludGVyZmFjZSA9IDIKICAgIEFsdHNldCA9IDEKICAgIFBhY2tldCBT
aXplID0gMjI0CiAgICBNb21lbnRhcnkgZnJlcSA9IDQ4MDA1IEh6ICgweDYuMDAyOSkKICBJ
bnRlcmZhY2UgMgogICAgQWx0c2V0IDEKICAgIEZvcm1hdDogUzMyX0xFCiAgICBDaGFubmVs
czogOAogICAgRW5kcG9pbnQ6IDMgT1VUIChBU1lOQykKICAgIFJhdGVzOiA0ODAwMAogICAg
RGF0YSBwYWNrZXQgaW50ZXJ2YWw6IDEyNSB1cwoKQ2FwdHVyZToKICBTdGF0dXM6IFJ1bm5p
bmcKICAgIEludGVyZmFjZSA9IDMKICAgIEFsdHNldCA9IDEKICAgIFBhY2tldCBTaXplID0g
MjI0CiAgICBNb21lbnRhcnkgZnJlcSA9IDQ4MDA1IEh6ICgweDYuMDAyOSkKICBJbnRlcmZh
Y2UgMwogICAgQWx0c2V0IDEKICAgIEZvcm1hdDogUzMyX0xFCiAgICBDaGFubmVsczogOAog
ICAgRW5kcG9pbnQ6IDMgSU4gKEFTWU5DKQogICAgUmF0ZXM6IDQ4MDAwCiAgICBEYXRhIHBh
Y2tldCBpbnRlcnZhbDogMTI1IHVzCgo=
--------------8551D59847B94CD96A0BF606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------8551D59847B94CD96A0BF606--
