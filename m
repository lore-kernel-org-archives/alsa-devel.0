From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: I'm developing an Aztech PCI168 (AZF3328) driver
Date: Sun, 8 Sep 2002 11:16:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020908111659.A2151@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm currently in the process of developing a driver for this soundcard
(that's one of about 6 unsupported cards in the support matrix).
Needless to say, Aztech doesn't give ANY SUPPORT for its sound cards
(and yes, I did have my fair share of email autoreplies and negative replies).
I'm the guy mentioned in the ALSA support matrix, BTW, just in case
you wondered :)

The purpose of this mail is to find out whether there's *someone* out there
who has the same (or a similar !) card and wants to join development.
I've got the PCI168 AP(W) version (subsystem ID 1801), other versions are:
- PCI168 A(W), sub ID 1800
- PCI168 A/AP, sub ID 8000
- others ??

Current status:
- mixer interface can be accessed and works, not fully implemented yet
  (CD playback / master volume muting can be managed and *work*)
- started trying to get DMA playback (and interrupt management) to work,
  but so far no annoying noise yet :-)

Also, I'd really like to talk to someone who is pretty intimate with
the operation of several sound card drivers.

Have fun,

Andreas Mohr

-- 
Microsoft Licensing 6.0: "Pay us now in advance, so that we can own you later."


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
