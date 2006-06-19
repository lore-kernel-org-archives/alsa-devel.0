From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Alsa-OSS so-called 'Duplex-bug'
Date: Mon, 19 Jun 2006 22:12:57 +0100
Message-ID: <200606192210.12889.gineera@aspect135.co.uk>
References: <200606191515.28395.alan@horstmann.fsworld.co.uk>
	<s5hd5d5jizn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZNxlEe/D0VBS8cE"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hd5d5jizn.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_ZNxlEe/D0VBS8cE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 19 June 2006 15:52, Takashi Iwai wrote:
> At Mon, 19 Jun 2006 15:15:28 +0100,
>
> Alan H wrote:
> > There is considered by some to be a duplex bug in alsa-OSS, which affects
> > for example audacity, which uses portaudio.  As this affects myself very
> > much I have investigated.
> >
> > The cause is that the OSS ioctl SNDCTL_DSP_CHANNELS cannot set separately
> > the playback and capture channels.  With the original OSS this was not a
> > problem AFAICT because separate playback and capture devices are created.
>
> Really?  How?  /dev/dsp0 and /dev/dsp1 for playback and capture?

For the ice1712 (my main 2 cards), apparently, a whole series of stereo 
devices are created; /dev/dsp0 to dsp4 cover the 10 playback channels, and 
dsp5 to 10 are capture; dsp11 & 12 are 'raw devices', 11 is playback, 12 
capture.  I have attached the OSS release notes I downloaded ages ago.

> >  However,
> > with the alsa-emulation, only a single device is created.  Thus it is not
> > possible to record 4 chs while playing 2.
> >
> > It seems to me that some method of separately setting playback and
> > capture channels should be included in the emulation.  This could be
> > through new ioctls eg SNDCTL_DSP_PCHANNELS and SNDCTL_DSP_CCHANNELS;
>
> Introducing new ioctls doesn't make sense because the purpose of aoss
> is to emulate the OSS, not creating a new one.

That is what I thought.

> >  I have devised an
> > alternative using the existing SNDCTL_DSP_CHANNELS, by passing 'channels'
> > calculated as (playback_channels + 256 * capture_channels) so that in
> > effect the first 8 bits are playback, the 2nd 8 bits are capture.  The
> > result is compatible with the existing, as numbers < 255 are treated in
> > the existing way, setting playback and capture the same if the
> > sub-streams are active. Thus it has simply added an enhanced mode.
> >
> > Diff is attached; I wonder what your thoughts are on this??  I have been
> > able to very simply patch portaudio to use this facility and the system
> > now works great.
>
> I don't think it's a right solution.  This simply introduces an
> incompatibility with the existing OSS ioctl...

The 'enhanced' alsa-emulation I created is backwards compatible; it enables 
aware apps to work-around the limitation of the emulation.  But if sent 
commands as-if standard, does exactly what it would have done.  However, 
where the app needs to set separate record and playback channels for a duplex 
mode, there is extra capability.  It would be used only for duplex when 
(capture_channels != playback_channels)  This would not be necessary with 
original OSS, although also it would not work.  None-the-less I can 
understand your reluctance, it is just that a solution seems necessary.

Another alternative would be for ALSA to create at least two devices, one for 
all playback channels, the other for all capture, eg /dsp0 and /adsp0 or 
something else.  It would then be more like the raws OSS in its behaviour.  
That would also solve the problems here.  Obviously a full implementation as 
per attached description would also be fine!

Alan



--Boundary-00=_ZNxlEe/D0VBS8cE
Content-Type: text/html; charset="iso-8859-1"; name="OSS-README.Envy24.html"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="OSS-README.Envy24.html"

<html><head><title>README.Envy24</title></head><body>
Release notes for the ICEnsemble Envy24 (ICE1712) driver<br>
========================================================<br>
<br>
Note! The Envy24 driver is a separately priced option of OSS. You need to <br>
      select the ENVY24 option when ordering the permanent OSS license<br>
      (the demo license contains this option).<br>
<br>
OSS 3.9.6e version includes BETA drivers for some new M Audio cards <br>
(410, TDIF and 1010LT). They have not been fully tested yet. Also<br>
support for Terratec EWS88D is improved from earlier OSS versions and<br>
the ADAT interface is now supported (BETA). Support for Terratec<br>
DMX6Fire is under progress. The driver recognizes the card but only the<br>
MIDI port works.<br>
<br>
The following cards are currently supported:<br>
<br>
M Audio (www.midiman.com):<br>
<br>
- Delta 1010<br>
  (World clock sync is not supported)<br>
