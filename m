From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [ANNOUNCE] MikMod driver for ALSA sequencer
Date: Sun, 12 May 2002 03:51:32 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020512035132.C16784@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

MikMod driver for ALSA sequencer.

I finally got it working. It's a patch against libmikmod-3.1.10. Get it
from "http://www.saunalahti.fi/~syrjala/alsa/"

ALSA 0.9 + a patch to alsa-lib is required. I sent the patch to alsa-devel
and it's also at my website.

Should work with GUS and Trident cards. Tested with GUS PnP w/ 16MB. It
should find a suitable destination client and port on its own, but they 
can also be forced with "client=x,port=y" driver options.

My TODO list:
Fix instrument loading? I get "Bad address" errors on some samples. I
don't know what the cause is.
What is a good sleep duration between snd_seq_output_drain() calls?
Get the max voice count from sequencer? (Doesn't work with current ALSA)
Some modules have weird sounds. (panic.s3m for example)

Please tell me if it works for you.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
