From: Andrew Gaydenko <a@etver.com>
Subject: Re: ice1724, routing oss playing back to spdif
Date: Tue, 20 Apr 2004 21:31:50 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404202131.50981@goldspace.net>
References: <200404180050.32837@goldspace.net> <s5hekqjq6id.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekqjq6id.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


What is the starting point to configure the driver such way?
The aim is to use particular device (/dev/dsp, of cource :-).

======= On Tuesday 20 April 2004 14:38, you wrote: =======
At Sun, 18 Apr 2004 00:50:32 +0400,
Andrew Gaydenko wrote:
> 
> Hi,
> 
> The aim is to route oss-only-playing-back-software to spdif out.
> Is it possible? I use ice1724 driver.

it's possible through ALSA-OSS emulation library, but not through the
kernel OSS emulation.


Takashi




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
