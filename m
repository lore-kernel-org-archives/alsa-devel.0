From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: IEC958 plugin and Rate plugin programming
Date: Mon, 13 Feb 2006 09:17:40 +0100
Message-ID: <20060213081740.GB8896@ifiu25.informatik.uni-halle.de>
References: <43EDAE9C.7060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <43EDAE9C.7060808@gmail.com>
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
To: Luca Piccioni <luca.piccioni@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Luca Piccioni wrote:
> My challenge now is to output a stereo 16 bit (LE) @ any Hz to the
> S/PDIF digital output.  Opening the hardware digital output device
> (for me is "hw:0,4") this don't work: probably because I can't send
> linear PCM to this device, right?

Wrong; you can send PCM to this device.  But you better use "iec958:0"
instead of "hw:0,4" because many AC'97 codecs require some mixer
controls to be set for S/PDIF to work, and using hw doesn't do this
automatically.

> Ok, I've seen a IEC958 plugin... it does conversion between linear PCM
> to IEC958 Subframes, right?

Right.  But you'd need this only for sound cards that cannot put PCM
data into subframes by themselves.  Such stupid chips are made by CMI
and ATI, but my crystall ball says you're using snd-intel8x0.


What is the actual problem?


HTH
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
