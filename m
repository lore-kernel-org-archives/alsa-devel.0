From: Denis Sbragion <d.sbragion@infotecna.it>
Subject: Re: Minor Revo Bug
Date: Wed, 22 Oct 2003 09:44:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.1.20031022094429.033682a0@pop3.infotecna.lcl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello Mark,

At 15.06 21/10/2003 +0100, you wrote:
> >The left front channel is always mute when the M-Audio Revolution
> >(ice1724) driver is started/restarted with all mixer settings saved
> >on exit. The other channels are fine.
>
> >Moving the DAC volume slider in alsamixer unmutes this channel.
>
>I should add:
>
>1) This bug does not exist in version 0.9.6, so it probably has
>    something to do with the recent bug fixes in ice1724?
>
>2) Volume settings are restored correctly in alsamixer on startup but
>    the left front channel is mute until the DAC volume slider is moved
>    up or down.

may be this could help: this exact same thing happens also with the 
Terratec EWX 24/96 (ice1712), but on the right channel. This small quirk is 
lasting since 0.9.0rc5 with the EWX. I tryed to find the source of the 
problem myself, but I've never been hable to indentify a real bug, either 
in the driver or in alsactl.

Bye,
--
	Denis Sbragion
	InfoTecna
	Tel: +39 0362 805396, Fax: +39 0362 805404
	URL: http://www.infotecna.it



-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
