From: Ivica Ico Bukvic <ico@fuse.net>
Subject: re: More issues with hdsp and 1.0.7 and 1.0.8 drivers
Date: Thu, 13 Jan 2005 22:44:07 -0500
Message-ID: <200501132244.07541.ico@fuse.net>
Reply-To: ico@fuse.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

And yet another thing.

It seems that the memory allocation issue that plagued really old drivers is 
still not completely gone. After disconnecting and reconnecting the hdsp 
after some time (and obviously allowing the RAM to get fragmented) I get 
this:

RME Hammerfall DSP: no buffers available
RME Hammerfall DSP: probe of 0000:02:00.0 failed with error -12

I guess this has something to do with RAM being fragmented. Please correct me 
if I am wrong...

Best wishes,

Ico


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
