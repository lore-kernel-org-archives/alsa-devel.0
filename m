From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: cs46xx experimental DSP drivers
Date: Tue, 24 Sep 2002 20:03:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D90A8D8.7070103@cucumelo.org>
References: <3D8F7F59.6030105@prism.gatech.edu>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Weijia Yang <gte733z@prism.gatech.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I am testing out the cs46xx experimental DSP drivers on the 9/22 cvs 
> build on a TB Santa Cruz. The drivers work fine except for the fact 
> that all sound is "flat"--almost no base at all. This is in comparison 
> to the original cs46xx drivers that come with rc3. The sound quality 
> difference is very noticeable. I have tried tweaking with all the 
> mixer settings with no result. I have also tried the experimental DSP 
> drivers on the rc3 build with the same results. Anyone know a fix? Thanks 


It's hard to say what the problem can be. The Santa Cruz card have been 
reported to work fine.
Maybe it's the soundcard amplifier possibly is turned off, have you
tried with "external_amp=1" ???

Can you do a "lspci -a" and a "lspci -a -n" send me the output, just to 
check
is your card possibly has a different vendor/ID.

/Benny





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
