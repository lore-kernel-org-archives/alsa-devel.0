From: Maurizio Monge <monge@sns.it>
Subject: Strange things with via82xx
Date: Tue, 22 Jun 2004 04:15:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406222045.55079.monge@sns.it>
Reply-To: monge@sns.it
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


hello, 
i have a K8V Deluxe Asus MB, with an AMD64 and 2.6.7 kernel.
on the motherboard there are 3 jacks:

   red     lite green   dark green
    O          O            O

the mb manual says that red is "Microphone jack", lite green "Out Jack"
and dark green "In Jack".

The very strange thing is this:
when using linux OSS or WinXP 32bits (if i remember correctly, as i deleted
it :-) ), to listen audio i have to connect the loudspeakers
to the red "Microphone jack" (!!!).

When using FreeBSD 32bits (OSS) or ALSA i have to connect the loudspeakers to 
the light green "Out Jack".

This looks very strange!

Further, when using WinXP, linux OSS or FreeBSD i get a MUCH better quality 
than with ALSA (cshhhhhhhhhhhhhhhhh).
Of course i tried dxs_support=0,1,2,3,4 but the sound quality do not changes.
Any idea? Thanks.

my lspci via entry is:

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 
Audio Controller (rev 60)
        Subsystem: Asustek Computer, Inc.: Unknown device 80b0
        Flags: medium devsel, IRQ 5
        I/O ports at c800 [size=256]
        Capabilities: [c0] Power Management version 2

-- 
Best Regards
Maurizio Monge

Please CC me to monge(at)sns(dot)it as i'm not subscribed.

"..the triumph of evil is for good men to do nothing." (Edmond Burke)


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
