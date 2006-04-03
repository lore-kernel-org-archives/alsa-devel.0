From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ice1712 overwrite standard midi port names
Date: Mon, 3 Apr 2006 22:45:58 +0100
Message-ID: <200604032240.29121.gineera@aspect135.co.uk>
References: <200604012206.27893.gineera@aspect135.co.uk> <s5hhd5aa9mp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhd5aa9mp.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 03 April 2006 17:47, you wrote:
> At Sat, 1 Apr 2006 22:06:27 +0100,
>
> Alan Horstmann wrote:
> > Following our discussions I had time to prepare this patch for ice1712
> > driver. I figured you prefered the minimum changes to achieve the end
> > result.  The replacement names in ews.c are left as I prefer, 'detail,
> > card', but if you choose, just reverse the order, to comply instead with
> > convention.  How does this proposal look?
>
> I don't think -0 and -1 suffix are necessary.  You give the individual
> name for each device, so they must be unique as they are.

True, however I included them for the following reasons:-
  a)  The default name in mpu401...new has the 2 numbers with a hyphen, so 
there is consistency making it clearer what they refer to.
  b)  If only a single number were used, there would need to be some extra 
characters to say that it refered to the card number, not device, eg c-1 or 
card-1.  Firstly this doesn't save space, and secondly trips over the problem 
of whether (to an inexperienced user) the first card is card-1 or card-0.  
Putting the number pair together seemed to be more likely to be understood as 
a system-type code, starting at zero.
  c)  It records somewhere to users (not reading the source-code) which device 
is connected to each of the name strings.
  d)  There seemed to be no overriding reason to leave them out.

> Also, could fix the following?
>
> - Use const char * for name strings

Yes, will do.

> - Fix spaces / indentation

Can you be more specific?  Do you mean second half of sprintf brackets?  I can 
only see one unneccesary blank line.  From the patch lines it is probably not 
obvious that the second port lines are indented further due to an extra 'if' 
statement.

> > There are no name entries in _card_info for any card sub-vendors other
> > than DMX6fire.  Perhaps others could add these as appropriate?
>
> Yes.  But not mandatory.  Can be added later.

Fine.

Let me know what you think on these issues and I will fix the patch 
accordingly.

Alan



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
