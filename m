From: "Arve Knudsen" <aknuds-1@broadpark.no>
Subject: Re: Problem writing to PCM plugin
Date: Wed, 11 Aug 2004 15:53:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opsckl7wiwfmr65f@mail.broadpark.no>
References: <opscklaj0ufmr65f@mail.broadpark.no> <Pine.LNX.4.58.0408111536030.1788@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0408111536030.1788@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

The plugin:
pcm.9636SPDIF {
     type plug
     slave.pcm "hw:1"
     ttable.0.16 1
     ttable.1.17 1
}

The dump:
Plug PCM: Linear Integer <-> Linear Float conversion PCM (S32_LE)
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : FLOAT_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 32
buffer_size  : 2048
period_size  : 1024
period_time  : 23219
tick_time    : 1000
tstamp_mode  : MMAP
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1
start_threshold  : 1024
stop_threshold   : 2048
silence_threshold: 0
silence_size : 2147483647
boundary     : 1073741824
Slave: Route conversion PCM (sformat=3DS32_LE)
Transformation table:
0 <- none
1 <- none
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 32
buffer_size  : 2048
period_size  : 1024
period_time  : 23219
tick_time    : 1000
tstamp_mode  : MMAP
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1
start_threshold  : 1024
stop_threshold   : 2048
silence_threshold: 0
silence_size : 2147483647
boundary     : 1073741824
Slave: Route conversion PCM (sformat=3DS32_LE)
Transformation table:
0 <- none
1 <- none
2 <- none
3 <- none
4 <- none
5 <- none
6 <- none
7 <- none
8 <- none
9 <- none
10 <- none
11 <- none
12 <- none
13 <- none
14 <- none
15 <- none
16 <- 0
17 <- 1
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 32
buffer_size  : 2048
period_size  : 1024
period_time  : 23219
tick_time    : 1000
tstamp_mode  : MMAP
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1
start_threshold  : 1024
stop_threshold   : 2048
silence_threshold: 0
silence_size : 2147483647
boundary     : 1073741824
Slave: Hardware PCM card 1 'RME Digi9636 (Rev 1.5)' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_NONINTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 18
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 24
buffer_size  : 2048
period_size  : 1024
period_time  : 23219
tick_time    : 1000
tstamp_mode  : MMAP
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1
start_threshold  : 1024
stop_threshold   : 2048
silence_threshold: 0
silence_size : 2147483647
boundary     : 1073741824

On Wed, 11 Aug 2004 15:36:24 +0200 (CEST), Jaroslav Kysela <perex@suse.cz=
> =20
wrote:

> On Wed, 11 Aug 2004, Arve Knudsen wrote:
>
>> point format in the PortAudio tests, so there is an intermediate
>> conversion before the audio gets to the routing plugin. Could this be =
=20
>> the
>> cause of the problem? If you wish I can provide output from =20
>> snd_pcm_dump.
>
> Yes, send the dump, please.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
