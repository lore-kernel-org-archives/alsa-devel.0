From: Anthony <avan@uwm.edu>
Subject: Re: ice1712 noise
Date: Thu, 5 Feb 2004 00:50:09 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040205065009.GA30274@ice_nine.wi.rr.com>
References: <Pine.LNX.4.58.0401311125130.1876@pnote.perex-int.cz> <20040131195752.GA4224@ice_nine.wi.rr.com>
Reply-To: avan@uwm.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040131195752.GA4224@ice_nine.wi.rr.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anthony <avan@uwm.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

* Anthony <avan@uwm.edu> [Jan 31 04 14:43]:
> * Jaroslav Kysela <perex@suse.cz> [Jan 31 04 13:16]:
> > It looks like that something is wrong with DACs.                            
> > Does the noise occur on all outputs?                                         
> >                                                                              
> >                                       Jaroslav                               

FWIW, the crackling noise was due to my NIC. I hadn't
noticed it before since my bandwidth was recently 
increased by my ISP. I guess its a good thing in some 
way.

I'm still getting some bizarre behaviour when running
an ardour session recorded at 44.1Khz. Occasionally
I get a pop and envy24control shows the output levels
constantly maxed out. This doesn't make sense to me
since jack should of already opened the device and is
writing silence. I vaugely remember this being a problem
when I first got the card that eventually disappeared.
That, or I haven't been doing much of anything at 44.1
to notice.

--ant


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
