From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [ibm-acpi-devel] Adding a alsa mixer interface to
	ibm-acpi
Date: Wed, 7 Mar 2007 18:41:26 -0500
Message-ID: <41840b750703071541x1bb60a2ch2aad519e9a7fd63c@mail.gmail.com>
References: <20070225012017.GA19039@khazad-dum.debian.net>
	<s5h649pue8z.wl%tiwai@suse.de>
	<20070226162819.GE2909@khazad-dum.debian.net>
	<s5hr6scswnp.wl%tiwai@suse.de>
	<20070226174145.GF2909@khazad-dum.debian.net>
	<20070227015024.GF8154@thunk.org>
	<20070227021402.GC6828@khazad-dum.debian.net>
	<s5hd53kaf5r.wl%tiwai@suse.de>
	<41840b750703071512o1d171dfy9d2a615382e5e635@mail.gmail.com>
	<1173309834.4531.22.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1173309834.4531.22.camel@razman.gruemaster.com>
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
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Takashi Iwai <tiwai@suse.de>, ibm-acpi-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, Theodore Tso <tytso@mit.edu>
List-Id: alsa-devel@alsa-project.org

On 3/7/07, Tobin Davis <tdavis@dsl-only.net> wrote:
>  On Wed, 2007-03-07 at 18:12 -0500, Shem Multinymous wrote:
>
>      The ibm-acpi mixer also affects the BIOS-generated sounds (e.g.,
>      low-battery warnings) and PC speaker. So it useful even when the sound
>      card is unused or unsupported.
>
>   Don't those sounds go through the beep generator?  Most codecs use a beep
>  generator for system sounds, that routes through the codec.

In my ThinkPad the system sound volume is affected by ibm-acpi but not
by any ALSA mixer settings. As far as I can tell, it behaves as if
AC'97 (including all ALSA mixers) and system sound are generated
independently, added together, and then scaled by the ibm_acpi mixer.

  Shem

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
