From: Marco Canini <m.canini@libero.it>
Subject: Re: Support for realtek alc 655
Date: 01 Sep 2003 20:23:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062440613.538.3.camel@jabawack.canini.org>
References: <1062413496.526.4.camel@jabawack.canini.org>
	 <3F532F72.208@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F532F72.208@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-09-01 at 13:37, James Courtier-Dutton wrote:
> Marco Canini wrote:
> > hi,
> > 
> > i'm moving to buy a new mother board: gigabyte 8knxp.
> > it has integrated an audio ac97 codec chipset by realtek: alc655
> > i searched in the sound cards matrix and i couldn't find it so i surfed
> > the web for any kind of support for it in linux but i found nothing.
> > from what i see in the ac97 support code the alc650 is supported but no mention to alc655.
> > is this chipset supported by alsa?
> > 
> > thanks
> We have the specs for the chip, so supporting it should not be too much 
> of a problem. See the nice PDF files from realtek web site :-) .
> 
> If you get the motherboard, I could work with you to get it working.
> It looks very similar to the alc650, which is already supported, so the 
> work involved whould not be too much. I an fairly sure that all that 
> would need doing is to add recognition for the chip in ac97_codec.c and 
> then program it exactly the same as the alc650. Some of the extra 
> functions of the alc655 might not be supported, but you will get 5.1 
> channel sound output and be able to record. You just might not be able 
> to select all the different combinations of sound in/out jacks.
> 
> Cheers
> James
> 
Hi,

it would be cool. just another question before i go to buy: does the
ac97 code support hw multiplexing aka multiple playing for the alc650
dsp?

thanks
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Marco Canini <m.canini@libero.it>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
