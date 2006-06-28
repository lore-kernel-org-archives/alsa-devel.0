From: Tom Watson <sdc695@yahoo.com>
Subject: Re: Make wav the default for speaker test
Date: Wed, 28 Jun 2006 14:22:11 -0700 (PDT)
Message-ID: <20060628212211.73593.qmail@web60824.mail.yahoo.com>
Reply-To: tsw@johana.com
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

James Courtier-Dutton wrote:
> 
> Lee Revell wrote:
> > I think it's nicer to have the sampled voice be the default for
> > speaker-test.  Any objections?
> >  
> <<<Deletia (patch)>>>
> 
>
> What about people who don't speak English?
> "Pink" is the international language. ;-)

While having spoken words for channel assignments IS laudable, sometimes the
correspondence can be off.  Sometimes INTENTIONALLY one plugs the speakers in a
different way.  It also can be changed by various mapping schemes.  The
correspondence for channels over 8 is WAY up in the air, and some sound cards
DO have more than 8.

When this was put in, various people suggested many identification schemes.  I
remember a debate or some such.  I don't believe much was decided by the group,
only the author of the updates.

As for the various languages, I will note that the printout of the speaker test
is currently in English (has anyone internationalized it?), so having the
spoken words probably won't hurt anyone.

I built up my own "speaker identification" 'wav' file, that repeated
simultaneously the speaker name for each channel.  It was a bit easier when
fiddling around with mixer controls because you didn't need to wait for the
sequence to roll around to the speaker you were testing.  You could also go to
the speaker and listen to find out the proper thing.  In that case, having the
identifier 'spoken' was a great helper.

As for me, I can always use the switch.  Have the default any way you want :-)




-- 
Tom Watson
tsw@johana.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
