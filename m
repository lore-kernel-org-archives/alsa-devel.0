From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: [PATCH] cs46xx DAC volume's mechanism rewrite, minor bugfixes
Date: Fri, 15 Nov 2002 13:33:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021115123318.GA1479@idefix.fvdpol.home.nl>
References: <3DCEB5A4.4090600@cucumelo.org> <200211101455.51202.gte733z@prism.gatech.edu> <20021115120255.GA1114@idefix.fvdpol.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20021115120255.GA1114@idefix.fvdpol.home.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank van de Pol <fvdpol@home.nl>
Cc: Weijia Yang <gte733z@prism.gatech.edu>, Benny Sjostrand <gorm@cucumelo.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 15, 2002 at 01:02:55PM +0100, Frank van de Pol wrote:
> On Sun, Nov 10, 2002 at 02:56:35PM -0500, Weijia Yang wrote:
> > 
> > Thanks for working on this issue Benny.  I tried out the code but the bass 
> > issues still persists.  As before, unbalancing the left and right channels 
> > brings the bass back.  Thanks
> > 
> 
> Are you suggesting that one of the channels might phase reversed? Do you
> have any idea if the bass attuniation is stronger at a specific frequency?

I just had a thought after sending previous message.

can you phase reverse one of the channels and let us know the way your
behaviour changes?

eg. pressing phase-reverse switch on on of the channel strips on your mixing
desk, or changing polarity at one of the speaker cables.

Does the 'lack of bass' phenomena exists for data played through the pcm
(wav, mp3 etc.) or also for analog sources (eg. CDROM audio, line input)?

Frank.

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
