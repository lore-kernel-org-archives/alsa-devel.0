From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: cs4205 sp/dif support
Date: Tue, 2 Apr 2002 12:21:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0204021219120.544-100000@pnote.perex-int.cz>
References: <20020401164457.B21453@shaftnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20020401164457.B21453@shaftnet.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Stuffed Crust <pizza@shaftnet.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Apr 2002, Stuffed Crust wrote:

> Attached is a patch against ac97_codec.c (0.9.0beta12) that adds sp/dif
> support for the CS4205 AC97 codec.
> 
> CS was on some good crack when they designed this chip, as it appears to
> be otherwise fully AC97 compliant.  They used vendor-specific crap to 
> handle anything SP/DIF related despite there being a RightWay to do it.
> 
> Known bugs -- Well, it's never been tested with "real" data.  Not only
> do I not have the spdif dongle for my laptop, I don't have anything
> which will accept a spdif signal.  (Plus I don't know how to generate
> one anyway.. documentation is very sparse in that regard..)
> 
> I'm looking for feedback and someone [else] who can help me test this
> thing.  And of course, the critical eye of "gaah!  you mangled the
> otherwise beautiful ac97_codec.c file." is also welcome; I'll gladly
> rearrange stuff if there is a RightWay.

It would be better to add a new flag to ac97->flags like AC97_CS_SPDIF to 
avoid conditions via AC97 ID numbers (more codecs from Cirrus Logic can 
behave in same way and having separate conditions for each codecs makes 
code unreadable).

> 
> Other notes about the ac97_codec:
> 
> * The spdif sample rate bits are set incorrectly in the
>   IEC958_AES0_PROFESSIONALcase.
> 
> I can submit a seperate patch for this bug if so desired; it's fixed in
> the attached diff in any case.

It's not necessary, please redo the codec checks and I'll apply whole 
patch. Thanks for your work.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
