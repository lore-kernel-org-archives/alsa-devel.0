From: =?ISO-8859-1?Q?David_G=F3mez?= <dabisu@gmail.com>
Subject: Re: snd_intel8x0m and semaphore warning
Date: Wed, 5 Jan 2005 10:19:54 +0100
Message-ID: <ae4c7157050105011915abcf6e@mail.gmail.com>
References: <1104879394.3516.30.camel@shadow.local>
Reply-To: =?ISO-8859-1?Q?David_G=F3mez?= <dabisu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1104879394.3516.30.camel@shadow.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>
Cc: alsa-devel@lists.sourceforge.net, Sasha Khapyorsky <sashak@smlink.com>
List-Id: alsa-devel@alsa-project.org

Hi Nickolay ;),

On Wed, 05 Jan 2005 01:56:34 +0300, Nickolay V. Shmyrev
<nshmyrev@yandex.ru> wrote:
> Hi I know there was problems with sound card driver snd_intel8x0, now
> very often problem is the same kind of warning with snd_intel8x0m modem
> driver:

It's broken, at least in 2.6.10. In my case, if i loaded the modem
driver, the sound one stopped working (with a lot of semaphore
errors...) My solution is not using the modem driver by now :(. I
think that Takashi said that there was a problem in common
initialization in both drivers, so i hope it gets fixed soon ;)

regards,

--=20

David G=F3mez


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
