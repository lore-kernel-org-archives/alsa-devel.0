From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: rawmidi && cpu usage
Date: Wed, 04 Dec 2002 09:48:35 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212040940070.21950-100000@studcom.urz.uni-halle.de>
References: <200212031139.08792.tfjellstrom@telusplanet.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200212031139.08792.tfjellstrom@telusplanet.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Fjellstrom <tfjellstrom@telusplanet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Fjellstrom wrote:
> > It seems that after a few seconds (30->60 ish) cpu usage seems to go way up
> > and notes are dropped.
> > I have a SBLive! Value,

The driver itself should not have noticeable impact on cpu usage.
Does this happen with all programs?

How big is cpu usage when you do "cat /dev/zero > /dev/midiX"?


Regards,
Clemens



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
