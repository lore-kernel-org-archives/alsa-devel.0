From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: au88x0 problems with kernel 2.6.0
Date: Thu, 15 Jan 2004 23:38:40 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40072480.8010702@superbug.demon.co.uk>
References: <3FF77C6A.4050903@superbug.demon.co.uk> <Pine.LNX.4.58.0401040948130.1876@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401040948130.1876@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Sun, 4 Jan 2004, James Courtier-Dutton wrote:
> 
> 
>>Hi,
>>
>>The normal way I patch the 2.6.x kernel, is i download alsa-kernel from 
>>CVS. and then delete the ./alsa-kernel/oss dir, then just copy all the 
>>contents of alsa-kernel over the top of /usr/src/linux/sound
>>I then copy the include directory to /usr/src/linux/include/sound, and 
>>it all works.
>>
>>I have noticed that au88x0 driver only got into the alsa-driver tree.
>>
>>Should I be doing something different in order to get au88x0 drivers 
>>into my local kernel 2.6.x tree.
>>
>>As the au88x0 drivers are not in the alsa-kernel tree, the kernel 2.6.x 
>>Kconfig file does not have a au88x0 entry, so it can not easily be moved 
>>into kernel 2.6.x.
>>
>>Can someone please point me to the correct merge/patch method, or am I 
>>in fact highlighting a bug!
> 
> 
> It's not a bug. All alpha/beta drivers are in the alsa-driver directory.  
> This directory doesn't allow to be merged to 2.6 code in a simply way, but
> you can compile these drivers as modules outside the kernel like for 2.4
> (simply go to the alsa-driver directory and run cvscompile there).
> 
> 						Jaroslav
> 

cvscompile or alsa-driver did not work on the 2.6 kernel. The modules 
did not load due to missing symbols, e.g. VMALLOC etc. and also a PDE 
error during configure

Cheers
James


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
