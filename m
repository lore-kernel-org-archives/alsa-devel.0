From: Paul Davis <pbd@op.net>
Subject: Re: ALSA driver architecture documentation?
Date: Tue, 27 Aug 2002 10:16:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17jh7Q-0005bQ-00@usw-sf-list1.sourceforge.net>
References: <20020819213712.A18500@xs4all.nl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 19 Aug 2002 21:37:12 +0200."
             <20020819213712.A18500@xs4all.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Fred Jan Kraan <fjkraan@xs4all.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Recently I started to collect some info on how to make a ALSA driver for
>the Digigram VXpocket V2. Digigram decided to provide information
>this PCMCIA card, on condition that a moderator is the single point of
>contact with Digigram.

glad they came to their senses. the existence of the RME Hammerfall
DSP driver for linux had nothing to do with it, i'm sure :)

>A driver for the VXpocket should interface with the PCMCIA module and

actuall, no. see below.

>(most likely) the ALSA package. Info on how to make a PCMCIA driver
>easy to find. Description of layers and a well documented dummy driver.
>Alas I did not find much info in the ALSA structure. There is lots of
>source code and even a dummy driver, but completely uncommented.
>What seems to be documented is how to interface with ALSA, not how to
>write a ALSA driver. So is there more than "use the source"? :-)

the linux kernel makes pcmcia devices appear to be regular pci
devices. there is no difference between writing a driver for a pcmcia
device or a regular pci one. there are pcmcia utilities, its true, but
the driver doesn't need to know about them. they can be used, for
example, to autoload the driver when the device is inserted, etc.

because of this, "use the source for a similar-featured audio
interface" is the best advice.

--p



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
