From: Gerard Janssen <g.janssen@its.tudelft.nl>
Subject: How to select different S/PDIFoutput ports on a SBLive!
Date: Sat, 31 Aug 2002 15:46:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0H1P000C9NO5XV@mailhost1.tudelft.nl>
References: <0GWB00A1EBK4U2@mailhost1.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <0GWB00A1EBK4U2@mailhost1.tudelft.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Some time ago, I posted a similar message, but I never got a reply.

The SBLive! card can support four SPDIF output channels, indicated as
SPDIF#0 - 3, which are located on the 12 pins or the 40 pins external
connector (depending on the type of card).
When I play a file to "spdif" or "iec958:AES0=0x42,AES1 = 0x82,AES2 =
0x02,AES3 = 0x02", the signal is send to the SPDIF#1 output. When I use
"front" or "center_lfe", I can get music out of SPDIF#0-3 depending on the
ALSA-mixer settings, however, the way the settings have to be chosen is not
straight forward (trial and error). So apparently all SPDIF outputs are
"available".

I would like to select/address all four SPDIF outputs of the SBLive! card.
Now I have the following questions:

1. How can the SPDIF output port be changed when using the "spdif" or
"iec958" in the alsa player. I tried to change the channel value of AES2,
but this had no effect at all.

2. I tried to find the location where the SPDIF output port is set in the
alsa code for the emu10k1. I also searched the emufx-code, since the spdif
outputs come directly from the fx8010 processor, but I did not find it.
Where is the SPDIF output port set? How can it be changed?

B.t.w. I did find only three SPDIF channel status registers (SPCS0-2). Why
are there only three SPCS's in stead of four?

Gerard Janssen 




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
