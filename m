From: "Robert Gruendler" <dobre@gmx.at>
Subject: Re: Problems with RME Multiface on a Titanium	Powerbook
Date: Wed, 29 Dec 2004 16:28:20 +0100 (MET)
Message-ID: <644.1104334100@www7.gmx.net>
References: <1104288565.7278.1.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Try commenting out the "dbri" module in your /etc/X11/XF86Config-4.
> I know it sounds strange, but DRM in the radeon driver locks all
> pages in memory. That causes havoc with sound and anything real-time.

I havent got a /etc/X11/XF86Config-4, but a /etc/X11/XF86Config, which has
no  entry for "dbri" in Modules. This is how the unmodifid modules-section
looks like:

Section "Module"
	Load  "dbe"
	Load  "extmod"
	Load  "fbdevhw"
	Load  "glx"
	Load  "record"
	Load  "freetype"
	Load  "type1"
	#Load	"dri"
EndSection


I have commented out the "dbe" module, but no success. Still the same
problems after rebooting.

> Also, do you get any output using snd-powermac?

No. When i try to insert the module with $modprobe snd-powermac i get:

[root@localhost root]# modprobe snd_powermac
FATAL: Module snd_powermac not found.

When i do "play a test sound" from the "Soundcard verfication" menu, i get
full signals on all software-channels in the hdspmixer, both with snd-hdsp
and snd-powermac...

Strange.


Robert

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
1 GB Mailbox bereits in GMX FreeMail http://www.gmx.net/de/go/mail


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
