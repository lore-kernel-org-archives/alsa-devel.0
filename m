From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: 1.0.13 and hdsp cardbus
Date: Sat, 7 Oct 2006 14:41:35 +0400
Message-ID: <70a871c80610070341q3104c89ne76bd70dd6be035e@mail.gmail.com>
References: <70a871c80610050541r73bbc2d7j408595802bb2c43f@mail.gmail.com>
	<4525F73D.2040105@chello.at>
	<70a871c80610060027l4196fdfi7b7ecd215733a7b3@mail.gmail.com>
	<45264A94.6010504@chello.at>
	<70a871c80610060709s73c87f03u31f4e91af077da46@mail.gmail.com>
	<4526D56E.1000904@chello.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4526D56E.1000904@chello.at>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Karl Grill <kgrill@chello.at>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10/7/06, Karl Grill <kgrill@chello.at> wrote:
> Sorry for my mistake, I just didn't realize that lspci is not quite
> consistent about using decimal or hex, so, in a way, we were both right.
> Your card revision (0x35) is the latest, and I'm quite surprised taht
> you had it working (all the reports I heard up to now were negative, but
> equally unanimously people reported success after a flash downgrade).
> Maybe you can alternatively downgrade the alsa driver - if you try,
> please keep me informed about your fate. BTW, does the card work with
> the 1.0.13 driver if you insert it with the iobox plugged in and turned
> on (or does it at least refrain from freezing your system)?

iobox turned on and plugged:

1) booting with plugged cardbus
    card works
   after unplugging, writes: card ejected from slot 0
   all subsequent cardbus insertions/removals are not detected.
   Not a single word in syslog.

2) booting without cardbus
    all insertions/removals are detected and card works ok.

Please, take a look into my thread "1.0.13 and indigoio", seems
there's a bug in the kernel:
it in some cases does not notify driver about cardbus removal.

Regards,

Dmitry.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