- Delta 44<br>
- Delta 66<br>
- Delta DIO 2496<br>
- Audiophile 2496<br>
- Delta 410 (BETA)<br>
- Delta TDIF (BETA)<br>
  (See notes for Delta TDIF below)<br>
- Delta 1010LT (BETA)<br>
<br>
Terratec (www.terratec.com):<br>
- EWS88MT<br>
- EWS88D (BETA) (See notes for EWS88D below)<br>
- EWX24/96<br>
- DMX6fire 24/96 (BETA) (Many features not supported yet. In particular there<br>
  is no S/PDIF (digital) input/output).<br>
<br>
ST Audio (www.staudio.com):<br>
  At this moment only analog output is supported with ST Audio cards.<br>
- DSP24<br>
- DSP24 Value<br>
<br>
There are known problems with few applications: <br>
- With RealEncoder/RealProducer you need to turn on few options in the<br>
options.cfg (see below).<br>
- With mpg123 (at least versions 0.59r and earlier) you need to modify the<br>
sources and remove the call to ioctl(SNDCTL_DSP_GETBLKSIZE). Use fixed<br>
buffer size (say 512 or 1024) instead. This hopefully gets fixed in<br>
later versions of mpg123.<br>
<br>
Notes for M Audio Delta TDIF<br>
----------------------------<br>
<br>
The Delta TDIF driver is still a beta test version which means that<br>
there are some known problems.<br>
<br>
Loading OSS for the first time after boot takes really long and the<br>
system will stop responding for about 5 seconds. This is normal and is<br>
caused by loading of the board firmwarare.<br>
<br>
You may get some "Envy24: Unrecognized S/PDIF chip ID NN" messages during<br>
soundon. These are related with earlier attempts to use external sync.<br>
If they occur you should shut down and power off the system and restart it.<br>
<br>
There are some problems with the external world clock sync mode and it usually<br>
just doesn't work. Internal and S/PDIF sync modes work better. Use internal<br>
sync if possible since it's most reliable.<br>
<br>
The analog codec is not supported yet.<br>
<br>
Notes for EWS88D<br>
----------------<br>
<br>
The EWS88D driver is a beta test version. It works but all of the features<br>
have not been fully tested yet.<br>
<br>
There are few EWS88D specific settings in ossmix/ossxmix.<br>
<br>
- ews88d.spdin <OPTICAL|COAX> (currently COAX)<br>
  Selects the SPDIF input source between optical and coax.<br>
- ews88d.optout <SPDIF|ADAT> (currently SPDIF)<br>
  Changes the mode of the optical output between ADAT and SPDIF.<br>
- ews88d.adatloop ON|OFF (currently OFF)<br>
  Enables looping of ADAT input straight to the ADAT output in hardware level.<br>
<br>
The above settings have dependencies between each other so many of the<br>
possible combinations just don't work.<br>
<br>
The WCLOCK sync mode (envy24.sync=WCLOCK) means actually ADAT sync. The <br>
ADAT input signal is used as the clock source.<br>
<br>
Installing the driver<br>
---------------------<br>
<br>
The card will be automatically detected and configured by oss-install/soundconf<br>
and there are no adjustable options in soundconf. However there is one<br>
parameter that can be defined in the options.cfg file (in the directory where<br>
oss was installed).<br>
<br>
By default OSS creates separate device files for each input and output stereo<br>
pair supported by the device. So after executing soundon the /dev/sndstat file<br>
should look like:<br>
<br>
OSS/Linux 3.9.3i (C) 4Front Technologies 1996-2000<br>
<br>
License serial number: XXXXXXXXX<br>
Options: ENVY24<br>
This license is for Internal use by 4Front Technologies.<br>
<br>
Build: 2.3.45<br>
<br>
Card config: <br>
IC Ensemble ENVY24<br>
<br>
Audio devices:<br>
0: M Audio Delta 1010 out1/2<br>
1: M Audio Delta 1010 out3/4<br>
2: M Audio Delta 1010 out5/6<br>
3: M Audio Delta 1010 out7/8<br>
4: M Audio Delta 1010 S/PDIF out<br>
5: M Audio Delta 1010 in1/2<br>
6: M Audio Delta 1010 in3/4<br>
7: M Audio Delta 1010 in5/6<br>
8: M Audio Delta 1010 in7/8<br>
9: M Audio Delta 1010 S/PDIF in<br>
10: M Audio Delta 1010 input from mon. mixer<br>
11: M Audio Delta 1010 (all outputs)<br>
12: M Audio Delta 1010 (all inputs)<br>
<br>
Synth devices:<br>
<br>
Midi devices:<br>
0: M Audio Delta 1010<br>
<br>
Timers:<br>
0: System clock<br>
<br>
Mixers:<br>
0: M Audio Delta 1010<br>
<br>
Note! The actual /dev/dsp# numbers may be different on your system. Check the <br>
      right ones by looking at the output procuced by "cat /dev/sndstat"<br>
	  command.<br>
