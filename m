From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_writei()  help!
Date: Tue, 12 Jul 2005 10:24:53 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507121023160.11996-100000@studcom.urz.uni-halle.de>
References: <42D2DFB2.9060203@Mountain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42D2DFB2.9060203@Mountain.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian Black <BlackBsd@Mountain.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Brian Black wrote:
> Sometimes i pass in a size to write and i am getting an error -22
> (Invalid argument) and sometimes the data writes out correctly.
>
>   while ((AlsaCallReturnCode = snd_pcm_writei(PCM_Handle,
>           ptrCurrentDataPosition, NumberOfSamplesToWrite)) < 0)

The size is in frames, not samples.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
