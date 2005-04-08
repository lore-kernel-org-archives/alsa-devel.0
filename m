From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: usage of snd_seq_queue_status_get_real_time()
Date: Fri, 08 Apr 2005 08:47:59 -0700
Message-ID: <4256A7AF.6010607@pianodisc.com>
References: <Pine.HPX.4.33n.0504080853540.3042-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0504080853540.3042-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Good point, I should check ..._get_queue_status() for an error return.  The docs don't specify any error return for ..._get_real_time() however.

I figured that it returns a pointer to a local var considering the const in the return type, but that still doesn't explain why the data never changes.

- Steve

Clemens Ladisch wrote:
> Steve deRosier wrote:
> 
>>const snd_seq_real_time_t * CMIDIPort::GetRealQueueTime( void )
>>{
>>  snd_seq_queue_status_t * qs;
>>
>>  snd_seq_queue_status_alloca( &qs );
>>  snd_seq_get_queue_status( hSeq, mQueue, qs );
>>  return snd_seq_queue_status_get_real_time( qs );
>>}
> 
> 
> This function returns a pointer to a local variable.
> 
> (And it should check for errors.)
> 
> 
> HTH
> Clemens
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
