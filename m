From: "Jan \"Evil Twin\" Depner" <eviltwin69@cableone.net>
Subject: Re: SoundCard compatibility question
Date: 20 Mar 2003 15:10:42 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048194643.6927.11.camel@eviltwin>
References: <002101c2ef22$0f249f20$0100a8c0@Pblaptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <002101c2ef22$0f249f20$0100a8c0@Pblaptop>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pete Barnard <petebarnard@tiscali.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

That card may not even be full duplex.  For a very cheap, compatible
card you can use an Ensoniq Audio PCI.  This is 16 bit 48KHz.  I've done
some decent two channel recording with one of those.  There are a couple
of decent two channel 24 bit 96KHz cards based on the envy24 chipset
that run about $130 to $180 US at musician's Friend.  Here are a couple
of examples.

http://www.musiciansfriend.com/srs7/sid=030320132900024117199122901257/search/g=live/detail/base_id/52845

http://www.musiciansfriend.com/srs7/sid=030320132900024117199122901257/search/g=live/detail/base_id/52399


If you need more than two channels I would recommend the Delta 44 or 66
(again, envy24 chipset which I highly recommend).

http://www.musiciansfriend.com/srs7/sid=030320132900024117199122901257/search/g=live/detail/base_id/52398

http://www.musiciansfriend.com/srs7/sid=030320132900024117199122901257/search/g=live/detail/base_id/52397


Hope that helps.


Jan


On Thu, 2003-03-20 at 14:48, Pete Barnard wrote:
> I have just installed Red Hat Linux 7.3 on my pc at work and will be installing the ALSA drivers.  However, the sound card is described as a "SoundMax integrated Audio" (I don't really know much about this card and cannot find it on the ALSA soundcard matrix).   I have read that it is a SoundBlaster compatible card but I haven't had this confirmed.  Does anybody have any suggestions as to how I would get ALSA to work with this card? for example, what lines do I need to put in the /etc/modules.conf file? and what options do I need to type when I do a ./configure for the drivers? Are there any external drivers that I need to download etc?
> 
> Failing all this - will I have to replace it with another card that is listed on the ALSA soundcard matrix ??
> 
> Regards,
> 
> Pete




-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
