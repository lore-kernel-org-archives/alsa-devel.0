From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: rawmidi problems
Date: Fri, 5 Jul 2002 17:53:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207051753.54999.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I was trying to test rawmidi on snd-usb-midi with latest patches, with no  
success :(

Then, as I have an sb 128 (snd-ens1371) I tryed the alsa-lib/test/rawmidi 
program with only that card module loaded. 

$ ./rawmidi -i hw:0,0
Read midi in
Press ctrl-c to stop
(With a MIDI keyboard connected, no events received at all.)

$ ./rawmidi -i hw:0,0 -o hw:0,0 -t
(OK, input events sent to out, with a lot of delay)

$ ./rawmidi -o hw:0,0
Writing note on / note off
(OK)

With alsa-lib/test/seq program all tests OK.

Regards,
Pedro




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
