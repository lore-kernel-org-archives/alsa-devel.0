From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP
Date: Mon, 09 Dec 2002 23:11:14 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18Lbdd-00059F-00@sc8-sf-list1.sourceforge.net>
References: <1039491744.1340.20.camel@Godzilla>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "09 Dec 2002 19:42:23 PST."
             <1039491744.1340.20.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>, Alsa-List <linux-audio-user@music.columbia.edu>
List-Id: alsa-devel@alsa-project.org

>   Where are the definitions for PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP and
>PCI_VENDOR_ID_XILINX kept in the alsa code? 

one of two places. either in the kernel source (if you have a much,
much newer kernel (2.5)) or at the top of either rme9652.c or hdsp.c
(there are conditional #define's there to check if they are already
defined in the kernel's PCI ID header.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
