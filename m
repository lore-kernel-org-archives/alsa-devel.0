From: "Mike Mazarick" <mazarick@bellsouth.net>
Subject: GadgetLabs Driver for Alsa Linux
Date: Wed, 20 Oct 2004 12:40:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <LEEHJNBIEAAEJEHBEGDBGEJICFAA.mazarick@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jole <jole@conwaycorp.net>, Waldemar Haszlakiewicz <waldemar.haszlakiewicz@siol.net>, Jay Schwichtenberg <jays@aracnet.com>
List-Id: alsa-devel@alsa-project.org


I would like to announce (and solicit some help/advice) the start of driver
development for the GadgetLabs 8/24 card (and potentially other models).
The company GadgetLabs has been out of business for several years, but they
made a high end multichannel (8 in, 8 out) card from 1998-2000.  The card is
capable of up to 48 khz sampling rate at 24 bits.

There has been a highly active volunteer group that has developed a very
reliable/functional low latency ASIO driver under WindowsXP (thanks
Waldemar! you 'da man!), and the effort now continues to Linux.  The current
plan is to develop it with the Planet CCRMA setup for Fedora Core 1 (kernel
2.4, alsa .9), and eventually move to Fedora Core 2 (kernel 2.6) when the
Planet CCRMA migrates there.

The gameplan is to mimic/clone as much of the code from the Delta 1010
series card, since it is multichannel and seems to have a similar functions,
and is widely used in Linux audio circles.

The biggest differences and technical challenges between Delta 1010 and
GadgetLabs are:

1)  the PCI bus interface chip is a  PLX PCI9052 (pci to localbus
converter);  googling around seems to indicate that other people who've
tried to do Linux drivers with this chip have run into problems (advice here
is welcomed)
2)  The "heart" of the Delta 1010 is an envy24 LSI chip, while the
GadgetLabs chip uses an Altera FLEX programmable gate array (EPF6016QC208-3
to be exact).

The only other circuits on board (outside of the converters/drivers
themselves) are:
    a)  one National Semiconductor PC16550 (probably for driving a Midi
port)
    b)  three Alliance AS7C256-15JC (256K static memory)
    c)  a few ttl gates

Obviously, the "heart" of this board is the Altera chip.   The plan is to
take the existing XP driver, and load the same "chip guts" with the Linux
driver.  Any good advice here would be appreciated also.  At this juncture,
the plan is to load it via a hex encoded ".h" file in the driver.  (Comment:
Due to the simplistic design, and the fact that Altera has made their
development kit for this model free, it would also be a good "evaluation"
board for anyone interested in playing with FPGA programming).

All advice/comments are welcomed as this is a first attempt at any "serious"
programming (the phrase "fools go where angels fear to tread" comes to
mind).  Please direct any comment/emails to -
mazarick at bellsouth dot net

In particular, any pointers to existing drivers that utilize the
PC16550/Altera FLEX FPGA or describe the migration from a 2.4 to 2.6 kernel
would be greatly appreciated.

Best wishes (and wish me luck!)

Mike Mazarick




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
