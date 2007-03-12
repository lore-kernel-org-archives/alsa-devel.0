From: "Stephen Hassard" <steve@hassard.net>
Subject: Re: Adding MSI RS482M4 motherboard to Intel HDA driver
Date: Mon, 12 Mar 2007 13:18:56 -0700
Message-ID: <e4fbff80703121318k5b2b2376vbda6b9920660dbaa@mail.gmail.com>
References: <e4fbff80703121116x2119bcccp829c9acd5c61f341@mail.gmail.com>
	<75b66ecd0703121123k5f74026bk9d4e1cd09c491433@mail.gmail.com>
	<e4fbff80703121208i386d54cbwa21ba2d1a8232436@mail.gmail.com>
	<75b66ecd0703121209h7ad6542dg8d02031644f3839d@mail.gmail.com>
	<e4fbff80703121223u2f36c043he5b2b1fe8df8348d@mail.gmail.com>
	<s5h1wjuw7th.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h1wjuw7th.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 3/12/07, Takashi Iwai <tiwai@suse.de> wrote:
> Hm, the codec bit 3 is used for this device although this is out of
> range defined in ICH controllers.  Maybe an extenion by ATI chip.
>
> Could you try the patch below?  This reverts the max number of codecs
> to 4, which was used in the ealier version.  If this works, we may
> need to define AZX_MAX_CODECS selectively according to the controller
> and/or the device SSID.

This patch fixes the problem.

snd-hda-intel detects the codec properly now:

 cat /proc/asound/cards
 0 [SB             ]: HDA-Intel - HDA ATI SB
                     HDA ATI SB at 0xfe9e8000 irq 18

It also outputs fine. madplay is playing audio fine through both the
front and back panel headers.

Thanks,
Steve Hassard

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
