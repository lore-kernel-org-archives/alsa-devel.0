From: Konstantin Kletschke <lists@ku-gbr.de>
Subject: Re: A: VIA Technologies Inc. VT1720/24
Date: Thu, 25 Jan 2007 20:58:30 +0100
Message-ID: <20070125195830.GA5496@anita.doom>
References: <45AFE785.6020307@informatik.uni-oldenburg.de>
	<45B74CC0.4060905@svs.Informatik.Uni-Oldenburg.de>
	<s5hac08cvct.wl%tiwai@suse.de>
	<20070125101319.GA3340@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070125101319.GA3340@titan.lahn.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Now I inspected your approach more in detail. As I said things are
working well, but other as my approach the volume sliders (Master and
PCM) have no effect. They are moving but the sound keeps being at a
moderate level (constant). 

I suppose the wm8776 is not addressed correctly, where does aureon.c
expect it? I am still fiddling this out.

Am 2007-01-25 11:13 +0100 schrieb Philipp Matthias Hahn:

> > config file.  As Prodigy 7.1 Hifi is almost identical with Prodigy
> > 7.1

Are you both really shure? From code side of view the HiFi seems to be
the first combination of vt1724 and wm8776 and 8766 and cs8415a.

Philipp, is your prodigy 7.1 hifi really functional with your patch
mailed in this thread? Mine still needs the other initialisation
register value and cs8415a is not initialized here.

As said, now I realize the main mixer don't have effect on output
volume.

Kind Regards, Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
