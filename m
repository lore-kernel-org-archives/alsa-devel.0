From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: emu10k1 sample rates?
Date: Wed, 13 Oct 2004 16:56:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410131456.i9DEu8RQ013026@www6.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: kouhia@nic.funet.fi
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

AFAIK:

>When I record from emu10k1 (e.g., from livedrive linein2)
>with sample rate 44100 Hz, then what sample rate the
>emu10k1 is running at?

48000 Hz

>I have heard that emu10k1 runs only at rate 48000 Hz. Yes or no?
Yes, only on 48000 Hz

>(1) At what rate A/D converters are running when I record at 44100 Hz?

48000 Hz

>(2) Who does the conversion to 44100 Hz?

emu10k1 - whe it writes samples to buffers

>Specially I would like to know if Alsa is doing the conversion
>with software, e.g., by boldly skipping samples.

Not as default, but on demand (when you use plughw device and hardware
doesn't support requested rate).

>If the conversion is done in emu10k1 with the rate converters
>provided by E-mu, then what quality setting is used? MS Windows
>driver provides two quality settings (the good quality and the
>best quality). Is the quality setting the emu10k1 hardware property?

I don't think this has something to do with emu10k1.
I think this is for software resamplink used in windows.
AFAIK there is no way to set conwersion quality (it is always same) in
emu10k1.

>Also, if the emu10k1 can
>be made to run at rate 11025 Hz, then that means 4x more processing
>power for frequencies less than 5000 Hz.

emu10k1 is sample locked (it runs 512 instruction per sample) and runs
only on 48000. If it can be switched to 11025 Hz, power will be still
same as on 48000, but it can't.

Audigy 2 is litle diffrent. There is another part which can run at 48,
96, 192 KHz, runs in paralel to emu10k2, but there is not DSP and this
part is not supported under linux.

Peter Zubaj=0A____________________________________=0Ahttp://www.pobox.sk/ -=
 spolahliva a bezpecna prevadzka=0A=0A=0A


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
