From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: Re: Creative Mp3+ USB and SPDIF passthrough
Date: Tue, 11 Nov 2003 13:09:43 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031111120943.54274.qmail@web12203.mail.yahoo.com>
References: <3FB0C937.30401@update.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FB0C937.30401@update.uu.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Lars_Hagström <lars@update.uu.se> schrieb: > Hi,
> 
> I've sent this mail once before, but since I've received
> no response I 
> send it again (only this once, I wont keep spamming...).
> 
> I've scoured the net, the alsa-user list and this mailing
> list for
> information about how to enable AC3/DTS passthrough on
> the S/PDIF
> connector on my new Creative Mp3+ USB box.
> The only thing I've been able to find is a vague
> reference saying
> something that spdif passthrough is not available in
> usb-audio. Is this
> the truth? If it is the truth, will it remain so forever,
> or is anyone
> working on it?
> If it is not true, what am I doing wrong? I can get
> regular stereo
> output on the digital out. I've got the box set to
> digital only, which
> I've worked out is a requirement in windows. I have tried
> playing stuff
> both with "aplay -Dspdif" (is this correct?)  and with
> "mplayer -ac hwac3".
Its not true:
you can of course output to (input from) spdif on
usb-devices. I think it makes no difference for the driver
wether the hardware outputs to (inputs from) a DAC (ADC) or
SPDIF.

I don't know anything about your device:
maybe the driver isn't yet prepared for that feature?
Maybe some (device/driver) documentation is missing?

> 
> Would be very grateful for any help, since the
> passthrough was really
> the reason I bought the gadget, and I may be returning it
> if it's not
> going to work now or any time soon...
> 
> If someone is working on support for this I would be more
> than willing
> to help in testing it. I can not volunteer to actually
> develop it
> myself, since I've never worked on anything thats even
> closely related
> to this stuff. But I will gladly help anyone who's
> trying!
> 
Karsten

__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Logos und Klingeltöne fürs Handy bei http://sms.yahoo.de


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
