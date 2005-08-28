From: peter plessas <plessas@mur.at>
Subject: errors inserting snd-powermac
Date: Mon, 29 Aug 2005 00:34:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.56L0.0508290030570.31656@hornet.mur.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Dear List,

i have run across a strange thing compiling alsa-drivers for a 
2.6.11.5 powerpc kernel. This happens with all sort of alsa-driver 
sources: 1.0.9rc4, 1.0.9, cvs
I had them running already but decided to recompile, as i had some strange 
noises with the hdsp. This problem here is about the snd-pwermac module 
though...

./configure --with-sequencer=yes --with-oss=yes --with-cards=hdsp,powermac

make
*** Warning: "macio_find" 
[/usr/local/src/alsa-1.0.9rc4/alsa-driver-1.0.9rc4/ppc/snd-powermac.ko] 
undefined!

make install

modconf:
FATAL: Error inserting snd_powermac 
(/lib/modules/2.6.11.5uhci/kernel/sound/ppc/snd-powermac.ko): Unknown 
symbol in module, or unknown parameter (see dmesg)
FATAL: Error running install command for snd_powermac

dmesg:
snd_powermac: Unknown symbol macio_find

is this my fault and where can i start searching?

regards, Peter


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
