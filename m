From: Mark Hubbard <mark@egghead.free-online.co.uk>
Subject: Re: Minor Revo Bug
Date: Tue, 21 Oct 2003 15:06:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031021140600.GA8559@rhubarb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

>The left front channel is always mute when the M-Audio Revolution
>(ice1724) driver is started/restarted with all mixer settings saved
>on exit. The other channels are fine.

>Moving the DAC volume slider in alsamixer unmutes this channel.

I should add:

1) This bug does not exist in version 0.9.6, so it probably has
   something to do with the recent bug fixes in ice1724?

2) Volume settings are restored correctly in alsamixer on startup but
   the left front channel is mute until the DAC volume slider is moved
   up or down.


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
