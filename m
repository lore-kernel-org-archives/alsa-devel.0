From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Please, send ./configure output to
	<alsa-devel@alsa-project.org>
Date: Fri, 11 Mar 2005 15:01:42 -0500
Message-ID: <1110571302.19093.2.camel@mindpipe>
References: <000001c5266b$1368ab30$6401a8c0@rkh>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 470BB1E3
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2005 21:01:44 +0100 (MET)
In-Reply-To: <000001c5266b$1368ab30$6401a8c0@rkh>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: RKHenry <robert.henry@earthlink.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-03-11 at 13:49 -0500, RKHenry wrote:
> checking for GCC version... Kernel compiler: gcc egcs-2.91.66
> 19990314/Linux (egcs-1.1.2 release) Used compiler: 2.96
> 
> Fatal error: Compiler type does not match
> 
> Decoded kernel compiler: type=egcs version=2.91.66
> 
> Decoded used compiler: type=gcc version=2.96

There's your problem.  You are trying to compile the ALSA modules with
gcc 2.96, while your kernel was compiled with egcs 2.91.66.

Wow, this looks like an old system.  Red Hat 6.x?

Anyway, you have to use the same compiler to compile ALSA and the
kernel.  Either install egcs-2.91.66 and build ALSA with it, or
recompile the kernel with gcc 2.96.

Lee 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
