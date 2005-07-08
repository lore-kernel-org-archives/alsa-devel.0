From: "Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>" <k.s.matheussen@notam02.no>
Subject: Reading alsa midi-data inside the jack client process thread
Date: Fri, 8 Jul 2005 12:36:40 +0200 (CEST)
Message-ID: <21780.212.169.96.218.1120819000.squirrel@webmail.uio.no>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Is this legal (ie. non-blocking)?

int process (jack_nframes_t nframes, void *arg){
  snd_seq_event_t *event;
  if(snd_seq_event_input_pending(seq,1)){
    snd_seq_event_input(seq, &event);
  ....
}





-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happen=
ing
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by H=
P,=20
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
