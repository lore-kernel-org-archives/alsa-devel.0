From: Howard Abrams <abramsh@acm.org>
Subject: Re: Application using ALSA-driver es-1968 for Maestro-2e: Bug or my fault?
Date: Fri, 21 Jun 2002 10:32:34 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D136332.1000903@acm.org>
References: <3D0DAEC0.F063CB35@ind.rwth-aachen.de>	<3D0E4DE5.5040308@acm.org> <s5hlm98aglk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry, I didn't mean to mislead you, I am not using the analog on the
chip. I am going directly in via the coax digital in. From what I
understand the board should do "sample-perfect" transfers, but similar
to the es1968, half my samples seem to be garbage. Playback is
perfect, it is just recording that is broke (arecord or my own code).

Your right, it may not be related, but where do I begin to figure out
what is wrong? Does anyone reading this have a board like mine?

h.

Takashi Iwai wrote:

> At Mon, 17 Jun 2002 14:00:21 -0700,
> Howard Abrams wrote:
> 
>>I am havine a similar problem on my m-audio dio 2448 (CMI8738 model 37).
>>In my own code, or using arecord, some of the samsples are correct, but
>>some are very wrong, and make a loud clicking noise.
>>
> 
> i believe your problem is not related with the one on es1968.
> and i guess it's a hardware problem...
> the analog i/o on cm8738 is very bad, although its digital i/o is
> nice.
> 
> 
> Takashi
> 
> 




-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
