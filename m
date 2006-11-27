From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Sound Blaster Live! 24bit External - Capture
	Support
Date: Mon, 27 Nov 2006 09:02:03 +0100
Message-ID: <1164614523.31285.277556901@webmail.messagingengine.com>
References: <20061126104351.21546.qmail@web39707.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061126104351.21546.qmail@web39707.mail.mud.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: SchrodingerEq Fixed <fixedschrodingereq@yahoo.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

SchrodingerEq Fixed wrote:
> I'm porting a system from Windows to Linux and It uses a Sound Blaster
> Live! 24bit External.  As the system is already built I'm apprehensive to
> switch hardware, is an update for the ca0106 driver to support audio
> capture on the Live! 24bit in the near future (I'm happy to only capture
> 16bits and/or give beta drivers a test) ?

The "Sound Blaster Live! 24bit External" is completely different from
the "Sound Blaster Live! 24bit".  The USB device uses the snd-usb-audio
driver.

All sample formats should be supported.  What problem do you have?


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
