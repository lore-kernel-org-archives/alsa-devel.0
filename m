From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: new rollback commits (was Re: [alsa-cvslog] ROLLBACK!
	alsa-kernel: ac97_codec (ALC655): add EAPD hack for MSI	L725 laptop)
Date: Thu, 05 Oct 2006 12:10:45 +0200
Message-ID: <m2lknv6pju.fsf@vador.mandriva.com>
References: <ALOGGER1160034648.34@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EC235168
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 12:10:50 +0200 (MEST)
Received: from vador.mandriva.com (anakin.mandrakesoft.com [192.168.100.54])
	by office.mandriva.com (Postfix) with ESMTP id ED61F21D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 12:10:45 +0200 (CEST)
Received: from vador.mandriva.com (vador.mandriva.com [127.0.0.1])
	by vador.mandriva.com (Postfix) with ESMTP id C04BC1BCC6
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 12:10:45 +0200 (CEST)
In-Reply-To: <ALOGGER1160034648.34@alsa-project.org> (Takashi Iwai's message
	of "Thu, 5 Oct 2006 09:50:48 +0200 (CEST)")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> The rollback was triggered. The repository was rolled back to
> the changeset number bellow. All patches on top of this changeset
> were lost.
> 
> changeset:   4582:9233e1d82ed045609e1fb76acf00696393589031
> tag:         tip
> user:        perex
> date:        Thu Oct 05 09:30:36 2006 +0200
> files:       pci/ac97/ac97_patch.c
> description:
> ac97_codec (ALC655): add EAPD hack for MSI L725 laptop
> New PCI ID described and tested Spectr <spectr@gmail.com> .

I think that:
- the reason of the rollback should be visible and the mail (aka the
  rollback commit changelog)
- the rollback commit changelog) should be in the suject line rather
  than the changelog of the commit we reverse to, since it's more
  important

my 2 cents.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
