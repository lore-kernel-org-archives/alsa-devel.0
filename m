From: Konstantin Kletschke <lists@ku-gbr.de>
Subject: Re: Re :  ice1724/Audiotrak Prodigy 7.1 HiFi
Date: Fri, 5 Jan 2007 18:23:56 +0100
Message-ID: <20070105172356.GA28466@anita.doom>
References: <20070102151108.GA10561@synertronixx3>
	<1167850413l.15450l.0l@zerox> <20070105125211.GA19866@anita.doom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070105125211.GA19866@anita.doom>
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


Okay, I read Bug 0001556 again and I read that

ice->akm = kzalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
if (! ice->akm)
return -ENOMEM;
ice->akm_codecs = 1;

is required for the quick Hack not to Oops, thats the case here also and
putting it back let me load the module and inspect some stuff with
alsamixer.
But, as my first approach with the pontis.c modification, audio plays at
double speed. 

As I am a greenhorn writing alsa drivers, where start I search for a bug
or what debug output is of interest now?

Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
