From: m <m@iriXx.org>
Subject: Re: Re: [linux-audio-user] Evolution UC16 problems,
	modules.conf for usb-midi and usb-audio together
Date: 23 Oct 2002 21:17:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1035404247.4407.1.camel@hamish.iriXx.org>
References: <Pine.HPX.4.33n.0210231352020.18156-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0210231352020.18156-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2002-10-23 at 14:00, Clemens Ladisch wrote:

> I assumed that you wanted to use a Quattro and a UC16 together. In this
> case, you need one entry for each card, although they're handled by the
> same driver.
> 
> The snd-card-x entries are used for autoloading: when you try to access
> PCM device hw:x,y and this device doesn't yet exist, ALSA knowns that it
> should load the driver specified by snd-card-x.

thanks, that helps a lot... as you can guess i'm new-ish to working with
alsa although not so new to linux sound...

bw
m
-- 
iriXx
www.iriXx.org

copyleft: creativity, technology and freedom?
info@copyleftmedia.org.uk
www.copyleftmedia.org.uk

 _
( )  ascii ribbon against html email
 X
/ \    cat /dev/sda1 > /dev/dsp


  *** stopping make sense ***



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
