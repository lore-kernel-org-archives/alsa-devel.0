From: Niels Mayer <nielsmayer@gmail.com>
Subject: Re: [LAD] announcing envy24control, mudita (*) edition.
Date: Tue, 3 Aug 2010 18:36:54 -0700
Message-ID: <AANLkTikyxQGAVUj8aY7pMRKfxf1c6cUgn8b4aw2kmWY-@mail.gmail.com>
References: <AANLkTikX07nHbBsBSG04r54LEp3R+CRC9dC--aB_h2gQ@mail.gmail.com>
	<201007282012.39291.termtech@rogers.com>
	<201007282110.33065.termtech@rogers.com>
	<201007311506.56614.termtech@rogers.com>
	<AANLkTik61RwcMtZQ6VsD7JHtvdC9F=N2kgjiS9JoMiV9@mail.gmail.com>
	<20100801225410.GF4060@zita2>
	<AANLkTi=e_uy_44wmn=zK5Nd=W28wu0M3NocLR7nO+=B0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 34D672440E
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 03:36:56 +0200 (CEST)
Received: by vws20 with SMTP id 20so4073130vws.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 18:36:55 -0700 (PDT)
In-Reply-To: <AANLkTi=e_uy_44wmn=zK5Nd=W28wu0M3NocLR7nO+=B0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-audio-dev@lists.linuxaudio.org, alsa-devel@alsa-project.org
Cc: Ralf Mardorf <ralf.mardorf@alice-dsl.net>, fons@kokkinizita.net
List-Id: alsa-devel@alsa-project.org

FYI, I added the following since
http://nielsmayer.com/envy24control/mudita24-1.0.1.tar.gz
... shall I release a 1.0.2 with the following additions (?):

   * fixed --card and --device to allow valid ALSA names and numbers
        ( https://bugzilla.redhat.com/show_bug.cgi?id=602900 ).
  * Add display of "Delta IEC958 Input Status" under "Hardware Settings."
  * Updated and corrected manual page and README

Before I release, I'd like to know what happens on cards that don't
have this feature, or if it's universally supported, but badly named.
Can those with a Terratec or other card test the following command and
let me know the results of command "amixer -c M66 cget
iface=MIXER,name='Delta IEC958 Input Status'"
e.g.:

>> amixer -c M66 cget iface=MIXER,name='Delta IEC958 Input Status'
>> numid=50,iface=MIXER,name='Delta IEC958 Input Status'
>>  ; type=BOOLEAN,access=r-------,values=1
>>  : values=on

.................................................................................................

Also, in case anybody ever wondered what this one, under "Analog
Volume" is for: "Volume Control Rate Register" I added it to the
README:

.........................

Notes on the Envy24's hardware Digital Mixer and hardware Metering,
by Niels Mayer ( http://nielsmayer.com ):
--------------------

The "Monitor Inputs" and "Monitor PCMs" tabs contain multiple scale widgets
grouped into L/R pairs and an associated peak-level meter. Each scale
widget represents the 24 bit attenuation value of each input to the
ice1712-based soundcard's digital mixer. This mixer is typically used for
zero-latency monitoring of "live" inputs, alongside backing sounds and
effects coming from the eight channels of PCM feeding the digital mixer.
When many inputs are "hot" simultaneously these scale-widgets attenuate the
inputs going into the digital mixer to prevent the output from clipping.
For details see http://nielsmayer.com/npm/envy24mixer-architecture.png

(from http://alsa.cybermirror.org/manuals/icensemble/envy24.pdf )

This is what the above manual says about the Envy24's digital mixer:
> 4.5.5 Multi-Track Digital Monitoring
>
> The Envy24 integrates a 36-bit resolution digital hardware mixer. The
> width of the data path is strictly to ensure that during processing of
> all the channels, under any condition, no resolution is lost. The
> dynamic range of the end user system will be limited by the range of the
> physical output devices used. In order to maintain identical gain to the
> input stream (i.e. 0dB), the resulting 24-bit is not msb-aligned to the
> 36-bit. The overflow bits correspond to the analog distortion due to
> saturation. The user would need to reduce the overall attenuation of the
> inputs to avoid clipping. Insertion of the digital mixer adds only a
> single sample cycle delay with respect to the original data. This
> extremely low latency all digital mixer provides monitoring
> functionality and can replace a traditional external analog input
> mixer. There are 20 independent audio data streams to mix and control
> the volume.

Adjustment of responsivity vs. "zipper noise" from the 1.5dB steps at
the top-range of
the digital mixer attenuators is achieved by the following control
under "Hardware Settings":

> MT3B: Volume Control Rate Register
> ...
> Volume update rate control (sampling rate, PSYNC)
> This register allows gradual change of the digital mixer volume
> setting. The value in MT3B specifies the number of samples to elapse (in
> hex) between each 1.5dB increment/decrement in volume mixer.  This gradual
> volume update continues until the setting programmed into MT38 is
> reached. The appropriate value to program may vary, but 00 or 01h are good
> choices for most cases.

The peak metering data is displayed as 0 to -48dBFS in envy24control's
meters. This data is derived from the envy24's hardware peak metering:

> Peak data derived from the absolute value of 9 msb.  00h min - FFh max
> volume. Reading the register resets the meter to 00h.

This resolution of the hardware metering is descibed by Fons Adriaensen in
a mailing list discussion:

http://lists.linuxaudio.org/pipermail/linux-audio-dev/2010-August/029009.html
> [...] You have 128 steps between 0 and -6dB...
> And even at -24dB the next step is 1.3dB lower. Below that
> it gets worse radipdly. For a meter that is just supposed
> to keep a check on peak levels it's OK.

Note that hardware metering data is also available from the command-line:

> amixer -c M66 cget iface=PCM,name='Multi Track Peak',numid=45
> numid=45,iface=PCM,name='Multi Track Peak'
>   ; type=INTEGER,access=r-------,values=22,min=0,max=255,step=0
>   : values=63,62,51,49,56,60,63,62,59,54,0,0,0,0,0,0,0,0,0,0,113,112

....................................................................

Niels
http://nielsmayer.com
