From: "Sander van Leeuwen" <sandervl@xs4all.nl>
Subject: Sample rate mask
Date: Wed, 27 Feb 2002 11:44:30 +0100 (CET)
Message-ID: <200202271043.g1RAht1d048742@smtpzilla1.xs4all.nl>
Reply-To: "Sander van Leeuwen" <sandervl@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.44.0201251612190.1093-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

How can an application retrieve the supported sample rates? (SNDRV_PCM_RATE* flags)
I know you can get the min and max sample rate, but it's more interesting
to know exactly which sample rates the hardware supports (if not continuous).

Maybe I didn't RTFM carefully enough, but I haven't found any way to do this. The ALSA
(kernel) sources suggest this isn't possible.

Thanks,

Sander


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
