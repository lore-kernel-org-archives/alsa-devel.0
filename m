From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp multiface pci.
Date: Wed, 22 Jan 2003 13:41:11 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301221836.h0MIanx0017277@spider.tela.com>
References: <m3el75ghph.fsf@grouper.coelacanth.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "22 Jan 2003 13:30:50 EST."
             <m3el75ghph.fsf@grouper.coelacanth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roger Williams <raw@qux.com>
Cc: markknecht@attbi.com, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Yes, I understand that that's what the driver is _supposed_ to do.
>That's how it works on my HDSP PCI and Cardbus systems.  But isn't it
>true that the current driver doesn't actually set up any of those
>zero-gain connections for the HDSP 9652?

well, it attempts to, but its writing to the wrong registers.

>This is the only point that I was trying to make to Mark -- the
>default unity-gain connections (i.e. playback -> H/W output) that he
>has been using are FPGA configuration defaults, not explicitly set up
>by the driver.

correct. i actually don't have any idea what those defaults are.



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
