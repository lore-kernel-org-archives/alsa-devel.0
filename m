From: Robert Vetter <vetter@bury.com>
Subject: Problems with virtual rawmidi
Date: Thu, 15 Mar 2007 12:21:17 +0100
Message-ID: <200703151221.17744.vetter@bury.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hello,

I'm working on an MIDI application with ALSA support on LInux. I have problems 
with reading MIDI from virtual rawmidi device.

When I open the device (M-Audio Keystation 49e) in "pure" raw mode calling:

snd_rawmidi_open(&handle_in,NULL,"hw:1,0",0); 

everything is ok and I can read the MIDI stream without problems. BUT when I 
create a virtual midi in port in my application calling:

snd_rawmidi_open(&handle_in,NULL,"virtual",0); 

and connect midi out port from the Keystation to the midi port of the 
Application (using QJackctl), I get problems. Some bytes are skipped, as it 
looks like. For example: Right after everything is started and set up I press 
a key and keyboard and get only the status byte (0x90) and note number, but 
no velocity byte. Then when I release the key I don't get any status byte, 
but only note number and velocity byte( 0 in this case).

Could somoene please check it?

Thank you

Robert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
