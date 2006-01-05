From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: OSS emulation improvements.
Date: Thu, 05 Jan 2006 20:02:49 +0000
Message-ID: <43BD7B69.7030103@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I have be trying to think of ways to improve OSS emulation for ALSA.
Now, the ideal solution is probably a userland daemon that will create 
kernel /dev/dspX  nodes.
Any application opening/ioctl/read/write to /dev/dspX would have all 
those calls redirected to the userland daemon.
But I am not exactly sure how to achieve this.
Lets assume that we are able to get a userland daemon to creative a /dev 
node. The OSS application opens/ioctl it. This results in function calls 
to the userland daemon. The OSS application then does a write(). This 
write will then contain a pointer to the frames the OSS application 
wishes to write to the sound card. How can the daemon do a memcopy of 
those frames to it's own address space?
Next the problem with DMA. the OSS application requests are DMA buffer 
via the IOCTL. This would result is the buffer actually being in the 
userland daemon's address space. How could the OSS application get write 
access to the userland daemon'd address space?

If someone could kindly answer the questions above. I.e. explain how one 
might do it in Linux. I would be happy to implement the userland daemon 
and it would just work!

I think that if we could achieve this approach, all OSS would then work 
seamlessly, so please help me.

James



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