<br>
With the above configuration you can use /dev/dsp0 to /dev/dsp4 for playback of<br>
stereo streams (if you play mono files the signal will be output only from<br>
the left channel). /dev/dsp0 to /dev/dsp3 are connected to the analog outputs<br>
while /dev/dsp4 is the S/PDIF output.<br>
<br>
The /dev/dsp5 to /dev/dsp10 device files can be used for<br>
recording).  /dev/dsp5 to /dev/dsp8 are the analog inputs.<br>
<br>
/dev/dsp11 and /dev/dsp12 are "raw" input/output device files. They will be <br>
described in detail in the "Raw I/O devices" section below.<br>
<br>
It's also possible to make OSS to create individual device files for every<br>
channel (this creates twice as many device files than the default setting). To<br>
do this just append envy24_skipdevs=1 to the options.cfg file. This is usefull<br>
(only) if you are working on mono rather than stereo signals. However please<br>
note that setting envy24_skipdevs=1 does _NOT_ lock the device files to one<br>
channel mode (the application can still set them to stereo or multi channel<br>
mode if it likes).<br>
<br>
It is possible to set all device files to mono only mode by setting<br>
envy24_skipdevs=1 and envy24_force_mono=1. However this mode disables<br>
stereo and multi channel usage for all devices so in general it should not<br>
be used.<br>
<br>
By default the driver will create output devices before the input ones. By<br>
setting envy24_swapdevs=1 in options.cfg you can ask OSS to create the device<br>
files in opposite order (input device files before the output ones). This may<br>
be usefull when using RealProducer.<br>
<br>
As a workaround to a bug in RealProducer you also need to create some dummy<br>
mixer devices by defining envy24_realencoder_hack=1 in options.cfg. Without<br>
these extra mixer devices RealProducer will not be able to access other than<br>
the first input device.<br>
<br>
Using the driver<br>
----------------<br>
<br>
If possible make your application to open the right device file (/dev/dsp0 to<br>
/dev/dsp10) explicitly. It's also possible to use the default devicefile<br>
(/dev/dsp) since OSS now supports automatic device allocation (it opens the<br>
first available input or output devicefile depending on the open mode).<br>
<br>
The channel allocation mechanism between device files is very flexible. Even<br>
there is a device file for every stereo pair (or a mono channel) it's possible<br>
to use any of the device file to access multiple channels. For example an<br>
application can open /dev/dsp0 and set the number of channels to 10. In this<br>
way the application can play all 10 channels (or any number between 1 and 10)<br>
simultaneously (the samples will be interleaved).<br>
<br>
There is simple automatic syncstart feature when using multiple applications at<br>
the same time. Playback will not start before all currently open devices files<br>
have started the playback operation. The same mechanism works for recording<br>
(recording and playback operations are fully independent).<br>
<br>
The Envy24 driver supports 8, 16 and 24/32 bit sample formats.<br>
<br>
Selecting the sampling rate<br>
---------------------------<br>
<br>
Envy24 based cards are multi channel devices and all the channels share the same sampling<br>
rate. For this reason the sampling rate is normally locked to the value selected using<br>
ossmix. However OSS supports some other methods for changing the sampling rate.<br>
There are four ways to change the sampling rate.<br>
<br>
A) Basic method<br>
<br>
Since all input and output channels of Envy24 work at the same sampling rate<br>
it's not possible for the applications to select the rate themselves. Instead<br>
the sampling rate is always locked to the currently selected rate. This rate<br>
selection can be changed using the ossmix program shipped with OSS.<br>
<br>
For example:<br>
<br>
	ossmix envy24.rate 48000<br>
