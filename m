From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Cirrus Logic S/PDIF
Date: Wed, 22 May 2002 10:06:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0205221005060.612-100000@pnote.perex-int.cz>
References: <20020521200221.GC3579@porky>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020521200221.GC3579@porky>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Heatwole <peter599@gotnet.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 21 May 2002, Peter Heatwole wrote:

> On 2002.05.21 03:46 Takashi Iwai wrote:
> > well, we need to check spec sheets to be sure.
> > could you tell us which chips did you check (to be supposed to work)?
> 
>     I've looked through some spec sheets, and these are the chips that 
> seem to be compatible with patch_cirrus_cs4205():
> 
> CS4201:   compatible
> CS4298:   compatible. Register 5Eh (MODE_CS4205) doesn't seem to 
> use             AMAP bit (0x0080), but that shouldn't affect anything

I haven't S/PDIF register in the CS4294 datasheet. Do you have CS4298 
datasheet?

> CS4299:   compatible. Maybe call patch_cirrus_cs4205() from
>              patch_cirrus_4299()

I'm working on it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
