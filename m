From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: [Solved] Re: CMIPCI @ Asus A7M266-D bug...
Date: Tue, 26 Feb 2002 19:05:10 +0100 (CET)
Message-ID: <Pine.LNX.4.44.0202261848160.21281-100000@yme.mo.himolde.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
In-Reply-To: <s5hlmdgkv3z.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Feb 2002, Takashi Iwai wrote:
>At Tue, 26 Feb 2002 17:55:36 +0100 (CET),
>Erik Inge Bolsø wrote:
>> On my new PC, there's a cmipci chip built-in to the mainboard. It's noisy,
>> but that's as expected.
>>
>> But there's a weird issue with it. I can play 16bit stereo 44.1khz sound
>> just fine. 22 khz, though, is inaudible. In fact, everything but 44khz
>> stereo 16bit gives me either white noise or inaudibility.
>
>comparison between registers on two states gives only the difference
>of regisister 0x05..  that is quite normal.
>sorry, i have no idea...
>
>well, could you run once arecord with 22kHz and then try aplay with
>22kHz again?
>
>also, doesn't 48khz playback work, too?

Aha!

By accident, the "Exchange DAC" mixer switch was on. Turning that off, all
works as expected...

Or rather... by experimentation, I've determined this:

"Exchange DAC" switch on, "IEC958 In Monitor" switch on:
	22050 Hz silent, 44100 Hz fine

"Exchange DAC" switch on, "IEC958 In Monitor" switch off:
	22050 Hz silent, 44100 Hz silent

"Exchange DAC" switch off, "IEC958 In Monitor" switch on:
	22050 Hz fine, 44100 Hz fine

"Exchange DAC" switch off, "IEC958 In Monitor" switch off:
	22050 Hz fine, 44100 Hz silent

Just extremely weird signal routing on this one card, or is this common?
Please document this somewhere for others :)

( Perhaps match by subsystem id and modify mixer element names
accordingly to something sane? And/or mark all switches that have
something to do with signal routing as such, and let a specialized mixer
app take care of such things? )

--
Erik I. Bolsø | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
