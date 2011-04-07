From: "Gabriel Schulhof" <nix@go-nix.ca>
Subject: Re: Conexant CX20585 recording does not work
Date: Thu, 7 Apr 2011 16:21:15 +0300 (EEST)
Message-ID: <10176.91.152.175.130.1302182475.squirrel@go-nix.ca>
References: <10033.91.152.175.130.1302179699.squirrel@go-nix.ca>
	<4D9DB125.6010600@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fipsb01.cogeco.net (smtp1.cogeco.ca [216.221.81.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C35B103854
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 15:21:21 +0200 (CEST)
In-Reply-To: <4D9DB125.6010600@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

On Thu, April 7, 2011 15:42, David Henningsson wrote:
> Please try the model quirk "hp-laptop". In Ubuntu that would be adding
> the line:
>
> options snd-hda-intel model=hp-laptop
>
> to the file /etc/modprobe.d/alsa-base.conf

Tried it. It did streamline the options available in alsamixer, but it
didn't make recording work.

I tried the skype test call, as well as arecord, and both did not only not
record anything, but they didn't even record static. That is, the
recording device seems to block! For example, the skype test call beeps
before it plays back my recorded voice, and afterwards. Well, the two
beeps were consecutive for me :(

Also, arecord with no options outputs to the terminal. It output the
header for the sound file, but the cursor did not start to fly across the
terminal drawing all kinds of junk.

Thanks a lot for your help,



Gabriel
