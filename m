From: Karim Yaghmour <karim@opersys.com>
Subject: USB Audio problems
Date: Wed, 19 Nov 2003 14:28:33 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBBC461.1020006@opersys.com>
Reply-To: karim@opersys.com
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


I've been trying to fix some problems I'm getting with the USB audio
driver.

Basically, I get these types of messages over and over accompanied
by some audio glitches:
ALSA usbaudio.c:688: cannot submit datapipe for urb 0, err = -6
usb-uhci.c: ENXIO 00038200, flags 2, urb cf74f5c0, burb cf74f5c0

I've been able to reproduce this problem on quite a few different
systems, including different architectures. The problems seem to
occur much more often on slower machines than on faster machines.
Basically, I've been able to identify that this is due to the
Linux USB layer checking whether the urb->hcpriv field being NULL
in the *_submit_urb() code and returning -EINVAL if it's not. In
other words, the URBs used by the USB audio driver are reused
prior to being cosumed.

I've instrumented the usbaudio driver using the Linux Trace Toolkit
to get some info about the behavior of start_urbs() and
snd_complete_urb(). I've also added a trace point at the same place
where the printk for "cannot submit datapipe for ubr" is called.
Here's what I get (note where "Abusing URB" is happening):

Event creation         4,867,640,107     N/A     391     NEW EVENT TYPE : Start URB; CUSTOM EVENT ID : 24
Event creation         4,867,640,138     N/A     391     NEW EVENT TYPE : Complete URB; CUSTOM EVENT ID : 25
Event creation         4,867,640,260     N/A     391     NEW EVENT TYPE : Abuse URB; CUSTOM EVENT ID : 26
Start URB              4,869,110,362     90     33     Sending URB 0
Start URB              4,869,110,606     90     33     Sending URB 1
Start URB              4,869,110,728     90     33     Sending URB 2
Start URB              4,869,110,850     90     33     Sending URB 3
Start URB              4,869,110,972     90     33     Sending URB 4
Complete URB           4,869,124,063     0     36     Completing URB 0
Complete URB           4,869,128,000     0     36     Completing URB 1
Complete URB           4,869,132,058     0     36     Completing URB 2
Complete URB           4,869,135,995     0     36     Completing URB 3
Complete URB           4,869,140,023     0     36     Completing URB 4
Complete URB           4,869,144,051     0     36     Completing URB 0
Complete URB           4,869,147,987     0     36     Completing URB 1
Complete URB           4,869,152,015     0     36     Completing URB 2
Complete URB           4,869,156,043     0     36     Completing URB 3
Complete URB           4,869,160,010     0     36     Completing URB 4
Complete URB           4,869,164,038     0     36     Completing URB 0
Complete URB           4,869,168,066     0     36     Completing URB 1
Complete URB           4,869,172,003     0     36     Completing URB 2
Complete URB           4,869,176,031     0     36     Completing URB 3
Complete URB           4,869,180,059     0     36     Completing URB 4
Complete URB           4,869,183,995     0     36     Completing URB 0
Complete URB           4,869,188,054     0     36     Completing URB 1
Complete URB           4,869,192,021     0     36     Completing URB 2
Complete URB           4,869,196,018     0     36     Completing URB 3
Complete URB           4,869,200,046     0     36     Completing URB 4
Complete URB           4,869,204,013     0     36     Completing URB 0
Complete URB           4,869,208,011     0     36     Completing URB 1
Complete URB           4,869,212,039     0     36     Completing URB 2
Complete URB           4,869,216,006     0     36     Completing URB 3
Complete URB           4,869,220,003     0     36     Completing URB 4
Complete URB           4,869,224,001     0     36     Completing URB 0
Complete URB           4,869,227,998     0     36     Completing URB 1
Complete URB           4,869,231,996     0     36     Completing URB 2
Complete URB           4,869,235,993     0     36     Completing URB 3
Complete URB           4,869,240,021     0     36     Completing URB 4
Complete URB           4,869,244,019     0     36     Completing URB 0
....
Complete URB           4,870,112,025     0     36     Completing URB 3
Complete URB           4,870,116,022     0     36     Completing URB 4
Complete URB           4,870,120,020     0     36     Completing URB 0
Complete URB           4,870,124,017     0     36     Completing URB 1
Complete URB           4,870,128,015     0     36     Completing URB 2
Complete URB           4,870,132,043     0     36     Completing URB 3
Complete URB           4,870,136,040     0     36     Completing URB 4
Complete URB           4,870,140,038     0     36     Completing URB 0
Complete URB           4,870,144,035     0     36     Completing URB 1
Start URB              4,870,145,378     90     33     Sending URB 0
Start URB              4,870,145,531     90     33     Sending URB 1
Start URB              4,870,145,653     90     33     Sending URB 2
Start URB              4,870,145,744     90     33     Sending URB 3
Start URB              4,870,145,866     90     33     Sending URB 4
Complete URB           4,870,148,063     0     36     Completing URB 2
Complete URB           4,870,152,061     0     36     Completing URB 3
Complete URB           4,870,156,058     0     36     Completing URB 4
Complete URB           4,870,159,049     0     36     Completing URB 0
Complete URB           4,870,160,056     0     36     Completing URB 0
Complete URB           4,870,163,046     0     36     Completing URB 1
Complete URB           4,870,164,053     0     36     Completing URB 1
Complete URB           4,870,167,044     0     36     Completing URB 2
Complete URB           4,870,168,020     0     36     Completing URB 2
Complete URB           4,870,171,041     0     36     Completing URB 3
...
Complete URB           4,871,171,087     0     36     Completing URB 3
Complete URB           4,871,172,063     0     36     Completing URB 0
Complete URB           4,871,175,054     0     36     Completing URB 4
Complete URB           4,871,176,061     0     36     Completing URB 1
Complete URB           4,871,179,051     0     36     Completing URB 0
Complete URB           4,871,180,089     0     36     Completing URB 2
Complete URB           4,871,180,364     0     36     Completing URB 0
Complete URB           4,871,181,127     0     36     Completing URB 1
Complete URB           4,871,182,103     0     36     Completing URB 3
Complete URB           4,871,183,079     0     36     Completing URB 1
Complete URB           4,871,183,202     0     36     Completing URB 4
Start URB              4,871,184,300     90     33     Sending URB 0
Start URB              4,871,184,483     90     33     Sending URB 1
Start URB              4,871,184,605     90     33     Sending URB 2
Start URB              4,871,184,697     90     33     Sending URB 3
Start URB              4,871,184,819     90     33     Sending URB 4
Start URB              4,871,186,833     90     33     Sending URB 0
Start URB              4,871,186,985     90     33     Sending URB 1
Start URB              4,871,187,138     90     33     Sending URB 2
Abuse URB              4,871,187,169     90     33     Abusing URB 2
Complete URB           4,871,204,410     90     36     Completing URB 2
Complete URB           4,871,205,173     0     36     Completing URB 3
Complete URB           4,871,205,295     0     36     Completing URB 4
Complete URB           4,871,205,447     0     36     Completing URB 0
Complete URB           4,871,205,722     0     36     Completing URB 0
Complete URB           4,871,205,935     0     36     Completing URB 1
Complete URB           4,871,206,180     0     36     Completing URB 1
Complete URB           4,871,207,095     90     36     Completing URB 2
Start URB              4,871,207,736     90     33     Sending URB 0
Start URB              4,871,207,858     90     33     Sending URB 1
Start URB              4,871,207,949     90     33     Sending URB 2
Start URB              4,871,208,071     90     33     Sending URB 3
Start URB              4,871,208,194     90     33     Sending URB 4
Complete URB           4,871,210,116     0     36     Completing URB 3
Complete URB           4,871,214,083     0     36     Completing URB 4
Complete URB           4,871,218,111     0     36     Completing URB 0
Complete URB           4,871,221,071     0     36     Completing URB 0
Complete URB           4,871,222,078     0     36     Completing URB 1
Complete URB           4,871,225,068     0     36     Completing URB 1
Complete URB           4,871,226,075     0     36     Completing URB 2
Complete URB           4,871,229,066     0     36     Completing URB 2
Complete URB           4,871,230,073     0     36     Completing URB 3
Complete URB           4,871,233,063     0     36     Completing URB 3
Complete URB           4,871,234,070     0     36     Completing URB 4
Complete URB           4,871,237,061     0     36     Completing URB 4
Complete URB           4,871,238,068     0     36     Completing URB 0
Complete URB           4,871,241,058     0     36     Completing URB 0
...
Complete URB           4,871,716,089     0     36     Completing URB 0
Complete URB           4,871,717,096     0     36     Completing URB 4
Complete URB           4,871,720,087     0     36     Completing URB 1
Complete URB           4,871,721,094     0     36     Completing URB 0
Complete URB           4,871,724,084     0     36     Completing URB 2
Complete URB           4,871,725,091     0     36     Completing URB 1
Complete URB           4,871,728,082     0     36     Completing URB 3
Complete URB           4,871,729,089     0     36     Completing URB 2
Complete URB           4,871,730,187     0     36     Completing URB 2
Start URB              4,871,731,377     90     33     Sending URB 0
Abuse URB              4,871,731,408     90     33     Abusing URB 0
Complete URB           4,871,748,741     90     36     Completing URB 4
Start URB              4,871,749,015     90     33     Sending URB 0
Abuse URB              4,871,749,046     90     33     Abusing URB 0
Complete URB           4,871,766,439     90     36     Completing URB 3
Complete URB           4,871,766,561     90     36     Completing URB 0
Complete URB           4,871,766,684     90     36     Completing URB 4
Complete URB           4,871,766,806     90     36     Completing URB 1
Complete URB           4,871,766,928     90     36     Completing URB 0
Complete URB           4,871,767,019     90     36     Completing URB 1
Complete URB           4,871,767,141     90     36     Completing URB 3
Start URB              4,871,767,294     90     33     Sending URB 0
Start URB              4,871,767,538     90     33     Sending URB 1
Start URB              4,871,767,629     90     33     Sending URB 2
Start URB              4,871,767,752     90     33     Sending URB 3
Start URB              4,871,767,843     90     33     Sending URB 4
Start URB              4,871,769,766     90     33     Sending URB 0
Start URB              4,871,769,918     90     33     Sending URB 1
Start URB              4,871,770,040     90     33     Sending URB 2
Start URB              4,871,770,162     90     33     Sending URB 3
Start URB              4,871,770,254     90     33     Sending URB 4
Complete URB           4,871,772,176     0     36     Completing URB 1
Complete URB           4,871,773,122     0     36     Completing URB 2
Complete URB           4,871,774,099     0     36     Completing URB 3
Complete URB           4,871,775,106     0     36     Completing URB 4
Start URB              4,871,775,899     90     33     Sending URB 0
Abuse URB              4,871,775,960     90     33     Abusing URB 0
Start URB              4,871,793,323     90     33     Sending URB 0
Abuse URB              4,871,793,384     90     33     Abusing URB 0
Complete URB           4,871,810,800     90     36     Completing URB 0
Complete URB           4,871,811,257     90     36     Completing URB 0
Complete URB           4,871,811,379     90     36     Completing URB 1
Complete URB           4,871,811,654     90     36     Completing URB 2
Complete URB           4,871,811,898     90     36     Completing URB 3
Complete URB           4,871,813,128     90     36     Completing URB 4
Start URB              4,871,819,109     90     33     Sending URB 0
Start URB              4,871,819,292     90     33     Sending URB 1
Start URB              4,871,819,414     90     33     Sending URB 2
Start URB              4,871,819,505     90     33     Sending URB 3
Start URB              4,871,819,627     90     33     Sending URB 4
Complete URB           4,871,824,113     0     36     Completing URB 0
Complete URB           4,871,828,080     0     36     Completing URB 1
Complete URB           4,871,832,078     0     36     Completing URB 2
Complete URB           4,871,833,085     0     36     Completing URB 0
Complete URB           4,871,836,075     0     36     Completing URB 3
Complete URB           4,871,837,082     0     36     Completing URB 1
Complete URB           4,871,840,073     0     36     Completing URB 4
Complete URB           4,871,841,080     0     36     Completing URB 2
Complete URB           4,871,844,070     0     36     Completing URB 0
...

[All the parts with "..." are events where there's only "Complete URB"
which happens.]

I'm using ALSA 0.9.6, but the problems do occur on later versiosns
still. This particular trace was collected on an ARM board.

Does anyone have any hints as to what I should be looking at.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
