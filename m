From: m <m@iriXx.org>
Subject: Re: Re: [linux-audio-user] Evolution UC16 problems,
	modules.conf for usb-midi and usb-audio together
Date: 23 Oct 2002 02:49:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1035337793.2875.116.camel@hamish.iriXx.org>
References: <1035239386.4549.73.camel@hamish.iriXx.org>
	<3DB57DD6.8070303@boosthardware.com> <3DB59381.5000007@iriXx.org>
	<3DB5A1C2.4030708@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DB5A1C2.4030708@boosthardware.com>
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

Patrick Shirkey wrote:

> There are some changes that need to be made regarding the modules.conf 
> file and the options for the driver. Specifically all snd_xxx references 
> have been changed to just xxx. Ie remove the snd_ prefix. This has been 
> done to ensure the alsa modules options are inline with the Kernel 
> standard. NB this is completely seperate from the module name which is 
> snd-xxx. That has not been changed.
> 

hi Patrick, thanks again,

my modules.conf for rc3 was as follows:

# ALSA portion
 alias char-major-116 snd
 alias snd-card-0 snd-usb-audio

## oss/Free portion
 alias char-major-14 soundcore
 alias sound-slot-0 snd-card-0

# card 1
 alias sound-service-0-0 snd-mixer-oss
 alias sound-service-0-1 snd-seq-oss
 alias sound-service-0-3 snd-pcm-oss
 alias sound-service-0-8 snd-seq-oss
 alias sound-service-0-12 snd-pcm-oss
 alias sound-slot-1 audio

so i assume i change only need to change the second line to

alias snd-card-0 usb-audio

or are there more changes necessary? should snd-card-0 stay the same?

> Interestingly enough we are in the process of debating how and what to 
> do about getting more articles published on Linux Audio. If you want any 
>   second opinions on the article before it is published I am happy to 
> have a look at it.
> 
> Please let us know when you publish it too.

certainly - although its not me that is writing the article - i'm
testing the UC16 for a friend, who is writing for Camcorder User
magazine in the UK... we are planning to review the Edirol usb devices
as well, and probably the quattro... so hopefully i will be able to
include more detailed GNU/Linux audio coverage soon.. i will suggest a
few apps... anyone know of an app which would be particularly useful for
live work with a UC-16?... 

i am actually a writer myself too, i'm currently working on a book which
will be an expose of 'digital rights management' technology, strongly
supporting GNU/Linux audio.... you can read more at
http://www.copyleftmedia.org.uk . its not a technical book on audio,
more a musician's answer to Naomi Klein's "No Logo"... to be published
by GNU Press, provisional date Sept. 2003... watch this space...
 
best,

m~
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
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
