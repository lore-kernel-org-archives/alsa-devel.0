From: "freeman.liu" <freeman.liu@sun.com>
Subject: Re: A bug in intel8x0.c
Date: Sat, 17 Jan 2004 09:47:54 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4008944A.8050209@sun.com>
References: <Pine.HPX.4.33n.0401161308300.25394-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0401161308300.25394-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

>freeman.liu wrote:
>  
>
>>At the end of the function snd_intel8x0_codec_semaphore. If we
>>couldn't get the semaphore in 1 ms, we'll reset the register and
>>return EBUSY. But to reset the register, we should do a
>>iaputword ( chip, 0, 0 ), according to the datasheet, write any
>>value the this register will reset the register.
>>But in the code, what we did is iagetword ( chip, 0 ).
>>    
>>
>
>At that point, we don't want to reset the semaphore but to access a
>dummy AC'97 register so that the semaphore flag is cleared even if we
>actually got the semaphore (from the igetbyte in the printk).  (The
>iagetword/iaputword functions access AC'97 registers, not ICH
>registers.)
>
>  
>
Semaphore is clear when a writing operation is finished, and it' done 
automatically
by the hardware. I think you have misunstandard the code, the printk is 
just print
out the sema register and global-status register for debug.

Look at the comment after the iagetword. And read the ac97 specification.
Read the ac97 reset register will return the value. write any value to 
it will reset the
ac97 registers. When code run to this point there must be some error in 
the hardware,
so we need a reset.

>HTH
>Clemens
>
>
>  
>


-- 

	Best regards
	Freeman Liu




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
