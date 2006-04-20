From: Carlos Munoz <carlos@kenati.com>
Subject: Re: buffer_bytes not multiple of period_bytes
Date: Thu, 20 Apr 2006 10:50:43 -0700
Message-ID: <4447C9F3.6040008@kenati.com>
References: <XFMail.20060420091724.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20060420091724.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini wrote:

>On 20-Apr-2006 Carlos Munoz wrote:
>  
>
>>Hi all,
>>
>>I just noticed that alsa doesn't allocate a buffer size that is a
>>multiple of the period size.
>>    
>>
>
>It's not required. If it is not a multiple, then the IRQ happens
>in different points of the ring buffer each round. On some cards
>this is hard or impossible to do. In those cases you can add this
>constraint:
>
>if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
>    return err;
>
>
>  
>
Hi Giuliano,

Yes, that solved the problem.

Thanks,


Carlos


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
