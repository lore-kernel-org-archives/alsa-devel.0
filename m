From: Giuliano Pochini <pochini@shiny.it>
Subject: New Echoaudio firmware - testers wanted for Layla 3G (3rd attempt)
Date: Mon, 5 Dec 2005 20:20:00 +0000
Message-ID: <20051205202000.6a58f7af.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Alsa-user <alsa-user@lists.sourceforge.net>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


I have new firmwares for the following cards:

Echo3g, Mia, IndigoIO, Indigo, IndigoDJ, Gina24_361, Gina24, Darla24

The most important changes are for the "3G" cards:

-	New firmware for Gina3G & Layla3G that fixes pops and clicks with
	simultaneous MIDI and audio I/O.  There is now only one DSP
	firmware image for both Gina3G and Layla3G.
-	Removed support for Gina24 CD-ROM S/PDIF mode


I don't know what actually changed except for 3G and Gina24. The biggest
changes in the are in the 3G driver part because the init funcion is
different. Other code is almost unaffected. The files are here:

http://www.webalice.it/g_pochini/ead/alsa-driver-1.0.10.tar.bz2 [2.4MB]
http://www.webalice.it/g_pochini/ead/alsa-driver-1.0.10.tar.bz2.sig
 * or *
http://www.webalice.it/g_pochini/ead/echo_new_fw.patch [10KB]
http://www.webalice.it/g_pochini/ead/echo_new_fw.patch.sig

and the new firmware:

http://www.webalice.it/g_pochini/ead/alsa-firmware.tar.bz2 [1.6MB]
http://www.webalice.it/g_pochini/ead/alsa-firmware.tar.bz2.sig


It has been tested on the Gina24 and the Gina3G by me and it seems OK. It is
important that someone tests it on a Layla3G before I submit the changes.
Tnx.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
