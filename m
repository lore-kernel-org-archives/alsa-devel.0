From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: usage of snd_seq_queue_status_get_real_time()
Date: Tue, 12 Apr 2005 12:15:32 -0700
Message-ID: <425C1E54.1040705@pianodisc.com>
References: <Pine.HPX.4.33n.0504111044370.22583-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0504111044370.22583-100000@studcom.urz.uni-halle.de>
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

Ah, good point, color me dumb.  ;)  I've fixed that.  Thanks.

Note however it doesn't seem to fix the issue.  What did make it work for me was using
snd_seq_queue_status_malloc() and snd_seq_queue_status_free() instead of using the snd_seq_queue_status_alloca() macro.  Not sure why the macro didn't work for me, but the full fledged functions seem to make everything work.

My final working function (in case anyone cares):
snd_seq_real_time_t CMIDIPort::GetRealQueueTime( void )
{
  snd_seq_queue_status_t * qs;
  snd_seq_real_time_t rt;
  rt.tv_sec = 0;
  rt.tv_nsec = 0;

  if( snd_seq_queue_status_malloc( &qs ) )
    return rt;
  if( snd_seq_get_queue_status( hSeq, mQueue, qs ) == 0 )
    rt = *snd_seq_queue_status_get_real_time( qs );
  snd_seq_queue_status_free( qs );

  return rt;
}
 
An interesting note... On repeated calls, it will return the same time value for a few calls in a row.  Does the status information only get updated every so often?  Like maybe the driver only transfers a chunk at a time and so the time info in the status only gets updated each time the buffer is full or empty?

Thanks for you help,
- Steve


Clemens Ladisch wrote:
> Steve deRosier wrote:
> 
>>I figured that it returns a pointer to a local var considering the
>>const in the return type, but that still doesn't explain why the
>>data never changes.
> 
> 
> Local variables cease to exist when the function returns.  The data on
> the stack will be overwritten by the calling function (which explains
> why you see a constant, meaningless value).
> 
> You should return the snd_seq_real_time_t by value.
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
