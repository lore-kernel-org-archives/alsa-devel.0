From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: au88x0 problems with kernel 2.6.0
Date: Sun, 04 Jan 2004 02:37:30 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FF77C6A.4050903@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

The normal way I patch the 2.6.x kernel, is i download alsa-kernel from 
CVS. and then delete the ./alsa-kernel/oss dir, then just copy all the 
contents of alsa-kernel over the top of /usr/src/linux/sound
I then copy the include directory to /usr/src/linux/include/sound, and 
it all works.

I have noticed that au88x0 driver only got into the alsa-driver tree.

Should I be doing something different in order to get au88x0 drivers 
into my local kernel 2.6.x tree.

As the au88x0 drivers are not in the alsa-kernel tree, the kernel 2.6.x 
Kconfig file does not have a au88x0 entry, so it can not easily be moved 
into kernel 2.6.x.

Can someone please point me to the correct merge/patch method, or am I 
in fact highlighting a bug!

Cheers
James


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