<br>
sets the sampling rate to 48000 Hz (default). The possible alternatives are:<br>
8000, 9600, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000, <br>
88200 and96000. When using S/PDIF inputs/outputs only the sampling rates 32000,<br>
44100, 48000, 88200 or 96000  should be used.<br>
<br>
B) External sync<br>
<br>
It's possible to lock the sampling rate to the S/PDIF or world clock inputs<br>
by setting the envy24.sync setting in ossmix to SPDIF or WCLOCK. However <br>
the envy24.rate setting should be set manually to match the rate being used<br>
(there is no autodetection for that).<br>
<br>
C) Nonlocked method<br>
<br>
It's also possible to turn the envy24.ratelock setting to OFF using ossmix.<br>
After that the first application that opens the device can change the sampling <br>
rate. However great care should be taken that this application gets the<br>
recording/playback process fully started before any of the other<br>
applications open their devices. Otherwise all devices will be locked to 8Khz.<br>
Also keep in mind that subsequent applications will be forced to use the<br>
sampling rate set by the first one. <br>
<br>
D) Software SRC (sample rate conversion)<br>
<br>
OSS now contains a very high quality software based sample rate converter.<br>
It can be enabled by setting envy24.src to ON using ossmix (this feature<br>
requires the MIX option in the OSS license).<br>
After that OSS can do on-fly sample rate conversions between the actual<br>
"hardware" sampling rate and the sampling rates used by the applications. In<br>
this way every application may use different sampling rate. However there are<br>
some drawbacks in this method:<br>
- The hardware rate needs to be 44100, 48000 or 96000 Hz.<br>
- The software SRC algorithm consumes some CPU time (1% to 20% per audio<br>
  channel depending on the CPU speed and sampling rates). For this reason this<br>
  method may be useless in multi channel use with anything else but the<br>
  fastest high end CPUs.<br>
- Only mono and stereo (1 or 2 channel) streams are supported.<br>
- The SRC algorithm does cause minor artifacts to the sound (SNR is around 60<br>
  dB). <br>
<br>
Raw I/O devices<br>
---------------<br>
<br>
Support for raw I/O device files is a new feature included in OSS 2.9.5g or<br>
later. These device files provide an alternative way to access Envy24 based <br>
devices. With these devices it's possible to bypass the dual buffering <br>
required by the "normal" input/output device files described above. This means <br>
that also the mmap() feature is available and that the latencies caused by<br>
dual buffering are gone. So these device files work much like "ordinary"<br>
soundcards. However due to multi channel professional nature of the Envy24<br>
chip there are some very fundamental differences. This means that these<br>
device files can only be used with applications that are aware of them.<br>
<br>
The differences from normal audio device files are:<br>
<br>
1) The sample format will always be 32 bit msb aligned (AFMT_S32_LE). Trying<br>
   to use any other sample format will cause unexpected results.<br>
2) Number of channels is fixed and cannot be changed. The output device <br>
   has always 10 channels (0 to 7 are analog outputs and 8 to 9 are the<br>
   digital outputs). This assignment will be used even with cards that don't<br>
   support digital (or analog) outputs at all. If the actual hardware being<br>
   used hass less channels the unused ones will be discarded (however they will<br>
   be fed to the on board monitor mixer).<br>
   The input device is fixed to 12 channels. Channels 0 to 7 are analog inputs.<br>
   Channels 8 to 9 are digital inputs. Channels 10 and 11 are for the result<br>
   signal from the on board monitor mixer.<br>
