From: "Nick French" <nick@greensignal.com>
Subject: Re: Multiple PCM files
Date: Tue, 30 Jul 2002 11:43:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <102101c237b5$e41f25d0$360110ac@dillon>
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

Ok set the option ( you guessed it Outlook Express ) to text only. Sorry
don't have a go at me as it is the default setting I believe.

Option 1 or 2 would be what I am looking at. What I have is a program with
multiple threads needing to play PCM streams to the same device.

Thanks and sorry for the HTML.

Cheers

Nick

----- Original Message -----
From: "Paul Davis" <pbd@op.net>
To: "Nick French" <nick@greensignal.com>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Tuesday, July 30, 2002 11:11 AM
Subject: Re: [Alsa-devel] Multiple PCM files


> >Sorry I am new to ALSA so forgive me if this is obvious.
>
> don't be sorry about that. instead, be sorry for this: whether you
> know it or not, the email program you are using is sending out copies
> of your mail in both plain text and HTML formats. increasingly on the
> net, there are filters being put in place that silently dump
> HTML-formatted email. some mailing lists will not ever accept such
> posts. as long as you do this, you are (1) wasting network bandwidth
> by sending messages that are typically more than twice as long as they
> could be (2) making it harder for people using traditional email
> readers to read them (3) risking the chance that people will never see
> your mail because its filtered before reaching their email inbox.
>
> >Is there any way with ALSA to play multiple PCM files at the same time. =
> >Say for example under OSS open DSP0 and DSP1. I thought I read that it =
> >could but have only found samples for playing a single PCM stream. Any =
> >pointers gratefully appreciated.
>
> Your question isn't very well defined. There are several things you
> might be thinking of:
>
> 1) a single process playing multiple audio files to a single audio
>    interface
> 2) multiple processes playing multiple audio files to a single audio
>    interface
> 3) multiple processes playing multiple audio files to multiple audio
>    interfaces
> 4) a single process playing multiple audio files to multiple audio
>    interfaces
>
> tell us which one it is, and we can provide more specific help. the
> use of /dev/dsp0 and /dev/dsp1 under OSS corresponds to either 3 or 4
> in the list above, but its not clear which.
>
> --p
>



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
