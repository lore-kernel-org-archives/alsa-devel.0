From: Manuel Jander <mjander@embedded.cl>
Subject: mpu401_uart patch
Date: Fri, 14 Mar 2003 00:58:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E716160.8080503@embedded.cl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040408090800060203070300"
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

This is a multi-part message in MIME format.
--------------040408090800060203070300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,


I prepared a patch for the mpu401_uart driver, with proposed changes.
The fundamental "higlights":

-No API change needed. snd_mpu_uart401_new() can be maintained as is.
Drivers that use some other means of io, just overwrite mpu->write and 
mpu->read after calling snd_mpu_uart401_new() with driver specific code, 
just as the command port offset is handled. This lets keep Hardware 
dependent and hardware indepedent code separated.

-Build in support for PORT I/O (default) and MMIO (MPU401_HW_MMIO).

I would like to know your thoughts, if you accept it, reject it, or want
to send it to hell, etc :-)

Best Regards

Manuel Jander.

--------------040408090800060203070300
Content-Type: application/octet-stream;
 name="patch-mpu401.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch-mpu401.bz2"

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
--------------040408090800060203070300--



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
