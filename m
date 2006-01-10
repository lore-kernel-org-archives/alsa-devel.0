From: Daniel Mack <daniel@caiaq.de>
Subject: (no subject)
Date: Tue, 10 Jan 2006 14:24:52 +0100
Message-ID: <5C7B81E1-2824-427D-A874-A2504CE695EA@caiaq.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Dear ALSA people,

I'm about to write an ALSA driver for a sound hardware we developed
and I'm wondering about how to tackle it. It's a USB2.0 hardware
which has sound input and output but also some controller elements
and MIDI jacks. I'd like to make the controllers accessible by linux'
input device interface.

The audio part is - for good reasons - not USB class compliant,
and assuming that the usb folder in the driver tree only addresses
such devices, I pretty much guess this is not the point to start,
right?

I'm asking since I don't want to do the whole thing twice
because I started it the wrong way around.

Could anyone point me in the right direction?

Please Cc: me personally in replies since I'm not (yet) subscribed
to the list.

Best regards,
Daniel



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
