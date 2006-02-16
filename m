From: "Hank Ivy" <hankivy@hot.rr.com>
Subject: probe_mpu401 question
Date: Thu, 16 Feb 2006 16:43:26 -0600
Message-ID: <000c01c6334a$6a916db0$6401a8c0@XP1>
References: <20060215122901.97C6412A21@sc8-sf-spam2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20060215122901.97C6412A21@sc8-sf-spam2.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org

The following is definitely a sound related question.  But the code is
in an oss directory.  Should I address this question to a Linux kernel
mailing list?

In the Linux source distribution, the file sound/oss/mpu401.c defines a
function called probe_mpu401.  The prototype is 
int probe_mpu401(struct address_info *hw_config, struct resource *ports)

The second parameter, ports, is not used in the function.  Have I
misread the code?

Regards, Hank Ivy





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