<br>
Digital monitor mixer<br>
---------------------<br>
<br>
All Envy24 based cards have a built in monitor mixer. It can be used to mix all input<br>
and output signals together. The result can be recorded from the "input from mon. mixer"<br>
device (device 10 in the /dev/sndstat example above).<br>
<br>
The monitor mix signal can also be routed to any of the outputs (including S/PDIF and<br>
the "consumer" AC97 output of Terratec EWS88MT/D and any other card that supports it).<br>
<br>
The settings in the gain.* group of ossmix are used to change the levels of all<br>
inputs and outputs in the digital monitor mixer. The possible values are<br>
between 0 (minimum) and 144 (maximum).<br>
<br>
OSS permits using all 10 possible output channels of the monitor mixer even<br>
with cards that have less physical outputs. These "virtual" outputs are only <br>
sent to the monitor mixer and their signal is only present in the monitor<br>
mixer output. To enable these "virtual" channels set the envy24_virtualout<br>
parameter to 1 in options.cfg. This option has no effect with Delta1010, EWS88MT and<br>
other cards that have 10 "real" outputs.<br>
<br>
Selecting the sync source<br>
-------------------------<br>
<br>
On cards with S/PDIF and/or World Clock inputs it's possible to select the<br>
sync source using <br>
	<br>
	ossmix envy24.sync<br>
<br>
The possible choices are:<br>
<br>
    INTERNAL    Use the internal sampling rate as defined by envy24.rate<br>
    SPDIF       Use the S/PDIF input as the clock source. The envy24.rate<br>
                setting must be set manually to match the actual input<br>
                sampling rate.<br>
    WCLOCK      Like SPDIF but uses the world clock input signal<br>
                (Delta 1010 only).<br>
<br>
Changing the input and output gains<br>
-----------------------------------<br>
<br>
OSS permits changing the input and output gains for the analog ports on certain<br>
cards. Exact details depend on the soundcard being used. Use the ossmix command<br>
to show a list of the known controls and look at the gain.* settings.<br>
<br>
With some devices it's possible to change the gain controllers to be<br>
continuous sliders instead of just enumerated ones. This can be done by <br>
defining envy24_gain_sliders=1 in options.cfg.<br>
<br>
Output routings<br>
---------------<br>
<br>
Output routing of output ports can be changed by changing the route.* settings<br>
using ossmix. The possible choices are:<br>
<br>
    DMA                  - Playback from the associated /dev/dsp# device.<br>
<br>
    MONITOR              - Output of the digital mixer (ounly out1/2 and S/PDIF.<br>
<br>
    IN1/2 to IN9/10 or<br>
    IN1 to IN10          - Loopback from the analog inputs<br>
<br>
    SPDIFL or<br>
    SPDIFR or<br>
    SPDIF                - Loopback from the S/PDIF input.<br>
<br>
Peak meters<br>
-----------<br>
<br>
Envy24 based cards have peak meters for the input and output ports of the<br>
digital monitor mixer. ossmix can show these values under the peak.* group<br>
(these settings are read only). The values are between 0 (minimum) and 255<br>
(maximum). At this moment the only applications that supports these peak meters are<br>
ossmix and ossxmix (a GTK+ based application that is available from 4Front Technologies).<br>
<br>
About IDE disks/CD-drives and dropouts<br>
--------------------------------------<br>
<br>
IDE disk and CD-ROM drives may cause some interrupt latency problems which <br>
may cause dropouts in recording/playback with Envy24 based cards.<br>
<br>
When using the Envy24 driver together with IDE disks or CD-ROMs under Linux<br>
it's highly recommended to enable 32 bit I/O mode and/or DMA. This can be done<br>
with the hdparms command:<br>
<br>
	hdparm -d1 -c1 /dev/hd[abcd]<br>
<br>
In some cases above is not enough. You may try some additional options. However<br>
make sure you understand what you do.<br>
<br>
	hdparm -m16 -u1 -c3 -d1 /dev/hd[abcd]  <br>
<br>
This increases the system performance significantly.<br>
<br>
Another method to solve the dropout problems is making the fragment size used<br>
by the driver longer. This can be done by adding envy24_nfrags=N to the<br>
options.cfg file. By default N is 16. Values 2, 4 or 8 make the fragments<br>
longer which should cure the dropout problems. However this may cause <br>
latency problems with some applications. Values 32 and 64 decrease the <br>
latencies but may cause dropouts with IDE.<br>
<br>
Third method that helps in dropout problems is installing Andrew Morton's<br>
low latency patches for Linux (2.4.x kernels). They are available from:<br>
<br>
http://www.zip.com.au/~akpm/linux/schedlat.html<br>
</body></html>

--Boundary-00=_ZNxlEe/D0VBS8cE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_ZNxlEe/D0VBS8cE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_ZNxlEe/D0VBS8cE--
