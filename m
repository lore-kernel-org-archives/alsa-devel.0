From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hda intel driver and no surround sound with nvidia
 mcp55 (chip ID RealTek 888)
Date: Sat, 5 Aug 2006 19:47:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0608051946190.9377@tm8103.perex-int.cz>
References: <44D4BD9F.9010601@timburrell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44D4BD9F.9010601@timburrell.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tim Burrell <tim@timburrell.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 5 Aug 2006, Tim Burrell wrote:

> Hi there,
> 
> I'm trying to get multichannel sound working on my nvidia nforce 590
> based mobo that uses the intel hd audio (nvidia mcp55) chipset.  It
> plays fine in two channels but any attempts to use -Dsurround51 or
> -Dsurround40 fail.  Ie:
> 
> Playing WAVE 'space_battle.wav' : Signed 16 bit Little Endian, Rate
> 44100 Hz, Channels 6
> aplay: set_params:906: Channels count non available

That's correct. Use -Dplug:surround40, because the count of channels from 
the .wav file has to be converted to four.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
