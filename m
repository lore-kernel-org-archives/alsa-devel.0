From: Thomas Tonino <ttonino@users.sourceforge.net>
Subject: Re: Re: [Alsa-user] C-Media 8738 SPDIF problem
Date: Sat, 16 Feb 2002 22:38:58 +0100
Message-ID: <a4mkjp$nbo$1@quimby2.netfonds.no>
References: <s5hr8ofaeah.wl@alsa1.suse.de>	<3C53D663.2080300@users.sf.net>	<s5helkaacy7.wl@alsa1.suse.de>	<3C556087.2020609@users.sf.net>	<s5h7kq2a42h.wl@alsa1.suse.de>	<3C586332.1060906@users.sf.net>	<s5hpu3qsz0p.wl@alsa1.suse.de> <s5hn0yustme.wl@alsa1.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thomas Tonino <ttonino@users.sourceforge.net>, alsa-user <alsa-user@alsa-project.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>
>Done.  Now committed cvs.
>please give a try.
>
Sorry for responding so late. Here are the results for the cmipci driver 
cvs version as of today:

I see no way to listen to a signal on the digital input.
In a standard setting, there is no signal on the normal analog output.

I can get analog out by:

unmute IEC958 Output
(this enables digital out, as expected)

unmute IEC958 In Monitor
(strangely enough, this routes the IEC output to the internal DAC)

When I input an spdif signal, this has no effect.

When I enable SPDIF loop, the SPDIF signal goes, but the internal DAC 
keeps playing with the above settings.

But both IEC958 Output and IEC958 In Monitor need to be enabled to get 
analog out.

But with SPDIF loop on, I see no way to get a signal in the coaxial 
input repeated on the output and/or DAC.


In the above setting, the PCM volume slider and mute controls have no 
effect.


Cheers,


Thomas




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
