From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ymfpci, big-endian, and spdif out
Date: Sun, 5 Jan 2003 15:31:09 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301051530140.500-100000@pnote.perex-int.cz>
References: <20030104184435.GM28177@altus.drgw.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030104184435.GM28177@altus.drgw.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Troy Benjegerdes <hozer@hozed.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 4 Jan 2003, Troy Benjegerdes wrote:

> So what is the simplest command line options and .asoundrc config file 
> setup I should try to verify if SPDIF AC/3 output works? I also need to 

It should work simply typing 'ac3dec -C <ac3file>'.

> get a short AC3 encoded sound file somewhere.. are there some directions 
> or a FAQ on how to extract an AC3 sound file from a DVD?

See alsa-tools/ac3dec/tools directory (there is extract_ac3 utility).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
