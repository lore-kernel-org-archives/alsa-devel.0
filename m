From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: Please explain Alsa Interface MIDI numbering PLEASE!
Date: Sun, 16 Feb 2003 20:43:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302162043.11592.plcl@telefonica.net>
References: <E18kTvV-0001Ti-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18kTvV-0001Ti-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: alsa-devel@lists.sourceforge.net, Rosegarden-Devel <rosegarden-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sunday 16 February 2003 19:53, Mark Knecht wrote:
> 2) In the screen shot "with_2x2.png" I've plugged in the MidiSport 2x2.
> New devices show up in kaconnect. However, instead of showing 2 read
> ports and 2 write ports, I am getting 4 read ports and no write ports.
> Please explain why the MidiSport is given the names
>
> 72:0 External MIDI 1
> 72:1 External MIDI 1
> 72:2 External MIDI 1
> 72:3 External MIDI 1
>
> Shouldn't this be just :0 and :1 for both the read and write ports?

Yes. This was a bug in snd-usb-audio for 0.9.0rc7, fixed now in ALSA CVS, see:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg06225.html

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
