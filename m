From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Major Bug in Alsa 0.9  for over 1 year
Date: Sat, 30 Nov 2002 14:36:36 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE83244.7080907@superbug.demon.co.uk>
References: <22050.1035518578@www52.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <22050.1035518578@www52.gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: kreuzritter2000@gmx.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

kreuzritter2000@gmx.de wrote:

 >Hello,
 >
 >I allways have the same bug when trying to modprobe the cs4232 or cs4236
 >sounddriver for my Terratec EWS654XL soundcard.
 >
 >The bug is called unresolved symbol, this bug exists in ALSA 0.9 since the
 >existing of ALSA 0.9.
 >
 >I tried nearly every ALSA 0.9x version.
 >
 >
 >
This "bug" is mostly causes by in-correct install of alsa.
In order to install alsa, you must first compile and install your own
kernel.
Once the kernel is installed and running, you can then compile and
install alsa-driver.
Once you have alsa-driver installed, with all the modules, you can then
compile and install alsa-lib.
Also, the kernel must be compiled with the same compiler as the 
alsa-driver modules. E.g. You cannot have compiled the kernel with gcc 
2.95 and compile alsa-driver with gcc 3.2. Using different compilers 
causes all sorts of strange un-predictable problems. I took a few days 
once tried to track down a kernel oops, only to find that simply 
compiling both kernel and kernel-module with the same compiler fixed the 
issue.
That should solve all "unresolved symbols".

Cheers
James





-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
