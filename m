From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: Cirrus Logic S/PDIF
Date: Tue, 21 May 2002 13:02:21 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020521200221.GC3579@porky>
References: <20020517152415.GA872@porky> <s5helg5hj6w.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5helg5hj6w.wl@alsa2.suse.de>; from tiwai@suse.de on Tue, May 21, 2002 at 03:46:47 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.05.21 03:46 Takashi Iwai wrote:
> well, we need to check spec sheets to be sure.
> could you tell us which chips did you check (to be supposed to work)?

    I've looked through some spec sheets, and these are the chips that 
seem to be compatible with patch_cirrus_cs4205():

CS4201:   compatible
CS4298:   compatible. Register 5Eh (MODE_CS4205) doesn't seem to 
use             AMAP bit (0x0080), but that shouldn't affect anything
CS4299:   compatible. Maybe call patch_cirrus_cs4205() from
             patch_cirrus_4299()

    I've only checked those AC'97 codecs that are supported already. More 
codecs may support this patch, but I haven't checked any of the codecs not
listed in ac97_codec.c yet.

-- Peter Heatwole
"Murphy was just a well known pessimist."

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
