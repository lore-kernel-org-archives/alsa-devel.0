From: ljp <ljp@llornkcor.com>
Subject: Re: porting oss app to alsa
Date: Thu, 30 Jan 2003 07:46:43 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301300746.43506.ljp@llornkcor.com>
References: <200301301423.h0UENsG12061@charon.host4u.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301301423.h0UENsG12061@charon.host4u.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thursday January 30 2003 07:29 am, Paul Davis wrote:
> >I am asking this, as the ALSA OSS compat. seems to be getting depreaciated
> > (I dont blame it), and stuck on rc1.
>
> its not deprecated, though many of us would actively discourage anyone
> from writing new applications that use the OSS API. its very important
> for ALSA that it fully and properly supports the OSS API. if it did
> not, it would have been very hard to get linus to accept ALSA as the
> default/standard audio API in the 2.5/2.6 kernel series.
>
> --p
>
> ps. of course, some of us would discourage people from using ALSA
>     as the API too :)))

Well, the reason I asked, is that I am involved with porting Helix stuff to 
arm linux. And someone pointed out yeasterday, that there was no OSS compat 
for his soundcard. So, since I am waiting for stuff to get working again in 
respect to gcc 2.95, I took it upon myself (thinking this was almost trival 
to change a few fucntions from OSS to ALSA) to write some ALSA native device 
functions to give users a choice. This is my first time really digging into 
ALSA API, and I must say, I like what I see. :D

And instead of bothering people with silly questions, 'how do I perform x OSS 
function", I went looking at the docs. The tutroials are very good, but don't 
touch upon some of the more compilcated aspects. It seems maybe there is a 
glossary or something needed for people more familiar with OSS terminology. 

Such as, whats a poll ? The docs state, in a not very clear way, for example, 
for snd_timer_poll_descriptors, 'gets poll descriptors'.. hmm, ok, whats a 
poll descriptor? :D


Although I am thankful for the docs, I think it might be useful to have a one 
page doc outlining the OSS calls..

thanks-
ljp


-- 
My cat's a debugger....

Potter, Lorn, "ljp"
core member / Web Administrator
Project OPIE- the Open Palmtop Integrated Environment
http://opie.handhelds.org 
IRC: irc.freenode.net #opie #opie.de

llornkcor@handhelds.org
llornkcor@helixcommunity.org



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
