From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Reading alsa midi-data inside the jack client
 process thread
Date: Fri, 8 Jul 2005 15:57:15 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507081554080.7662-100000@studcom.urz.uni-halle.de>
References: <21780.212.169.96.218.1120819000.squirrel@webmail.uio.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <21780.212.169.96.218.1120819000.squirrel@webmail.uio.no>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>
Cc: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no> wrote:
> Is this legal (ie. non-blocking)?
>
> int process (jack_nframes_t nframes, void *arg){
>   snd_seq_event_t *event;
>   if(snd_seq_event_input_pending(seq,1)){
>     snd_seq_event_input(seq, &event);
>   ....
> }

snd_seq_event_input_pending() will not block (it may call poll(), but
with a timeout of zero), and snd_seq_event_input() will not block if
snd_seq_event_input_pending() has returned a value greater than zero.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
