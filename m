From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Re: [linux-audio-user] Evolution UC16 problems, modules.conf for usb-midi and usb-audio together
Date: Wed, 23 Oct 2002 13:03:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021023110337.GB515@tuba.home>
References: <1035337793.2875.116.camel@hamish.iriXx.org> <Pine.HPX.4.33n.0210231130360.10224-100000@studcom.urz.uni-halle.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0210231130360.10224-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 23, 2002 at 11:50:37AM +0200, Clemens Ladisch wrote:
> And you need to say which driver to use for snd-card-1. For the UC16 with
> 0.9.0rc3, it would be
> 	alias snd-card-1 snd-usb-midi
> For 0.9.0rc4, it would be
> 	alias snd-card-1 snd-usb-audio
> 


It would be better to add this module name change to the rc4 announce lines on
www.alsa-project.org !


martin




-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
