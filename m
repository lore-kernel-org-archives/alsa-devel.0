From: --friar <friar@zendragon.com>
Subject: Re: problems loading cmipci module with A7M266-D
Date: Mon, 02 Dec 2002 14:25:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212021925.OAA02434@www.zendragon.com>
References: <200212010309.WAA07518@www.zendragon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 30 Nov 2002 22:09:37 EST."
             <200212010309.WAA07518@www.zendragon.com>
Content-ID: <2424.1038857156.1@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: friar@www.zendragon.com
List-Id: alsa-devel@alsa-project.org

>Ok, I've now tried both the 0.9.0rc6 and just built the latest
>version from cvs, neither module works.  I am running Slackware and
>have compiled both the 2.4.20 (SMP) kernel and the modules using the
>standard 2.95.3 20010315 (release) gcc.
>
[stuff snipped]

Ok, it looks like the A7M266-D does not set up the onboard soundcard
if the "Plug and Play OS" option is set to YES in the BIOS.
The C-MEDIA 8738 doesn't get an IRQ so the Alsa driver can't see the
device.  After fixing that, /dev/dsp0 works fine.

--friar


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
