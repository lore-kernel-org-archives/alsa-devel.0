From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: [linux-audio-user] Evolution UC16 problems, modules.conf for
 usb-midi and usb-audio together
Date: Wed, 23 Oct 2002 04:06:42 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB5A1C2.4030708@boosthardware.com>
References: <1035239386.4549.73.camel@hamish.iriXx.org> <3DB57DD6.8070303@boosthardware.com> <3DB59381.5000007@iriXx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

iriXx wrote:
> hi Patrick,
> 

I have forwarded this to the devel list. To subscribe please visit this 
link.

http://lists.sourceforge.net/lists/listinfo/alsa-devel

> thanks so much... this will improve things wonderfully not just for the 
> Evolution but for my quattro as well... i had assumed that in rc3 the 
> midi interface for the quattro wasnt implemented.... i shall give cvs a 
> try straight away, as this is part of a review for a uk magazine...
> 
> could you give me the address for subscribing to alsa-devel? i would be 
> happy to test and report back...
> 
> the problems i've had with modules.conf are in adding support for the 
> two cards - which of course wont be necessary with the cvs version...
> i shall ask again on alsa-devel if i have any more problems...
> 

There are some changes that need to be made regarding the modules.conf 
file and the options for the driver. Specifically all snd_xxx references 
have been changed to just xxx. Ie remove the snd_ prefix. This has been 
done to ensure the alsa modules options are inline with the Kernel 
standard. NB this is completely seperate from the module name which is 
snd-xxx. That has not been changed.

Interestingly enough we are in the process of debating how and what to 
do about getting more articles published on Linux Audio. If you want any 
  second opinions on the article before it is published I am happy to 
have a look at it.

Please let us know when you publish it too.

Also could you send your modules.conf file in the next post so we can 
see what you are doing to load the modules.

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
