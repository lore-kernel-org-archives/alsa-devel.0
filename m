From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [ALSA - driver 0000425]: usb-usx2y: System lockup
     on PCM device open (OHCI)
Date: Sun, 10 Oct 2004 23:31:02 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32952.192.168.1.5.1097447462.squirrel@192.168.1.5>
References: <20041010133726.CBA7A2801D@server.perex-int.cz>
    <200410101939.00958.ws@seh.de>
    <200410102024.49380.annabellesgarden@yahoo.de>
    <200410102328.54798.ws@seh.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410102328.54798.ws@seh.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Werner Schweer <ws@seh.de>
Cc: alsa-devel@lists.sourceforge.net, Karsten Wiese <annabellesgarden@yahoo.de>
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
> This one makes a difference:
> usx2y_linux-2.6.9-rc3-mm3-VP-T3_041010.tar.gz After switching to my
> via-chipset-baset PC, I suddenly found myself in the club of the
> "sequence error" victims ;-)
> On that via system its ok now: no "sequence error" no more.
> also made two real crash bugs vanish.
> So please test this and forget the
> usx2y_linux-2.6.9-rc2-mm4-S7_041008.tar.gz.
> As before setup a 2.6.9xyz kernel, cp the tar's content into it and
> build everything inside the kernel.
> The rawusb version isn't yet done.

Sorry to point this out, but the "usbusx2y.h" in the given archive
(usx2y_linux-2.6.9-rc3-mm3-VP-T3_041010.tar.gz) makes reference to a non
included header file "usx2yhwdeppcm.h", which I think it's part of the
rawusb branch.

So, I'd better wait for the complete works, eh? ;)
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
