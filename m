From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: Envy24Control and wordclock
Date: Sun, 13 Jun 2004 11:47:06 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1087145226.13302.4.camel@eviltwin>
References: <012401c45164$df651660$f7143052@cfd86qjdqauxzj>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <012401c45164$df651660$f7143052@cfd86qjdqauxzj>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michele Spinolo <michele.spinolo@tin.it>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Just curious, I've got the ST Audio DSP 2000 and it uses S/PDIF to
sync.  Does the EWS use the same method?  If so you should set card 0's
Master Clock to whatever you want it to be and then the other two should
be set to S/PDIF In.  If the EWS doesn't use S/PDIF for sync I don't
know what you should do.  I don't have "word clock" under Master Clock
either.

Jan


On Sun, 2004-06-13 at 11:38, Michele Spinolo wrote:
> Hi guys,
> 
> I installed 3 Terratec EWS88D in my system, which are properly
> recognized
> and now, after some work, work fine.
> 
> Using the command envy24control -c x (x=0,1,2) I can manage HW
> settings of
> different soundcards, bun under "hardware settings", "master clock" I
> can't
> find "wordclock" option which permits to sync the different boards.
> The boards are connected by their internal wordclock propetary cable,
> the
> problem seems the driver or envy24control do not recognize this option
> the
> soundcard has.
> 
> Thanks!
> Michele
> 
> P.S. Sorry If I double posted, but I had a problem with my mail
> server!:-(
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
