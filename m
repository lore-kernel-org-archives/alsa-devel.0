From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Subject: HDA Realtek
Date: Tue, 10 May 2005 22:41:16 +0200
Message-ID: <20050510204116.GA30795717@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello,

I have Realtek ALC880 HDA audio in my laptop.

I wonder whether following is a bug or feature.

1) When headphones are plugged in, headphone volume control does nothing
2) toggle mute/unmute always results in 0% master volume (even when befor=
e mute
it was about 64%)

Feature requests:
In windows, I can toggle between headphone output and 2 channels output
(I supose that headphone output results higher output gain as headphones =
even
with master volume to 100% are a lot quite)

If I understand correctly Intel's specification, then HDA codec should co=
ntain
2 plaback devices. Is it supported by HDA driver?

--=20
Luk=E1=B9 Hejtm=E1nek


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
