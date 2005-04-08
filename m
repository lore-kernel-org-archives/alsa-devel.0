From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usage of snd_seq_queue_status_get_real_time()
Date: Fri, 8 Apr 2005 08:54:50 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504080853540.3042-100000@studcom.urz.uni-halle.de>
References: <4255D58C.9010903@pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4255D58C.9010903@pianodisc.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Steve deRosier wrote:
> const snd_seq_real_time_t * CMIDIPort::GetRealQueueTime( void )
> {
>   snd_seq_queue_status_t * qs;
>
>   snd_seq_queue_status_alloca( &qs );
>   snd_seq_get_queue_status( hSeq, mQueue, qs );
>   return snd_seq_queue_status_get_real_time( qs );
> }

This function returns a pointer to a local variable.

(And it should check for errors.)


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
