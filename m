From: Tom Watson <sdc695@yahoo.com>
Subject: Re: Envy24HT mixer restore problem with M-Audio Revolution 7.1 + Alsa
Date: Tue, 13 Apr 2004 18:32:43 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040414013243.92001.qmail@web60803.mail.yahoo.com>
References: <E1BDQkh-0004Je-U3@sc8-sf-list2.sourceforge.net>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1BDQkh-0004Je-U3@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> Message: 1
> Date: Mon, 12 Apr 2004 20:24:14 -0700
> From: Stephen Hassard <steve@hassard.net>
> To:  alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] Envy24HT mixer restore problem with M-Audio
> Revolution 7.1 + Alsa
>  1.0.4
> 
> Hi there,
> 
> I've got an Envy24HT based M-Audio Revolution 7.1 and have a issue
> with 
> Alsa 1.0.4.
> 
> When I set my 'DAC' and 'DAC1' channels to sane values (they
> correspond 
> to L+R audio) and save my mixer settings via 'alsactl store', reboot
> and 
> restore the settings via 'alsactl restore', my mixer settings appear
> to 
> be normal in alsamixer, but I find that my left channel ('DAC') is 
> mutted until I change the volume of 'DAC'. As soon as I touch the
> mixer 
> for the 'DAC' channel, audio output is restored.
> 
> I didn't notice this a few revisions back, so I think a bug crept in 
> recently ..
> 
> Thanks,
> Steve
> 
> 


I've got an older ALSA (0.9.6) working on Kernel 2.4 that has a similar
problem.  The first load of the level on the left channel seemed to be
inneffective.  I had to do a "different" load before I could get the
level to work properly.  The problem you have seems similar to yours,
and I'd like to know the solution.  It looks like the problem has been
around for a while (or has come and gone).  I haven't updated the
application using the Revolution 7.1 since ALSA 0.9.6, so I await the
results of the "problem" and its resolution.

I wish you luck.


=====
-- 
Tom Watson
tsw@johana.com


	
		
__________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online by April 15th
http://taxes.yahoo.com/filing.html


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
