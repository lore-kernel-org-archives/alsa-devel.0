From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Mixer chanel naming
Date: Fri, 8 Mar 2002 17:22:33 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0203081719070.553-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.BSF.4.44.0203081354580.28275-100000@fest.stud.fee.vutbr.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 8 Mar 2002, Kasparek Tomas wrote:

> Hi,
> 
> I've just started writing driver for Compaq iPAQ and I'm feel realy dizzy
> from setting the mixer. Here is part of code:
> 
> ...
> static snd_kcontrol_new_t snd_h3600_controls[] = {
> H3600_SINGLE("Master Playback Switch", H3600_MASTER, 15, 1, 1),
> H3600_DOUBLE("Master Playback Volume", H3600_MASTER, 8, 0, 31, 1),
> ...
> 
> First argument is used for "name" item of snd_kcontrol_new_t structure.
> It look like the name is significant when configuring this new control.
> 
> (e.g. without "playback", alsamixer shows two devices for one entry)
> 
> Where should I find information of possible names and mainly their
> meaning? How functionality of such defined control depends on this name?

The recommended names for controls are defined in 
the alsa-driver/doc/ControlNames document (should be probably moved to 
alsa-kernel/Documentation).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
