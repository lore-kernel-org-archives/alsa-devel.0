From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Can period_bytes_max equal to buffer_bytes_max??
Date: Mon, 20 Mar 2006 20:14:37 +0000
Message-ID: <1142885677.9244.2.camel@localhost.localdomain>
References: <715d90900603200140ua8727depac39fff084d7a621@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <715d90900603200140ua8727depac39fff084d7a621@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: boku <boku0712@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-03-20 at 17:40 +0800, boku wrote:
> Dear all,
>     While setting the xxx_pcm_hardware paramaters, what it mean and
> cause if period_bytes_max=buffer_bytes_max? Does it mean that one IRQ
> is gen after all the buffer size is transferred? 
>  

What is generating the IRQ? Does your hardware generate this? You
shouldn't expect it to appear automagically.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
