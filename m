From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Fix for SPAM?
Date: Thu, 22 Feb 2007 09:44:45 +0100
Message-ID: <45DD57FD.8000204@gmail.com>
References: <s5hmz39rt2y.wl%tiwai@suse.de> <45DB44F9.9080001@gmail.com>
	<1172043403.17395.1175709503@webmail.messagingengine.com>
	<45DC5B1A.5090100@gmail.com>
	<Pine.LNX.4.61.0702220827300.9439@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0702220827300.9439@tm8103-a.perex-int.cz>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 02/22/2007 08:39 AM, Jaroslav Kysela wrote:

> On Wed, 21 Feb 2007, Rene Herman wrote:

>> [ ... ] without anything actually having been done.
>>
>> Jaroslav: should the list be moved to vger, assuming they wouldn't mind
>> hosting it?

[ reorder ]

> For immediate solution, I would suggest to moderate list (but I 
> haven't time to do it) so I'm asking here for an volunteer (or 
> volunteers). I will send them the list administration password on
> SourceForge.

Ah, goddamnit, you people tricked me! ...

Due to similar contraints I wouldn't have time to do this indefinitely 
but the "few weeks" you speak of below I can do.

Must say though -- if a solution will be in place within those few weeks 
(or earlier, also see below) then I guess we might also just sit it out. 
It's been this way for quite some time now and personally I'm not a big 
fan of moderated lists due to the inevitable delays.

Obviously also not a big fan of the current state of alsa-devel as a 
spam collector so if people want, I volunteer for those few weeks. Am 
not familiar with how this works; Clemens said the old server was the 
meat of the problem. Is there a chance to only do those? So that only 
the mail coming in through this "suspicious route" would be subject to 
the moderation delay?

Rest of the mail:

> It's not a problem for me to move lists (I would prefer to let people
> resubscribe to filter the "dead" subscribers).

Agree.

> But, I would like really to keep the universal e-mail address like 
> alsa-devel@alsa-project.org rather than alsa-devel@vger or 
> alsa-devel@sourceforge....).

I can sympathise with that.

> Actually, the old ALSA server cannot be configured to filter e-mails
> using spam-assassin (the hardware simply cannot handle it) and SF
> appearently uses sender verification (it does not accept e-mails from
> hosts not having SMTP server installed and with broken SMTP HELO
> hostnames).

There might be another possibility -- I could try to get you setup with 
nl.linux.org, the same server that runs kernelnewbies (website and ML).

kernelnewbies is spam free (it's run by Rik van Riel) and the ALSA lists 
   aren't so busy they'd impose a significant extra load on the server. 
I suspect the server admins would be okay with hosting the alsa lists 
and probably with being a primary MX for alsa-project.org so that the 
generic names would still work fine; am I correct in believing this 
would be what you'd want/need to keep the generic alsa-project.org names 
going?

Or vger after all, if they wouldn't mind the same...

> If everything happens well, I will switch the ALSA server to a XEN
> virtual server with Spam-Assassin in few weeks. So the possibility to
> filter out spams will be greatly increased.

Okay. So, here's what I would prefer in decreasing order of preference.

1. move the list to vger
2. move the list to nl.linux.org
3. sit it out until you've got the Xen VM setup
4. moderate the mail coming in through the old server until 3
5. moderate everything until 3

If you'd like 1 or 2, I'll start pinging people there. I expect I should 
be able to get nl.linux.org setup. As said, if needed I can do 4 or 5.

Certainly can do 3...

Rene.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
