From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: seq24 not in aconnect or qjackctl
Date: Wed, 30 Mar 2005 16:05:55 +0100
Message-ID: <20050330150554.GA17648@palantir7.mph.eclipse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: seq24-users@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm using seq24 0.6.2 with ALSA 1.0.9rc1 and jack 0.99.0-4.
Problem I'm having is that seq24 does not show up in
aconnect or qjackctl. At first I had no clue if/how it was
connected. seq24 only showed up in /proc/asound/seq/clients.
Still haven't found how to disconnect/reconnect seq24.

Any idea why I'm not seeing seq24? Some output below.

Thanks,
Martin

$ cat /proc/asound/seq/clients 
Client info
  cur  clients : 4
  peak clients : 8
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
    Connecting To: 63:0, 128:2[t:0]
Client  62 : "Midi Through" [Kernel]
  Port   0 : "Midi Through Port-0" (RWe-)
    Connecting To: 128:1[t:0]
    Connected From: 128:0
Client  63 : "OSS sequencer" [Kernel]
  Port   0 : "Receiver" (-we-)
    Connected From: 0:1
Client 128 : "seq24" [User]
  Port   0 : "seq24 out" (r---)
    Connecting To: 62:0
  Port   1 : "seq24 in" (-w--)
    Connected From: 62:0[t:0]
  Port   2 : "seq24 in" (-w--)
    Connected From: 0:1[t:0]
  Input pool :
    Pool size          : 200
    Cells in use       : 0
    Peak cells in use  : 2
    Alloc success      : 9
    Alloc failures     : 0
$ aconnect -lo
client 62: 'Midi Through' [type=kernel]
    0 'Midi Through Port-0'
        Connecting To: 128:1[real:0]
        Connected From: 128:0
$ aconnect -li
client 0: 'System' [type=kernel]
    0 'Timer           '
    1 'Announce        '
        Connecting To: 63:0, 128:2[real:0]
client 62: 'Midi Through' [type=kernel]
    0 'Midi Through Port-0'
        Connecting To: 128:1[real:0]
        Connected From: 128:0



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
