From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa driver and udev.
Date: Fri, 8 Dec 2006 08:25:11 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0612080818360.13335@tm8103.perex-int.cz>
References: <4577F6C5.2050206@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4577F6C5.2050206@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 7 Dec 2006, James Courtier-Dutton wrote:

> Hi,
> 
> How much work would it be to get alsa driver to work nicely with udev, 
> so that a specific udev config could be used to decide which sound card 
> is card 0 etc.
> How about a global config interface whereby userland processes could 
> modify the sound card order and possibly provide other general sound 
> card related services to userspace. In this way, even if a sound card 
> booted up as card 0, we could swap it with card 1 without having to 
> unload it.
> This might require the device naming in /dev/snd to change so that the 
> card number was not included in the device name. Maybe use an extra 
> subdirectory for each card, much like the /proc filesystem uses.

Hi,

	my idea was a bit different. We have card id (aka text alias) 
already. They are fully supported in alsa-lib. So, only missing thing is 
to change these aliases and to use these aliases in application 
configurations rather than card numbers.
	I had already a discussion with Greg on LKML and in mm tree (I 
think) are patches to create a soundcard class. We can put card id (alias) 
to this class with read/write priviledges. So udev can freely change it 
like network device names. I think it could be in 2.6.20.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
