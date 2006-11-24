From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: [PATCH 1.0.13 1/2] M-Audio USB
Date: Fri, 24 Nov 2006 21:46:25 +0100
Message-ID: <20061124214625.ast54wrgys8ocg4c@webmail.supelec.fr>
References: <45667692.8090600@inbox.ru> <s5hfyc9f3i6.wl%tiwai@suse.de>
	<45674CC0.3080002@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45674CC0.3080002@inbox.ru>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Pavel Polischouk <pavelvp@inbox.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>> Interresting, it seems to be enough to reset each interface just before
>> setting it again. As far as I remember, the windows driver first reset all
>> interfaces in a row before resetting the ones that correspond to the user
>> mode selected.
> I know this is an overkill. But it WorksForMe (TM). I can look at moving
> this reset into a place where it is called only once per interface.

If it works, I don't see why you would have to change this.
Your way has, moreover, the advantage to keep M-Audio specific code  
inside the 'quirk' function.

I'll give you my feedback for the Audiophile device Asap.

Thanks for your work,
Thibault



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
