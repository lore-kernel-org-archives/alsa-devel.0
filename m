From: Donald M Burns <donald@sequel.demon.co.uk>
Subject: Re: YMFPCI No midi record.
Date: Tue, 1 Apr 2003 20:58:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304012058.13777.donald@sequel.demon.co.uk>
References: <200303302024.15366.donald@sequel.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303302024.15366.donald@sequel.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

Although I got no response with my previous posting I am going to
carry on until somebody sits up and listens (it would be rude not to!).

I have been through the ymfpci.c file and as I suspected the mpu401
interupt was NOT enable. The line in question is 166 viz:-

                //legacy_ctrl |= 0x10; /* MPU401 irq enable */

Note the comment // mark at the begining. Making the line active
fixes the midi recieve function as cat /dev/midi produces a gentle
stream of heartbeats from my Korg Keyboard. However, Jazz
still won't record with ALSA-OSS drivers but pure OSS works
just fine. I suspect it could be to do with connection between midi
devices and would appreciate some expert help. Here is 
/proc/asound/seq/clients while jazz is running.
Client info
  cur  clients : 4
  peak clients : 5
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
    Connecting To: 63:0
Client  63 : "OSS sequencer" [Kernel]
  Port   0 : "Receiver" (-we-)
    Connected From: 0:1
  Port   1 : "Sequencer-0" (rwe-)
    Connecting To: 64:0
    Connected From: 64:0[t:0]
  Output pool :
    Pool size          : 1024
    Cells in use       : 0
    Peak cells in use  : 138
    Alloc success      : 20361
    Alloc failures     : 0
Client  64 : "Rawmidi 0 - MPU-401 (UART) 0-0" [Kernel]
  Port   0 : "MPU-401 (UART) 0-0" (RWeX)
    Connecting To: 63:1[t:0]
    Connected From: 63:1
Client  65 : "OPL3 FM synth" [Kernel]
  Port   0 : "OPL3 Port" (-We-)
  Port   1 : "OPL3 OSS Port" (-we-)

All help would be most kindly recieved.

Best Regards,

Donald.


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
