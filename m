From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Problems with snd_pcm_wait() Incorrect return values.
Date: Wed, 16 Jul 2003 19:33:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F159A95.3060507@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I cannot ever seem to get a return value of 1.
I always get return values of 0, regardless of the timeout value.
Can anyone help me?

Cheers
James



Extract from documentation: -
  int snd_pcm_wait  	(   	snd_pcm_t *  	 pcm,
		
		int 	timeout
	)  	
   	

Wait for a PCM to become ready.

Parameters:
     pcm  	PCM handle
     timeout  	maximum time in milliseconds to wait

Returns:
     a positive value on success otherwise a negative error code

Return values:
     0  	timeout occurred
     1  	PCM stream is ready for I/O

Examples:
     /test/latency.c, and /test/pcm.c.



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
