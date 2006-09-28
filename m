From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Default soundcard (UDEV?)
Date: Thu, 28 Sep 2006 11:15:45 -0400
Message-ID: <1159456546.7086.29.camel@mindpipe>
References: <6.2.1.2.2.20060928013552.16a4b928@mailone.real.com>
	<s5hhcys2kr2.wl%tiwai@suse.de> <1159454460.7086.23.camel@mindpipe>
	<s5h64f82gm8.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0609281654230.9381@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0609281654230.9381@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa Developement <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-09-28 at 17:06 +0200, Jaroslav Kysela wrote:
> Opinions (except that we should learn users to use "logical 
> identification" not card numbers)? 

ALSA device naming is a constant FAQ.  There's no document anywhere that
explains the syntax or even basic things like 'apps should always use
"default" device', '"default:x" can be used to address the second card',
that cards can be addressed by name, etc.  Look at how many apps only
enumerate the hw:x devices.

One paragraph of documentation on device naming could greatly reduce
user confusion and improve the level of ALSA support in applications.

I think a great start would be to write up Takashi-san's answers to
Daniel Yek in the recent thread.

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
