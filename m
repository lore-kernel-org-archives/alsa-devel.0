From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Re: Creative SB Live 24bit capture status
Date: Wed, 1 Jun 2005 14:23:52 +0100
Message-ID: <ad2655cb050601062373bd611c@mail.gmail.com>
References: <ad2655cb0505270652272abfb@mail.gmail.com>
	 <3o8y1ui9mc.fsf@tba.elte.hu>
Reply-To: James Courtier-Dutton <james.dutton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3o8y1ui9mc.fsf@tba.elte.hu>
Content-Disposition: inline
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

On 6/1/05, Ferenc Wagner <wferi@tba.elte.hu> wrote:
>=20
> Hi James,
>=20
> thanks for the work, I'm looking forward to exploiting one
> such card.  However, the comments in ca0106_main.c confused
> me somewhat.  Let me quote:
>=20
> ,----
> | Notes on how to capture sound:
> | The AC97 is used in the PLAYBACK direction.
> |
> | The output from the AC97 chip, instead of reaching the
> | speakers, is fed into the Philips 1361T ADC.
> |
> | So, to record from the MIC, set the MIC Playback volume to
> | max, unmute the MIC and turn up the MASTER Playback
> | volume.
> |
> | So, to prevent feedback when capturing, minimise the
> | "Capture feedback into Playback" volume.
> '----
>=20
> First of all, the above sounds like this card wasn't full
> duplex, which probably isn't the case. (?)
>=20
> Apart from that, there are no MIC or MASTER controls, only
> ANALOG/SPDIF Front/Rear/Center/Unknown (without mute
> toggles), several recording source selectors (AC97, SPDIF,
> I2C, I2C Mixer, whatnot), the Capture feedback and a
> Mic/Line in selector.  How should I set all these up,
> especially what source should I set 'capture' on?
> --
> Thanks a lot,
> Feri.
>=20

Those notes relate to the Audigy LS.
The SB Live 24bit uses a different method for capture, which is one of
the reasons it has taken so long to get it working.

James


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
