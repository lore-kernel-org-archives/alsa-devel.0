From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problems with HDSP Multiface+CardBus
Date: Thu, 12 Jun 2003 15:15:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306121515460.1795-100000@pnote.perex-int.cz>
References: <200306121542.41261.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306121542.41261.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?= <Jaakko.Prattala@Helsinki.FI>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Jun 2003, Jaakko [iso-8859-15] Pr=E4tt=E4l=E4 wrote:

> Encouraged by Jesse's recent success I tried again,
> now with firmware rev 10. The module loads,
> firmware is loaded but with
> Hwdep ioctl error on card hw:0 : Input/output error.
>=20
> Still, to my disappointment,
> aplay -D hw:0,0 fails with

aplay -D plughw:0,0

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
