From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Getting a full device list (was: alsa-lib
 functions reporting conflicting information with two sound cards)
Date: Fri, 11 May 2007 12:35:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0705111233090.7579@tm8103.perex-int.cz>
References: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>
	<75b66ecd0704190846g4036b493q8d7c2bec8cdc08b2@mail.gmail.com>
	<4627B015.7030401@gmail.com>
	<75b66ecd0704191145u3414a5e6id9e3f10ef9c6b854@mail.gmail.com>
	<4644455B.4080706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 56CEF2447F
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 12:35:29 +0200 (CEST)
In-Reply-To: <4644455B.4080706@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicholas Smethurst <nick.smethurst@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 11 May 2007, Nicholas Smethurst wrote:

> Is this possible? If not, can we work towards implementing such
> functionality?

User or system software manager should create a configuration which is 
suitable for users. You're trying to overload the user settings. Why?
Use information returned without any hacks in your application (you may 
eventually describe in documentation, how users can get more devices).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
