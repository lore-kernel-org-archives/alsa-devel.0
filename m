From: Ben Saylor <bensaylor@fastmail.fm>
Subject: Audiophile USB capture
Date: Tue, 29 Jul 2003 01:51:54 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307290151.54385.bensaylor@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

On to the next problem with this interface.. :)

Capture doesn't work.  arecord and Audacity get silence, even though 
capture appears to be running normally.  When recording, 
/proc/asound/card0/stream0 reports:

 at usb-00:1d.1-1 : USB Audio

Playback:
  Status: Stop
<snip>
Capture:
  Status: Running
    Interface = 5
    Altset = 3
    URBs = 5 [ 4 4 4 4 4 ]
    Packet Size = 200
    Momentary freq = 44,099 Hz
  Interface 5
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 48001 - 96000 (continuous)
  Interface 5
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 5
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)

Any hints on how to figure out the problem?

Thanks,
Ben



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
