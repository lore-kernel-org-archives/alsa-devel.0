From: Thomas Fjellstrom <tfjellstrom@telusplanet.net>
Subject: Re: rawmidi && cpu usage
Date: Wed, 4 Dec 2002 08:56:47 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212040856.47925.tfjellstrom@telusplanet.net>
References: <Pine.HPX.4.33n.0212040940070.21950-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0212040940070.21950-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On December 4, 2002 01:48 am, Clemens Ladisch wrote:
> Thomas Fjellstrom wrote:
> > > It seems that after a few seconds (30->60 ish) cpu usage seems to go
> > > way up and notes are dropped.
> > > I have a SBLive! Value,
>
> The driver itself should not have noticeable impact on cpu usage.
> Does this happen with all programs?
>
> How big is cpu usage when you do "cat /dev/zero > /dev/midiX"?
>

That says 0%. And it stays low on the list. My main problem is with rawmidi, 
pmidi is fine. And the rawmidi code I wrote for 0.5.* is fine, but Im running 
alsa 0.9.* now :) So I wanted to get a 0.9.* client up and running. When I 
orriginally posted about this several months ago, 'Takashi Iwai' was trying 
to take a look at it. Im quite sure it's not the midi player I wrote the 
rawmidi code for, as it works fine with it's own DIGIMID driver (works like 
timidity, but play only), and for (other people) with it's OSS Midi driver, 
the Windows Midi drivers, heck even the DOS midi (supports OPL, FM, and SB 
cards) drivers for the player is fine.

Thanks.

-- 
Thomas Fjellstrom
tfjellstrom@telusplanet.net
http://strangesoft.net


-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
