From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Hammerfall configuration
Date: Thu, 19 Dec 2002 12:28:17 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18P4P6-0007wa-00@sc8-sf-list1.sourceforge.net>
References: <3E01FA02.D0B4CD44@earthlink.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 19 Dec 2002 10:55:30 CST."
             <3E01FA02.D0B4CD44@earthlink.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: patrick reardon <swpatrick@earthlink.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>by hand, changing the 'Sync Mode' value from AutoSync to Master
>(should these values be in quotes?), ran "alsactl store hammerfall",
>unloaded then reloaded the alsa m odules, then ran "alsactl restore
>hammerfall.  ("hammerfall" is the card's id.)  but asound .state
>still indicates Sync Mode is set to AutoSync.  "vi
>/proc/asound/hammerfall/rme 9652" reads

you got the process wrong.

1) alsactl store hammerfall 
2) edit file
3) alsactl restore hammerfall

no driver unload/load is needed. each time you reload the module
without the 3rd step, you get back to the driver's own default
settings.

>i'm also curious if the "IEC958 sample rate: error flag set" is normal and if 
>not, what to
>look at to fix it.  asound.state says

it means you have no s/pdif input.

--p


-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
