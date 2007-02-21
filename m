From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: why would i *not* be able to update a register in
 ac97#0-0+regs when it's read write?
Date: Wed, 21 Feb 2007 08:29:05 +0100
Message-ID: <1172042945.16851.1175709177@webmail.messagingengine.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF896@sea-exch-01.na.corp.dmxmusic.co
	m> <75b66ecd0702161724ncd340a8o1feea138fa98963c@mail.gmail.com>
	<F8FB97052F1BEF409F7842E960E49B5AAAF897@sea-exch-01.na.corp.dmxmusic.
	com> <75b66ecd0702161801l3e1492c3j37e001bbf57eaac9@mail.gmail.com>
	<F8FB97052F1BEF409F7842E960E49B5AAAF899@sea-exch-01.na.corp.dmxmusic.
	com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <F8FB97052F1BEF409F7842E960E49B5AAAF899@sea-exch-01.na.corp.dmxmusic.co
	m>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: John Utz <John.Utz@dmxmusic.com>, Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Nothing changed, i can still write to many registers but not the 1 that i
> am attempting to change: 60h UAJ Control; Does the '(Page ID = 00h)'
> alter how i need to access the register?

Yes, you have to set the correct page in the Audio Interrupt and Paging
register (24h); see the AC97_PAGE_* defines in ac97_codec.h.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
