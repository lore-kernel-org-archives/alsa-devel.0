From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: [linux-audio-dev] Major problem with RME HDSP/Multiface and a
 64-bit AMD laptop
Date: Sun, 21 Mar 2004 13:00:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040321130034.6fd0ff52@laptop>
References: <20040320053504.PWNE22400.smtp2.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040320053504.PWNE22400.smtp2.fuse.net@64BitBadass>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>
Cc: ico@fuse.net, george@synthax.com, support@synthax.de, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 20 Mar 2004 00:35:02 -0500
"Ivica Ico Bukvic" <ico@fuse.net> wrote:

> First off I would like to extend my sincere apologies for my atrocious
> cross-posting. I am currently in a rather desperate situation and
> would highly appreciate any help I can get in this matter.
> 
> <Begin long blurb>e

wait ... this seems to be similar to the problem i have with my hdsp ...
i can't run it on my linux system at all, althouth it works fine with
windows xp:

can you try jack as super user with -R flag?

if you use an input signal, some of the input gets copied to the output
if a sound application is running, which results some distortion ...
could you start jack / pd, and try to use any of the input channels try
several settings of hdspmixer... 

the problem with my hdsp is definitely a cardbus driver issue ... from
what i heard from people who tried to help me is, that there are some
problems in mapping the memory from the kernel to the buffer inside the
cardbus bridge ...
the problem with the kernel driver for the yenta socket is, that it's
not properly supported ... thomas charbonnel, who maintains the hdsp
driver and i wrote a message to both the kernel and the pcmcia-cs
mailing-list, but didn't get any answer...

of course, it could be a problem of the cardbus controller hardware,
that the windows driver may handle differently than the yenta-socket
module for linux my machine has an o2micro cardbus controller, that,
conserning rme's support may produce problems ... 
i'm able to sell my notebook to my mother ;-) and get a new one, soon...
the only reason, why i won't get an amd64 is that the notebooks that are
equipped with this chip, have either ene or ricoh cardbus controllers,
controllers rme warns against ... that's why i'll order a p4 inspiron,
soon...

anyway, when i talked to thomas a short time ago, he considered going to
the lad conference, i'll go there, and concerning the schedule, you'll
be there, too ... maybe we could try to track this problem down and try
to contact the kernel mailinglist again...

i hope that you will be more luck than i was ...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
