From: Peter L Jones <peter@drealm.org.uk>
Subject: Re: [PATCH] USB MIDI as rawmidi
Date: Mon, 21 Oct 2002 22:30:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210212230.07728@advent.drealm.org.uk>
References: <Pine.HPX.4.33n.0210211706570.19019-101000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0210211706570.19019-101000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 21 Oct 2002 16:15, Clemens Ladisch wrote:
> This patch converts usbmidi to use rawmidi instead of sequencer devices.
>
> There are two user-visible changes: now it's really integrated in
> snd-usb-audio (no separate file anymore), and the input stream doesn't use
> running status. (The latter could be added easily.)
>
> This is a major and not thoroughly tested change, so I don't think it
> should go into 0.9.0rc4.
>
>
> Clemens

Clemens,

Sorry if this is a dumb question but what's the patch against?  Can I apply it 
against alsa rc-3 in 2.5.44?

(I'd just go ahead and apply it but I wanted to have a moan first ;-) )

-- Peter



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of  Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576298;k?http://www.sun.com/javavote
