From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: DMA strangeness?
Date: Sun, 19 Feb 2006 15:12:33 +0000
Message-ID: <1140361953.9117.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am using oss emulation to test my driver (I cannot get the alsa
utilities to work properly on my Dreamcast (SH4/uclibc) system).

When I do something like

cat foobar > /dev/dsp

it seems that the DMA buffer is filled with doubles of every byte of
foobar eg if foobar was 0xFF, 0x10 ... etc then the first four bytes of
the DMA buffer would be 0xFF 0xFF 0x10 0x10

Is there a reason for this? Obviously I've made a mistake somewhere but
I don't know where 

(driver code is at http://newgoldddream.dyndns.nfo/repos)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
