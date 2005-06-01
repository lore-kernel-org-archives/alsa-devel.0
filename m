From: Ferenc Wagner <wferi@tba.elte.hu>
Subject: Re: Creative SB Live 24bit capture status
Date: Wed, 01 Jun 2005 13:45:15 +0200
Message-ID: <3o8y1ui9mc.fsf@tba.elte.hu>
References: <ad2655cb0505270652272abfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <ad2655cb0505270652272abfb@mail.gmail.com> (James
 Courtier-Dutton's message of "Fri, 27 May 2005 14:52:28 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton <james.dutton@gmail.com> writes:

> I am pleased to announce that Creative have finally sent
> me some information regarding how to enable capture on the
> SB Live 24bit sound card.
>
> I will hopefully be adding support for it to alsa either
> this weekend or next.

Hi James,

thanks for the work, I'm looking forward to exploiting one
such card.  However, the comments in ca0106_main.c confused
me somewhat.  Let me quote:

,----
| Notes on how to capture sound:
| The AC97 is used in the PLAYBACK direction.
|
| The output from the AC97 chip, instead of reaching the
| speakers, is fed into the Philips 1361T ADC.
|
| So, to record from the MIC, set the MIC Playback volume to
| max, unmute the MIC and turn up the MASTER Playback
| volume.
|
| So, to prevent feedback when capturing, minimise the
| "Capture feedback into Playback" volume.
'----

First of all, the above sounds like this card wasn't full
duplex, which probably isn't the case. (?)

Apart from that, there are no MIC or MASTER controls, only
ANALOG/SPDIF Front/Rear/Center/Unknown (without mute
toggles), several recording source selectors (AC97, SPDIF,
I2C, I2C Mixer, whatnot), the Capture feedback and a
Mic/Line in selector.  How should I set all these up,
especially what source should I set 'capture' on?
-- 
Thanks a lot,
Feri.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
