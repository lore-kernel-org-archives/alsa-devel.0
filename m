From: Rusty Phillips <rustyp@freeshell.org>
Subject: Re: Omnistudio USB
Date: Wed, 12 Jan 2005 12:48:47 -0500
Message-ID: <1105552128.14676.36.camel@localhost>
References: <Pine.HPX.4.33n.0501121001170.22429-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TYmo38aLMV6O7Enn28Kw"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0501121001170.22429-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-TYmo38aLMV6O7Enn28Kw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-01-12 at 10:02 +0100, Clemens Ladisch wrote:
> Rusty Phillips wrote:
> > I recently purchased one, and have been trying to find out
> > anything I can about getting it to work.  So far all I've gotten
> > is playback on two channels at 48Khz with alsa (from the 2.6.10
> > kernel as well as from alsa CVS).
> 
> What are the contents of /proc/asound/cardX/stream0?
> Is there a second output device in the output of "aplay -l"?
> 
> 
> Clemens
> 
Oh...sorry to mislead you there.  All four channels "work."  The problem
is that recording doesn't at all, and neither do higher bitrates.

First, aplay -l:
**** List of PLAYBACK Hardware Devices ****
card 0: USB [OmniStudio USB], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: USB [OmniStudio USB], device 1: USB Audio [USB Audio #1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

>From my asoundrc:
pcm.omni1 {
        type hw
        card 0
        device 0
}
ctl.omni1 {
        type hw
        card 0
}
pcm.omni2 {
        type hw
        card 0
        device 1
}
ctl.omni2 {
        type hw
        card 0
}

So I tested this with this:
arecord -D omni1 -r 48000 -t wav -v out.wav -f S24_3LE -c2
With a microphone plugged into channel 1.  The omnistudio shows signal
level varying via the LED, so I know I'm getting a signal into the
device.  However, the result I'm hearing is silence.  

Higher recording rates are even worse - I get a strange "beep" followed
by static.

Attached is /proc/asound/card0/stream0.

I've found this, which may also refer to the problem in my card (it's
about the USB Quattro)...unsure.  
http://www.music.columbia.edu/pipermail/linux-audio-user/2004-June/012737.html

Still...I should be getting some kind of signal, shouldn't I?  Thoughts?


--=-TYmo38aLMV6O7Enn28Kw
Content-Description: stream0 output
Content-Disposition: attachment; filename=out
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

M-Audio OmniStudio USB at usb-0000:00:07.2-1, full speed : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 11025, 22050, 44100
  Interface 4
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 88200, 96000
  Interface 4
    Altset 3
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 11025, 22050, 44100, 48000
  Interface 4
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 11025, 22050, 44100, 48000

Capture:
  Status: Stop
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 11025, 22050, 44100
  Interface 5
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 88200, 96000
  Interface 5
    Altset 3
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 11025, 22050, 44100, 48000
  Interface 5
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 11025, 22050, 44100, 48000

--=-TYmo38aLMV6O7Enn28Kw--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
