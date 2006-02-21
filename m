From: William Nagel <bill@williamnagel.net>
Subject: Closing a USB device after unplugging
Date: Tue, 21 Feb 2006 16:22:06 -0500
Message-ID: <C6C2DD5C-A863-4F47-8097-3005A6E1AB45@williamnagel.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have a long-running application that needs to deal with multiple  
USB audio devices.  The ideal is of course to not unplug those  
devices without telling the application that you're going to do so,  
but real life dictates that the ideal won't always happen.   
Therefore, I want to make my application robustly handle an unplug/ 
replug without requiring a restart of the application.   
Unfortunately, once the device has been unplugged, snd_pcm_close()  
returns an "Inappropriate ioctl for device" error, but resources are  
apparently still held for the device because I don't get a new device  
event if the USB device is plugged back in until my application exits.

My question: Is there any way to safely and reliably free the device  
resources once I've detected that an unplug has occurred without  
restarting my application?

Thanks ahead of time for any help,

-Bill Nagel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
