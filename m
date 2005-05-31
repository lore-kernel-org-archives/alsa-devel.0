From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Plugin for XMMS2. Help wanted.
Date: Tue, 31 May 2005 13:48:52 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505311333490.7269-100000@studcom.urz.uni-halle.de>
References: <A633824F-4FB6-446B-9C39-26F315518B3A@xmms.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <A633824F-4FB6-446B-9C39-26F315518B3A@xmms.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Tobias_Rundstr=F6m?= <tru@xmms.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tobias Rundstr=F6m wrote:
> This is a call for help. We would like a senior ALSA developer look
> at our plugin and give us advice (or even write the code himself).

I guess the second value in the rates array should be 11025 and not
12025.

The default value for mixer_dev should be "default" and not "hw:0".

Without the SND_PCM_NONBLOCK flag, the snd_pcm_open call will block
until the device is available instead of returning an error.  If you
add this flag, call snd_pcm_nonblock(..., 0) afterwards to make sure
that the later write calls will block. write ca

I didn't find any other obvious issues.

> We had fairly hard time trying to figure out how to use the API
> and cope with all error handling.

It isn't obvious what happens when there is an unrecoverable error
(if, e.g., a USB device gets unplugged).  I guess in such a case XMMS
should stop playing, but it seems xmms_alsa_write cannot actually
signal an error.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=3Doffad-ysdn-ostg-q22=
005
