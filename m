From: Alfons Adriaensen <fons.adriaensen@alcatel.be>
Subject: Re: Reading alsa midi-data inside the jack client process thread
Date: Fri, 8 Jul 2005 13:42:37 +0200
Message-ID: <20050708114237.GA7127@bth05w.ABSp.alcatel.be>
References: <21780.212.169.96.218.1120819000.squirrel@webmail.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <jackit-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <21780.212.169.96.218.1120819000.squirrel@webmail.uio.no>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: "Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>" <k.s.matheussen@notam02.no>
Cc: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 08, 2005 at 12:36:40PM +0200, Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no> wrote:
 
> Is this legal (ie. non-blocking)?
> 
> int process (jack_nframes_t nframes, void *arg){
>   snd_seq_event_t *event;
>   if(snd_seq_event_input_pending(seq,1)){
>     snd_seq_event_input(seq, &event);


Don't have the sources at hand here, but ISTR that
what I do in Aeolus is something like:


  if (snd_seq_event_input_pending (seq,1))
  {
      do 
      { 
          snd_seq_event_input(seq, &event);
          ...
      }
      while (snd_seq_event_input_pending (seq,0));
  }


It has never blocked AFAICT. It may not be the best
method if you use very short periods - a separate
MIDI thread linked with a lock-free ringbuffer is to
be preferred in that case.


-- 
FA



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
