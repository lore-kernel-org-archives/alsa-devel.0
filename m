From: David Greaves <david@dgreaves.com>
Subject: Re: [Alsa-user] USB card @48kHz only: at what layer
 to	resample?
Date: Mon, 25 Sep 2006 21:51:17 +0100
Message-ID: <45184145.3010001@dgreaves.com>
References: <J63PIH$040EF5CF6AFFDBCB31B65DEC3272A191@libero.it>	<Pine.LNX.4.61.0609240755230.27883@info.physics.ubc.ca>
	<1159117628.2899.17.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1159117628.2899.17.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, Bill Unruh <unruh@physics.ubc.ca>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Sun, 2006-09-24 at 08:12 -0700, Bill Unruh wrote:
>> This is audio card insanity. All CDs are at 44100 but for some reason
>> many card manufacturers designed their cards to run at 48000. This is
>> a real problem since this requires rate conversion. Rate conversion is
>> in general a very very noisy operation. In particular simple linear
>> interpolation, which is quick, is also really really terrible for
>> sound quality.
>>
> 
> DVDs use 48000.  But I seem to recall vendors shipping 48Khz-only cards
> before playing DVD on a computer was common...
> 
> Lee

Wasn't it DAT that set the standard at 48000 - and CDs were made incompatible at
44.1 kHz to prevent digital copying...

David


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
