From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: newbew question
Date: Thu, 27 Jun 2002 16:07:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0206271606180.545-100000@pnote.perex-int.cz>
References: <20020627174200.29B7.RICHLIU@ite.techarea.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020627174200.29B7.RICHLIU@ite.techarea.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Richard Liu <richliu@ite.techarea.org>
Cc: ALSA-ML <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Jun 2002, Richard Liu wrote:

> Hi.
>    I have a question about how to porting ALSA device driver, 
> Our company have a AC97 codec, and I want to write ALSA driver for this 
> chip. I try to find ALSA website, but no document guide me how to 
> write a new device driver, does anyone help me ?

If you want to add a support for new AC97 codec, you don't need to write 
whole driver. Simply add the codec specific code to 
alsa-kernel/pci/ac97_codec.c or send me a datasheet. I'll do it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
