From: Roger Williams <raw@qux.com>
Subject: Re: hdsp multiface pci.
Date: 19 Jan 2003 17:24:53 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3ptqskcay.fsf@grouper.coelacanth.com>
References: <3E2A952E.6060305@boosthardware.com>
	<1042985569.1663.33.camel@satellite.undata.org>
	<3E2AC45F.3070601@boosthardware.com>
	<1042992464.1649.55.camel@satellite.undata.org>
	<3E2AD34D.6070308@boosthardware.com>
	<m3d6mt9is6.fsf@grouper.coelacanth.com>
	<1042978893.1341.108.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>>>>> Mark Knecht <markknecht@attbi.com> writes:

  >> amixer cset numid=5 26,26,16384
  >> amixer cset numid=5 28,26,16384
  >> amixer cset numid=5 30,26,16384
  >> amixer cset numid=5 32,26,16384
  >> amixer cset numid=5 27,27,16384
  >> amixer cset numid=5 29,27,16384
  >> amixer cset numid=5 31,27,16384
  >> amixer cset numid=5 33,27,16384

  > ... is the use of 26 and 27 on the output part of the command
  > telling the hardware to route whatever it is that you're mixing to
  > the line out connectors on your box?

Yes.  (Not outputs 1 & 2, as I erroneously stated.)

  > Second, where do the inputs numbered 26-33 come from.

As far as the Multiface's analogue I/O goes, channels appear to be
numbered like this:

Multiface inputs 1-8               = amixer source channels 0-7
Multiface outputs 1-8              = amixer destination channels 0-7
Multiface line (headphone) outputs = amixer destination channels 26-27
alsa_pcm:playback_1-8              = amixer source channels 26-33

So amixer cset numid=5 0,26,16384" routes the signal from input 0 to
the left headphone channel.  And "amixer cset numid=5 0,0,16384"
routes the signal from input 0 to output 0.  And

    for i in 0 2 4 6; do amixer cset numid=5 $i,0,16384; done
    for i in 1 3 5 7; do amixer cset numid=5 $i,1,16384; done

will route inputs 1+3+5+7 to output 1, and inputs 2+4+6+8 to output 2.

On playback "amixer cset numid=5 26,0,16384" routes the playback_1
source to Multiface output 1, and

    for i in 26 28 30 32; do amixer cset numid=5 $i,0,16384; done
    for i in 27 29 31 33; do amixer cset numid=5 $i,1,16384; done

routes playback_1+3+5+7 to output 1 and playback_2+4+6+8 to output 2.

  > I presume that your use of 16384 is to reduce volume so that after
  > summing 4 channels you do not create output clipping if all the inputs
  > hit maximum volume at the same time?

Yes.  This is just a submix for headphone monitoring, so I route it to
outputs 26 and 27.  This is a monitor submix I use when recording with
ecasound.  If I were using Ardour, I'd set up a monitor submix in
Ardour itself, and route outputs 1 and 2 to the headphone output with

    amixer cset numid=5 26,26,65535
    amixer cset numid=5 27,27,65535

  > If you wanted to route input 0 directly to an output, could
  > you use a command like:

  > amixer cset numid=5 0,26,16384
  > amixer cset numid=5 1,27,16384

This routes hardware inputs 1 and 2 to the headphone outputs.

-- 
Roger Williams <raw@qux.com>
Qux Tool & Die, Middleborough, Massachusetts
// Omne tulit punctum qui misquit utile dulci //


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
