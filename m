From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio in ALSA 0.9.0rc5
Date: Thu, 14 Nov 2002 11:52:42 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211141150160.21074-100000@studcom.urz.uni-halle.de>
References: <200211140034.17681.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200211140034.17681.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pedro Lopez-Cabanillas wrote:
> alias snd-card-1 snd-usb-audio
> alias snd-card-2 snd-usb-audio
> options snd-usb-audio index=1,2 vid=0x0763,0x0582 pid=0x1110,0x0005
>
> I don't know if there is a better way,

I created the vid/pid parameters for exactly this case.

> and i'm not sure if it shall work for OSS rawmidi also.

ALSA and OSS card numbers are the same for all devices, and the index
parameter works with all drivers (with snd-virmidi too).


HTH
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
