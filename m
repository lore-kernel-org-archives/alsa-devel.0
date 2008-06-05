From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: aplay works but not real player
Date: Thu, 05 Jun 2008 11:32:03 -0700
Message-ID: <48483123.7050504@cox.net>
References: <827ad74d0806050426o787c34eo49432eea5abdeee6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao107.cox.net (fed1rmmtao107.cox.net [68.230.241.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A82E24344
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 20:32:05 +0200 (CEST)
In-Reply-To: <827ad74d0806050426o787c34eo49432eea5abdeee6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha priya gupta <harshapriya@gmail.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Harsha priya gupta wrote:
> I am using .copy function in my driver.
> aplay playes any .wav file given. When i open real player and try playing it
> says device is busy.
> I tried the earlier advice to write the following into ~./asoundrc but does
> not help
> pcm.!default{
> type hw
> card 0
> }
>
> any clue that can help me ?
>
>   
Have you got realaudio configured to use alsa or oss?  If oss, do you 
have package aoss installed,
the alsa oss emulation layer?  Whatever device it wants to use is
in use by something else.  A sound server can cause this problem as well.

Try with something like xmms or audacity also.

The fact that aplay can play means this is a configuration issue.
