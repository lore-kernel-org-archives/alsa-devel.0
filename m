From: Ivica Ico Bukvic <ico@fuse.net>
Subject: Re: More issues with hdsp and 1.0.7 and 1.0.8 drivers
Date: Thu, 13 Jan 2005 22:53:26 -0500
Message-ID: <200501132253.26202.ico@fuse.net>
References: <200501132244.07541.ico@fuse.net>
Reply-To: ico@fuse.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200501132244.07541.ico@fuse.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 13 January 2005 22:44, Ivica Ico Bukvic wrote:
> RME Hammerfall DSP: no buffers available
> RME Hammerfall DSP: probe of 0000:02:00.0 failed with error -12
>
> I guess this has something to do with RAM being fragmented. Please correct
> me if I am wrong...

Never mind on that one. It seems that a simple restart of alsa service and 
then reinserting of the hdsp pcmcia did the trick. Yet it is odd that this 
does happen nonetheless...

This brings me to another interesting issue and that is that my system fails 
to unload the snd-hdsp once it is pulled out. As a matter of fact no logs 
point to the fact that the card was even pulled out, yet /proc/asound 
reflects that it is missing. Perhaps I should simply write some ugly daemon 
that checks whether the soundcard still exists in /proc/asound and if it 
doesn't to unload the module so that upon the next load it again 
automatically uploads firmware... Any ideas how I could do this with little 
or no impact on system performance?

Apologies to all for my incessant barrage of stuff. Just trying my best to 
provide devs with as much info as possible in order to get this pickle 
solved :-)

Best wishes,

Ico


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
