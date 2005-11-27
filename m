From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Where to put code for a new ioctl.
Date: Sun, 27 Nov 2005 11:10:53 +0000
Message-ID: <4389943D.20100@superbug.co.uk>
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

I am looking at alsa-lib.
./src/control/control_hw.c is there the actual ioctl call goes.
./src/control/control.c calls the routine in control_hw.c
./src/control/hcontrol.c calls the routine in control.c
./src/mixer/simple_none.c handles the call from the user app, it then 
calls ??? hcontrol.c or control.c ?

So, my question is, if I have to write code between the user apps 
request and the ioctl. The purpose of the code is to take the request 
from the user, and then encapsulate it in the ioctl specific format, and 
then call the ioctl. Do I implement this encapsulating code in control.c 
or hcontrol.c ?

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
