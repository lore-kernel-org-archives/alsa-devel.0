From: Shane Walton <dsrelist@yahoo.com>
Subject: Re: Re: RME9636 ADAT1 Recording
Date: Tue, 24 Sep 2002 09:27:46 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020924162746.166.qmail@web20802.mail.yahoo.com>
References: <E17tsBx-0004u7-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17tsBx-0004u7-00@usw-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thanks Paul.  I am not sure how I was able to get the
data on channel 0 and 1 with the beta6, but to save
all of us from any more time on this matter, I am
going to have my application just look at channels 16
and 17.  Thanks again for all you help.


--- Paul Davis <pbd@op.net> wrote:
> >Otherwise, if I will be using the alsa-lib plugin
> for
> >striding the channels, would I be better off using
> the
> 
> if you ask for non-interleaved data, there is no
> striding going
> on. the hardware is not interleaved.
> 
> >Intel Performance Primitives (IPP) libraries to do
> the
> >channel striding?  I do want to take advantage of
> the
> >Pentium 4.
> 
> this is a severe optimization that i would spend
> time on *only* after
> the rest of my application was finished and i could
> demonstrate some
> useful gain from doing.
>  
> --p
> 
> 
>
-------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel


=====
Shane M. Walton, Software Engineer
Digital System Resources, Inc.
dsrelist@yahoo.com : swalton@dsrnet.com
703.234.1674

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
