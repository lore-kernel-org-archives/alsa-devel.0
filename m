From: patrick reardon <swpatrick@earthlink.net>
Subject: Re: Hammerfall configuration
Date: Thu, 19 Dec 2002 13:15:53 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E021AE9.29565751@earthlink.net>
References: <200212190924.18p4pc1V73NZFji0@eagle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

it works!  disks burn correctly now.  thanks to everyone who helped me get this
straightened out, especially paul davis and joerg shilling.  in case it might help someone
else, i'm running a redhat based system and load the hammerfall modules at boot time with
this line added to /etc/rc.d/rc.sysinit: 

action "Loading ALSA Hammerfall driver" modprobe snd-rme9652

/etc/modules.conf is set to load soundcore and snd-rme9652-mem before snd-rme9652, so this
takes care of it.  to automatically set the hammerfall's internal clock as master (or use
any non-default configuration) , the line

action "Setting Hammerfall as master clock" alsactl restore snd-rme9652

can be added after the modprobe command.

patrick



Paul Davis wrote:
> 
> >by hand, changing the 'Sync Mode' value from AutoSync to Master
> >(should these values be in quotes?), ran "alsactl store hammerfall",
> >unloaded then reloaded the alsa m odules, then ran "alsactl restore
> >hammerfall.  ("hammerfall" is the card's id.)  but asound .state
> >still indicates Sync Mode is set to AutoSync.  "vi
> >/proc/asound/hammerfall/rme 9652" reads
> 
> you got the process wrong.
> 
> 1) alsactl store hammerfall
> 2) edit file
> 3) alsactl restore hammerfall
> 
> no driver unload/load is needed. each time you reload the module
> without the 3rd step, you get back to the driver's own default
> settings.
> 
> >i'm also curious if the "IEC958 sample rate: error flag set" is normal and if
> >not, what to
> >look at to fix it.  asound.state says
> 
> it means you have no s/pdif input.
> 
> --p


-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
