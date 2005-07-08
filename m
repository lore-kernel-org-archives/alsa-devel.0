From: "Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>" <k.s.matheussen@notam02.no>
Subject: Re: [Jackit-devel] Reading alsa midi-data inside the jack client
 process thread
Date: Fri, 8 Jul 2005 14:30:27 +0200 (CEST)
Message-ID: <26283.212.169.96.218.1120825827.squirrel@webmail.uio.no>
References: <21780.212.169.96.218.1120819000.squirrel@webmail.uio.no>
    <20050708114237.GA7127@bth05w.ABSp.alcatel.be>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050708114237.GA7127@bth05w.ABSp.alcatel.be>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alfons Adriaensen <fons.adriaensen@alcatel.be>
Cc: Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>, jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> On Fri, Jul 08, 2005 at 12:36:40PM +0200, Kjetil Svalastog Matheussen
> <k.s.matheussen@notam02.no> wrote:
>
>> Is this legal (ie. non-blocking)?
>>
>> int process (jack_nframes_t nframes, void *arg){
>>   snd_seq_event_t *event;
>>   if(snd_seq_event_input_pending(seq,1)){
>>     snd_seq_event_input(seq, &event);
>
>
> Don't have the sources at hand here, but ISTR that
> what I do in Aeolus is something like:
>
>
>   if (snd_seq_event_input_pending (seq,1))
>   {
>       do
>       {
>           snd_seq_event_input(seq, &event);
>           ...
>       }
>       while (snd_seq_event_input_pending (seq,0));
>   }
>
>

Thanks, reading your source, thats correct. (But I don't understand what
the fetch_sequencer argument for snd_seq_event_input_pending does though:
http://www.alsa-project.org/alsa-doc/alsa-lib/group___seq_event.html#a7
)

I also wonder whats the difference between your code above and this:

if (snd_seq_event_input_pending (seq,1)) {
  while(snd_seq_event_input(seq,&event);
      ....
   }
}

which I think should do the same... Guess I just have to read the source.=
 :-)





-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happen=
ing
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by H=
P,=20
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
