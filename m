From: "Nick French" <nick@greensignal.com>
Subject: Re: Multiple PCM files
Date: Tue, 30 Jul 2002 13:24:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <103b01c237c4$08e15ce0$360110ac@dillon>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

So does JACKs allow two separate applications to stream PCM audio at the
same time to the same device and if so will it then overlay them? If it will
why would two threads each registering with JACKs not work.

Thanks again

Nick

----- Original Message -----
From: "Paul Davis" <pbd@op.net>
To: "Nick French" <nick@greensignal.com>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Tuesday, July 30, 2002 12:29 PM
Subject: Re: [Alsa-devel] Multiple PCM files


> >Ok set the option ( you guessed it Outlook Express ) to text only. Sorry
> >don't have a go at me as it is the default setting I believe.
> >
> >Option 1 or 2 would be what I am looking at. What I have is a program
with
> >multiple threads needing to play PCM streams to the same device.
>
> there are some hardware interfaces that support "multi-open", meaning
> that several calls to snd_pcm_open() can be made to the same named
> device (e.g. "plughw:0,0"). these interfaces have a hardware mixer
> that mixes all the streams together before delivering them to the
> connectors on the back. on these devices, each thread could open the
> device, and do its own writing.
>
> there are other interfaces that have more than one PCM output
> device. for example, some have "front" and "back" devices, or "analog"
> and "spdif" devices. these are distinct PCM devices that can be
> accessed independently from each other. this is basically what you
> were using when you used /dev/dsp0 and /dev/dsp1 (assuming you had
> only one audio interface installed).
>
> however, you cannot rely on such interfaces in general - there are
> many that do not support either of these functions, and your software
> will not work if you were to use it on such hardware. this might not
> matter to you if your software is only for your own use.
>
> so, instead you need to provide your own internal mixer. your own
> threads write into buffers, and then a single thread mixes it together
> and delivers it via snd_pcm_write or its cousins and uncles.
>
> --p
>
> ps. personally, as everyone here knows, i would recommend that you use
> JACK (jackit.sf.net) and forget about the ALSA layer, but that's your
> choice. JACK doesn't make a design with multiple threads delivering
> the data any simpler, but it gets rid of all the ALSA device/hardware
> related stuff and replaces it with a very simple abstraction.
>
>
>
>
>



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
