From: "John W. Cocula" <john@cocula.com>
Subject: Re: any support for realtech sound chip
Date: Thu, 22 Jan 2004 15:11:48 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <65072.138.88.11.209.1074802308.squirrel@cocula.com>
References: <m3llnz25uf.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m3llnz25uf.fsf@ccs.covici.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Covici <covici@ccs.covici.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The Realtek ALC650 rev 3 chip, in my Shuttle SB62G2, is supported by the
intel8x0 driver.

HOWEVER, and I have a headache from it at this very moment, I've just
learned that the driver does not support anything but the front L and R
channels for output.

Can anyone tell me what is involved in evolving the driver so that it will
support all 6 playback channels?  Please someone tell me what I can do to
help make this come to pass!

Many thanks,
John

Now to find some ibuprofen.


John Covici said:
> Hi.  I would like to use a Shuttle An50R which supports the Athlon 64
> under Linux, but their sound chip is an ac97 audio Realtech.  What
> module would support such a beast or is it not possible to use ALSA
> with that chip?
>
> Thanks.
>
> --
>          John Covici
>          covici@ccs.covici.com
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
