From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: MIDI and PCMCIA
Date: Wed, 18 Jun 2003 07:34:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Sb7s-0002yL-00@sc8-sf-list1.sourceforge.net>
References: <s5hy8zz4pnn.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 18 Jun 2003 12:59:40 +0200."
             <s5hy8zz4pnn.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>struct.  (although it has a xilinx firmware loading routine).

just to make sure there is no misinformation going around: the
"firmware" loaded by the hdsp driver has nothing to do with the xilinx
fpga. its not even really "firmware" in the conventional sense. its
actually configuration data for the i/o box attached to the pci/pcmcia
card, and is written to the already running fpga, which passes it
through/writes it to the i/o box. you can have a "running" hdsp card
with no i/o box, but that's hardly what you'd call useful :)

--p


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
