From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Line6 USB driver in ALSA?
Date: Tue, 28 Feb 2006 08:35:36 +0100
Message-ID: <20060228073536.GB4158@turing.informatik.uni-halle.de>
References: <200602261207.31050.grabner@icg.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200602261207.31050.grabner@icg.tu-graz.ac.at>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Markus Grabner <grabner@icg.tu-graz.ac.at>
Cc: alsa-devel@lists.sourceforge.net, rlrevell@joe-job.com
List-Id: alsa-devel@alsa-project.org

Markus Grabner wrote:
> The driver I wrote registers the POD devices as a soundcard, therefore the PCM 
> portion would perfectly fit into ALSA. Moreover, POD parameters are 
> controlled via ALSA's MIDI interface, commands are translated to USB (the 
> devices also have a MIDI port, which can be accessed with the standard raw 
> MIDI driver, but PCM is not available via MIDI).
> However, I'm not so sure if other features of the driver are within the scope 
> of ALSA. These include
> *) a set of files registered under /sys/bus/usb/drivers/... to allow access to 
> the current states of the POD/Variax model parameters (as ASCII numbers)

AFAICS those parameters could be handled by a userspace application that
handles some MIDI messages.

> *) a method to access all parameters of a single or multiple models as a 
> binary block of data

ditto

> *) a guitar tuner

How does its interface look like?

> *) and some more features not immediately related to audio

It might make sense to put them into the same driver if they're handled
through the same USB interface.


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
