From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Trying to get alsa-driver to build on a 2.6.x kernel.
Date: Fri, 30 Jan 2004 15:50:41 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <401A7D51.9020307@superbug.demon.co.uk>
References: <401963AC.8080603@superbug.demon.co.uk>	<s5hekthsnlx.wl@alsa2.suse.de>	<401A6488.9060108@superbug.demon.co.uk>	<s5h7jz9sewo.wl@alsa2.suse.de>	<401A6E54.5010605@superbug.demon.co.uk> <s5h4qudscmd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qudscmd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 30 Jan 2004 14:46:44 +0000,
> James Courtier-Dutton wrote:
> 
>>configure:2962: gcc -o conftest -g -O2 -I/lib/modules/2.6.2-rc2/build/include -I$(CONFIG_SND_KERNELDIR)/include/asm-i386/mach-default   conftest.c  1>&5
> 
> 
> doh...  my bad.
> try the attached additional patch.
> 
> 
> Takashi

That has done it.
I have now managed to install alsa-driver into my 2.6.2 kernel.

Thank you

James


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
