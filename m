From: "Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>" <k.s.matheussen@notam02.no>
Subject: Re: Reading alsa midi-data inside the jack client
     process thread
Date: Fri, 8 Jul 2005 18:26:33 +0200 (CEST)
Message-ID: <56351.212.169.96.218.1120839993.squirrel@webmail.uio.no>
References: <21780.212.169.96.218.1120819000.squirrel@webmail.uio.no>
    <20050708114237.GA7127@bth05w.ABSp.alcatel.be>
    <26283.212.169.96.218.1120825827.squirrel@webmail.uio.no>
    <20050708151102.GB7127@bth05w.ABSp.alcatel.be>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050708151102.GB7127@bth05w.ABSp.alcatel.be>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Alfons Adriaensen <fons.adriaensen@alcatel.be>
Cc: Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>, jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> On Fri, Jul 08, 2005 at 02:30:27PM +0200, Kjetil Svalastog Matheussen
> <k.s.matheussen@notam02.no> wrote:
>
>> Thanks, reading your source, thats correct. (But I don't understand wh=
at
>> the fetch_sequencer argument for snd_seq_event_input_pending does
>> though:
>>
>
> IIRC, if the second argument of snd_seq_event_input_pending () is
> 1, it will do a transfer of all available MIDI data from a system
> space buffer to user space. If it is zero, it examines only the user
> space buffer.
>
>> I also wonder whats the difference between your code above and this:
>>
>> if (snd_seq_event_input_pending (seq,1)) {
>>   while(snd_seq_event_input(seq,&event);
>>       ....
>>    }
>> }
>
> The code as in Aeolus will do one system to user space transfer only,
> while if you put your code into a loop, it will do this every time.
> The rationale for doing it only once is that
> 1. it's a system call, and probably relatively expensive,
> 2. in the short time required to handle the MIDI events arrived
> during the past period, it is unlikely that anything new will
> arrive anyway.
>
> Point 1. is why you'd probably prefer a separate thread if your
> period size could be very small (64, 32, 16). The minimum for
> Aeolus is 64 anyway, so I didn't bother. This will change in the
> next release, which will handle OSC as well.
>
>

Clemens Ladisch:
>snd_seq_event_input_pending() will not block (it may call poll(), but
>with a timeout of zero), and snd_seq_event_input() will not block if
>snd_seq_event_input_pending() has returned a value greater than zero.



Thank you both for the clear and understandable expanations. Everything i=
s
understood. Back to coding. :-)






-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happen=
ing
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by H=
P,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
