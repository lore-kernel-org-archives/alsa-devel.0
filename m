From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Envy24-VT1712 Interrupt by Input Lines
Date: Thu, 24 Apr 2003 10:32:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304241027180.1351-100000@pnote.perex-int.cz>
References: <3EA6DA36.77BD0E0D@masirv.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EA6DA36.77BD0E0D@masirv.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chien Lee <Chien.Lee@mascorp.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Apr 2003, Chien Lee wrote:

> Hi,
> 
> I have a question regarding to how to find out which input line
> (PSDIN0-PSDIN3)
> is interrupting Envy24-VT1712 PCI Audio Controller.
> 
> VT1712's Professional Multi-Track Control Register MT00 provides bit 1
> for
> Multi-track record interrupt status. It only shows that there is an
> interrupt occurred
> for recording. It does not indentify which input line is the source. If
> I am recording
> PSDIN1audio signal and there is signal present at PSDIN0, I would get
> interrupted
> and record a wrong signal from PSDIN0.
> 
> Is there any way that I can find out which input line is interrupting
> the chip?

All input lines are captured at once in interleaved sample frames.
There is 12 capture channels. Hardware vendors usually connects 0-7 
channels as analog, 8-9 as S/PDIF and 10-11 is the digital stereo mixer 
which contains result of playback and captured channels controlled with
a matrix mixer.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
