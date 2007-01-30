From: Tim <terminator356@users.sourceforge.net>
Subject: Re: Need help: My .asoundrc no longer works.
Date: Tue, 30 Jan 2007 23:23:50 +0000 (UTC)
Message-ID: <loom.20070131T000358-219@post.gmane.org>
References: <loom.20070120T001557-202@post.gmane.org>
	<s5hbqkrf96d.wl%tiwai@suse.de>
	<loom.20070126T022638-883@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

Tim <terminator356 <at> users.sourceforge.net> writes:
> 
> Takashi Iwai <tiwai <at> suse.de> writes:
> > It's way too old to debug...  Please try the latest version,
> > 1.0.14rc2, at first.
> 
> I installed alsa 1.0.14rc2, but now the situation is worse.
> Now multi refuses to work at all no matter what I try in
>  .asoundrc

Sorry, it turns out that in fact I am getting the same
 results as under alsa-1.0.12.
My multi DOES work, but refuses to record any sound from the
 second slave, no matter whether I make the second slave emu10k1 or 
 the ice1712.
Even with LIBASOUND_DEBUG=1, there is no indication of any trouble
 during arecord. arecord will happily record all channels in the
 multi - but examination of the resulting raw files shows complete
 silence is recorded from ALL of the second slave's channels.
Alsa is 'quietly' having trouble somewhere, without reporting any error. 

I am currently deep into the alsa-driver code, inserting printk
 'checkpoints' to try and find out what's happening.

So, while I do that, is any one else having these troubles?
Any ideas, Takashi?
Thanks. Tim.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
