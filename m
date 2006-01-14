From: James Vaughn <jiv3@cornell.edu>
Subject: Echo Indigo IO returns error -2 during probe
Date: Sat, 14 Jan 2006 14:45:12 -0500
Message-ID: <43C954C8.405@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

While attempting to setup an Echo Indigo IO, something complains and
returns an error "-2".  Unfortunately, I was unable to find any
information about what this error codes means and, as such, am unable to
provide any assistance or information beyond the usual.

Current kernel is 2.6.11.11, ALSA version is 1.0.10 through gentoo
(whatever the current stable package in portage is).

specific error is:

Jan 14 14:29:13 Myrddin kernel: PCI: Enabling device 0000:03:00.0 (0000
-> 0002)
Jan 14 14:29:13 Myrddin kernel: ACPI: PCI interrupt 0000:03:00.0[A] ->
GSI 11 (level, low) -> IRQ 11
Jan 14 14:29:13 Myrddin kernel: Echoaudio Indigo IO: probe of
0000:03:00.0 failed with error -2
Jan 14 14:29:14 Myrddin kernel: input: PC Speaker

The Indigo is not listed in /proc/asound/cards (although a built-in
intel AC97 card is and works fine).

Thank you all for you insights.

James Vaughn


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
